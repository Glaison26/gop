<?php
session_start();

// Verificar autenticação
if (!isset($_SESSION['id_usuario'])) {
    header("Location: ../login.php");
    exit;
}

// conexao com banco de dados sem usar conexao.php para usar PDO
$host = 'localhost';
$db   = 'gop';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';
$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];
try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    die("Erro na conexão com o banco de dados: " . $e->getMessage());
}   


// pego id da solicitacao
$id_solicitacao = $_GET['solicitacao_id'] ?? null;
$id_usuario = $_SESSION['id_usuario'];
$mensagem = '';
$tipo_mensagem = '';

// Validar id_solicitacao
if (!$id_solicitacao) {
    header("Location: solicitacao_detalhe.php");
    exit;
}

// Processar upload de anexo
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['arquivo'])) {
    if ($_FILES['arquivo']['error'] === UPLOAD_ERR_OK) {
        $arquivo_tmp = $_FILES['arquivo']['tmp_name'];
        $arquivo_nome = basename($_FILES['arquivo']['name']);
        $extensoes_permitidas = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'jpg', 'jpeg', 'png', 'txt'];
        $ext = strtolower(pathinfo($arquivo_nome, PATHINFO_EXTENSION));

        if (!in_array($ext, $extensoes_permitidas)) {
            $mensagem = "Extensão de arquivo não permitida.";
            $tipo_mensagem = "erro";
        } else {
            $diretorio = '../uploads/anexos/';
            if (!is_dir($diretorio)) {
                mkdir($diretorio, 0755, true);
            }

            $arquivo_nome_unico = time() . '_' . preg_replace('/[^a-zA-Z0-9._-]/', '', $arquivo_nome);
            $caminho_arquivo = $diretorio . $arquivo_nome_unico;

            if (move_uploaded_file($arquivo_tmp, $caminho_arquivo)) {
                $data = date('Y-m-d');
                $hora = date('H:i:s');
                $caminho_relativo = 'uploads/anexos/' . $arquivo_nome_unico;

                try {
                    $sql = "INSERT INTO anexos (id_solicitacao, arquivo, data, hora, id_usuario) 
                            VALUES (:id_solicitacao, :arquivo, :data, :hora, :id_usuario)";
                    $stmt = $pdo->prepare($sql);
                    $stmt->execute([
                        ':id_solicitacao' => $id_solicitacao,
                        ':arquivo' => $caminho_relativo,
                        ':data' => $data,
                        ':hora' => $hora,
                        ':id_usuario' => $id_usuario
                    ]);

                    $mensagem = "Arquivo enviado com sucesso!";
                    $tipo_mensagem = "sucesso";
                } catch (PDOException $e) {
                    $mensagem = "Erro ao salvar no banco de dados.";
                    $tipo_mensagem = "erro";
                }
            } else {
                $mensagem = "Erro ao fazer upload do arquivo.";
                $tipo_mensagem = "erro";
            }
        }
    } else {
        $mensagem = "Erro no upload do arquivo.";
        $tipo_mensagem = "erro";
    }
}

// Listar anexos
$anexos = [];
try {
    $sql = "SELECT id, arquivo, data, hora FROM anexos WHERE id_solicitacao = :id_solicitacao ORDER BY data DESC, hora DESC";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([':id_solicitacao' => $id_solicitacao]);
    $anexos = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $mensagem = "Erro ao listar anexos.";
    $tipo_mensagem = "erro";
}

// Processar exclusão de anexo
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['deletar_id'])) {
    $deletar_id = $_POST['deletar_id'];
    try {
        $sql = "SELECT arquivo FROM anexos WHERE id = :id AND id_solicitacao = :id_solicitacao";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([':id' => $deletar_id, ':id_solicitacao' => $id_solicitacao]);
        $anexo = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($anexo) {
            $caminho = '../' . $anexo['arquivo'];
            if (file_exists($caminho)) {
                unlink($caminho);
            }

            $sql = "DELETE FROM anexos WHERE id = :id";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([':id' => $deletar_id]);

            $mensagem = "Anexo removido com sucesso!";
            $tipo_mensagem = "sucesso";

            // Recarregar lista de anexos
            $sql = "SELECT id, arquivo, data, hora FROM anexos WHERE id_solicitacao = :id_solicitacao ORDER BY data DESC, hora DESC";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([':id_solicitacao' => $id_solicitacao]);
            $anexos = $stmt->fetchAll(PDO::FETCH_ASSOC);
        }
    } catch (PDOException $e) {
        $mensagem = "Erro ao deletar anexo.";
        $tipo_mensagem = "erro";
    }
}

$pagina_anterior = $_GET['voltar'] ?? 'solicitacao_detalhe.php';
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciar Anexos</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            max-width: 800px;
            width: 100%;
            padding: 30px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #667eea;
            padding-bottom: 15px;
        }

        h1 {
            color: #333;
            font-size: 28px;
        }

        .btn-voltar {
            background-color: #6c757d;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
        }

        .btn-voltar:hover {
            background-color: #5a6268;
        }

        .mensagem {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            display: none;
        }

        .mensagem.sucesso {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            display: block;
        }

        .mensagem.erro {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            display: block;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }

        input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 2px dashed #667eea;
            border-radius: 5px;
            background-color: #f8f9fa;
            cursor: pointer;
            transition: border-color 0.3s;
        }

        input[type="file"]:hover {
            border-color: #764ba2;
        }

        .btn-enviar {
            background-color: #667eea;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: background-color 0.3s;
            width: 100%;
        }

        .btn-enviar:hover {
            background-color: #764ba2;
        }

        .anexos-list {
            margin-top: 30px;
        }

        .anexos-list h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 20px;
        }

        .anexo-item {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-left: 4px solid #667eea;
        }

        .anexo-info {
            flex: 1;
        }

        .anexo-nome {
            color: #333;
            font-weight: 600;
            margin-bottom: 5px;
            word-break: break-all;
        }

        .anexo-detalhes {
            color: #666;
            font-size: 13px;
        }

        .anexo-acoes {
            display: flex;
            gap: 10px;
            margin-left: 15px;
        }

        .btn-download {
            background-color: #28a745;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
        }

        .btn-download:hover {
            background-color: #218838;
        }

        .btn-deletar {
            background-color: #dc3545;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            transition: background-color 0.3s;
        }

        .btn-deletar:hover {
            background-color: #c82333;
        }

        .vazio {
            text-align: center;
            color: #999;
            padding: 20px;
            font-style: italic;
        }

        .info-nota {
            background-color: #e7f3ff;
            color: #004085;
            padding: 12px;
            border-radius: 5px;
            font-size: 13px;
            margin-bottom: 20px;
            border-left: 4px solid #004085;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Gerenciar Anexos</h1>
            <a href="<?php echo htmlspecialchars($pagina_anterior); ?>" class="btn-voltar">← Voltar</a>
        </div>

        <?php if ($mensagem): ?>
            <div class="mensagem <?php echo $tipo_mensagem; ?>">
                <?php echo htmlspecialchars($mensagem); ?>
            </div>
        <?php endif; ?>

        <div class="info-nota">
            <strong>ID da Solicitação:</strong> <?php echo htmlspecialchars($id_solicitacao); ?>
        </div>

        <form method="POST" enctype="multipart/form-data">
            <div class="form-group">
                <label for="arquivo">Selecione um arquivo para anexar:</label>
                <input type="file" id="arquivo" name="arquivo" required accept=".pdf,.doc,.docx,.xls,.xlsx,.jpg,.jpeg,.png,.txt">
                <small style="color: #666; display: block; margin-top: 5px;">
                    Formatos permitidos: PDF, DOC, DOCX, XLS, XLSX, JPG, JPEG, PNG, TXT
                </small>
            </div>
            <button type="submit" class="btn-enviar">📤 Enviar Anexo</button>
        </form>

        <div class="anexos-list">
            <h2>Anexos da Solicitação</h2>
            <?php if (count($anexos) > 0): ?>
                <?php foreach ($anexos as $anexo): ?>
                    <div class="anexo-item">
                        <div class="anexo-info">
                            <div class="anexo-nome">📎 <?php echo htmlspecialchars(basename($anexo['arquivo'])); ?></div>
                            <div class="anexo-detalhes">
                                Data: <?php echo date('d/m/Y', strtotime($anexo['data'])); ?> | 
                                Hora: <?php echo substr($anexo['hora'], 0, 5); ?>
                            </div>
                        </div>
                        <div class="anexo-acoes">
                            <a href="<?php echo '../' . htmlspecialchars($anexo['arquivo']); ?>" class="btn-download" download>⬇️ Download</a>
                            <form method="POST" style="display: inline;" onsubmit="return confirm('Deseja remover este anexo?');">
                                <input type="hidden" name="deletar_id" value="<?php echo $anexo['id']; ?>">
                                <button type="submit" class="btn-deletar">🗑️ Deletar</button>
                            </form>
                        </div>
                    </div>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="vazio">Nenhum anexo encontrado para esta solicitação.</div>
            <?php endif; ?>
        </div>
    </div>
</body>
</html>