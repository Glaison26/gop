<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
include("../links2.php");
$c_id = $_GET["id"];
$data_atual = date('d/m/Y');

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/ordens/ordens_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    $c_sql = "select ordens.tipo from ordens where ordens.id='$c_id'";
    $result = $conection->query($c_sql);
    $c_linha = $result->fetch_assoc();

    // leitura da ordem de serviço
    $c_sql = "SELECT ordens.id, ordens.data_geracao, hora_geracao, data_previsao, hora_previsao, data_inicio, hora_inicio, ordens.descricao, ordens.conclusao,
    ordens.tipo, ocorrencias.descricao as ocorrencia, executores.nome as executor_responsavel,";

    if ($c_linha['tipo'] == 'R')
        $c_sql = $c_sql . "recursos.descricao as recurso,";
    if ($c_linha['tipo'] == 'E')
        $c_sql = $c_sql . "espacos.descricao as espaco,";
    $c_sql = $c_sql . "  case
        when tipo_ordem='C' then 'Corretiva'
        when tipo_ordem='P' then 'Preventiva'
        END AS ordens_tipo_texto,
        setores.descricao AS setor, usuarios.nome AS solicitante  
    FROM ordens";
    if ($c_linha['tipo'] == 'R')
        $c_sql = $c_sql . " JOIN recursos ON ordens.id_recurso=recursos.id";
    if ($c_linha['tipo'] == 'E')
        $c_sql = $c_sql . " JOIN espacos ON ordens.id_espaco=espacos.id";
    $c_sql = $c_sql . " JOIN ocorrencias ON ordens.id_ocorrencia=ocorrencias.id  
        JOIN setores ON ordens.id_setor=setores.id
        JOIN usuarios ON ordens.id_solicitante=usuarios.id
        join executores on ordens.id_executor_responsavel=executores.id
        where ordens.id='$c_id'";
    // echo $c_sql;
    $result = $conection->query($c_sql);
    $c_linha = $result->fetch_assoc();
    // sql para pegar material utilizado na ordem de serviço contendo o nome do material, quantidade, unidades de medida usando a tabela ordens_materiais
    $c_sql_materiais = "SELECT materiais.descricao, ordens_materiais.quantidade, unidades.descricao as unidade_medida FROM ordens_materiais
    JOIN materiais ON ordens_materiais.id_material=materiais.id
    JOIN unidades ON materiais.id_unidadeSaida=unidades.id
    where ordens_materiais.id_ordem='$c_id'";
    $result_materiais = $conection->query($c_sql_materiais);

    // sql para pegar os executores envolvidos na ordem de serviço usando a tabela ordens_executores
    $c_sql_executores = "SELECT executores.nome, funcoes.descricao as funcao FROM ordens_executores
    JOIN executores ON ordens_executores.id_executor=executores.id
    JOIN funcoes ON executores.id_funcao=funcoes.id
    where ordens_executores.id_ordem='$c_id'";
    $result_executores = $conection->query($c_sql_executores);

    // gero arquivo texto com os dados da ordem de serviço para ser impresso
    $c_arquivo = "impressao\ordem_servico_" . $c_linha['id'] . ".txt";
    $c_conteudo = "Ordem de Serviço Nº: " . $c_linha['id'] . "\n";
    $c_conteudo = $c_conteudo . "Data de Geração: " . date('d/m/Y', strtotime($c_linha['data_geracao'])) . " Hora: " . $c_linha['hora_geracao'] . "\n";
    $c_conteudo = $c_conteudo . "Previsão de Entrega: " . date('d/m/Y', strtotime($c_linha['data_previsao'])) . " Hora: " . $c_linha['hora_previsao'] . "\n";
    
    $c_conteudo = $c_conteudo . "Previsão de Inicio: " . date('d/m/Y', strtotime($c_linha['data_inicio'])) . " Hora: " . $c_linha['hora_inicio'] . "\n";
    $c_conteudo = $c_conteudo . "Solicitante: " . $c_linha['solicitante'] . "\n";
    $c_conteudo = $c_conteudo . "Setor: " . $c_linha['setor'] . "\n";
    if ($c_linha['tipo'] == 'R')
        $c_conteudo = $c_conteudo . "Recurso: " . $c_linha['recurso'] . "\n";
    if ($c_linha['tipo'] == 'E')
        $c_conteudo = $c_conteudo . "Espaço: " . $c_linha['espaco'] . "\n";
    $c_conteudo = $c_conteudo . "Tipo de Ordem: " . $c_linha['ordens_tipo_texto'] . "\n";
    $c_conteudo = $c_conteudo . "Ocorrência: " . $c_linha['ocorrencia'] . "\n";
    $c_conteudo = $c_conteudo . "Executor Responsável: " . $c_linha['executor_responsavel'] . "\n";
    $c_conteudo = $c_conteudo . "Descrição: " . $c_linha['descricao'] . "\n";
    file_put_contents($c_arquivo, $c_conteudo);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
    <!-- Gera a ordem de serviço -->
    <div class="container mt-3">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h4>Ordem de Serviço - Emissão - Coordenação de Informática da Prefeitura Municipal de Sabará</h4>
            </div>
            <div class="conteudo">
                <h1 class="card-title">Ordem de Serviço Nº: <?php echo $c_linha['id']; ?></h1>
                <!-- linha para separar o título dos dados da ordem de serviço -->
                <p>
                    <hr>
                </p>
                <h3>
                    <p class="card-text"><strong>Data de Geração:</strong> <?php echo date('d/m/Y', strtotime($c_linha['data_geracao'])); ?>
                        &nbsp;&nbsp;&nbsp;<strong>Hora:</strong> <?php echo $c_linha['hora_geracao']; ?></p>
                    <p class="card-text"><strong>Previsão de Entrega:</strong> <?php echo date('d/m/Y', strtotime($c_linha['data_previsao'])); ?>
                        &nbsp;&nbsp;&nbsp;<strong>Hora:</strong> <?php echo $c_linha['hora_previsao']; ?></p>
                    <p class="card-text"><strong>Data de inicio:</strong> <?php echo date('d/m/Y', strtotime($c_linha['data_inicio'])); ?>
                        &nbsp;&nbsp;&nbsp;<strong>Hora:</strong> <?php echo $c_linha['hora_inicio']; ?></p>
                    <p class="card-text"><strong>Solicitante:</strong> <?php echo $c_linha['solicitante']; ?></p>
                    <p class="card-text"><strong>Setor:</strong> <?php echo $c_linha['setor']; ?></p>
                    <?php
                    if ($c_linha['tipo'] == 'R') {
                        echo '<p class="card-text"><strong>Recurso:</strong> ' . $c_linha['recurso'] . '</p>';
                    }
                    if ($c_linha['tipo'] == 'E') {
                        echo '<p class="card-text"><strong>Espaço:</strong> ' . $c_linha['espaco'] . '</p>';
                    }
                    ?>
                    <p class="card-text"><strong>Tipo de Ordem:</strong> <?php echo $c_linha['ordens_tipo_texto']; ?></p>
                    <p class="card-text"><strong>Ocorrência:</strong> <?php echo $c_linha['ocorrencia']; ?></p>
                    <p class="card-text"><strong>Executor Responsável:</strong> <?php echo $c_linha['executor_responsavel']; ?></p>
                    <hr>
                    <p class="card-text"><strong>Descrição da Solicitação:</strong><br><br><?php echo nl2br($c_linha['descricao']); ?></p><br>
                    <p class="card-text"><strong>Conclusão:</strong><br><?php if (!empty($c_linha['conclusao'])) echo nl2br($c_linha['conclusao']); ?></p>
                    <!-- traço linha para separar os dados da ordem de serviço dos materiais utilizados e executores envolvidos -->
                    <hr>
                    <p class="card-text"><strong>Materiais Utilizados:</strong><br>
                        <?php
                        if ($result_materiais->num_rows > 0) {
                            while ($row = $result_materiais->fetch_assoc()) {
                                echo "- " . $row['descricao'] . " - Quantidade: " . $row['quantidade'] . " " . $row['unidade_medida'] . "<br>";
                            }
                        } else {
                            echo "Nenhum material utilizado.";
                        }
                        ?>
                    </p>
                    <hr>
                    <p class="card-text"><strong>Executores Envolvidos:</strong><br>
                        <?php
                        if ($result_executores->num_rows > 0) {
                            while ($row = $result_executores->fetch_assoc()) {
                                echo "- " . $row['nome'] . " - Função: " . $row['funcao'] . "<br>";
                            }
                        } else {
                            echo "Nenhum executor envolvido.";
                        }
                        ?>
                    </p>
                </h3>
                <br>
                <div class='assinatura'>
                    <div class='linha-assinatura'></div>
                    <div class='profissional-info'>
                        <strong>Ordenador do Serviço</strong><br>
                    </div>
                </div>

                <br><br>
                <div class='assinatura'>
                    <div class='linha-assinatura'></div>
                    <div class='profissional-info'>
                        <strong>Técnico Responsável</strong><br>
                    </div>
                </div>
                <div class='data-emissao'>
                    <?php echo 'Sabará ' . $data_atual ?>
                </div>

            </div>

        </div>

    </div>

    <!-- rotina para enviar a ordem de serviço por email -->
    <div class="container mt-3">
        <form action="ordens_emissao_email.php?id=<?php echo $c_id; ?>" method="post">
            <div class='no-print' style='text-align: center; margin-top: 30px;'>
                <button type="submit" class="btn btn-primary">Enviar e-mail</button>
        </form>
        <button onclick='window.print()' style='padding: 10px 20px; background: #3498db; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 1rem;'>
            🖨️ Imprimir
        </button>

        <!-- botão para fechar a aba aberta -->
        <button onclick='window.close()' style='padding: 10px 20px; background: #95a5a6; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 1rem; margin-left: 10px;'>
            ✖️ Fechar
        </button>
    </div>

    </div>

</body>

<style>
    body {
        font-family: 'Times New Roman', serif;
        max-width: 800px;
        margin: 0 auto;
        padding: 40px;
        line-height: 1.6;
        color: #333;
        background: white;
    }

    .header {
        text-align: center;
        margin-bottom: 40px;
        border-bottom: 3px solid #2c3e50;
        padding-bottom: 20px;
    }

    .logo {
        font-size: 2.5rem;
        color: #2c3e50;
        margin-bottom: 10px;
    }

    .clinica-nome {
        font-size: 1.8rem;
        font-weight: bold;
        color: #2c3e50;
        margin-bottom: 5px;
    }

    .clinica-info {
        font-size: 1rem;
        color: #666;
    }

    .titulo {
        text-align: center;
        font-size: 2rem;
        font-weight: bold;
        color: #2c3e50;
        margin: 40px 0;
        text-transform: uppercase;
        letter-spacing: 2px;
    }

    .conteudo {
        font-size: 1.2rem;
        text-align: justify;
        margin: 30px 0;
        padding: 20px;
        background: #f8f9fa;
        border-left: 5px solid #3498db;
    }

    .paciente {
        font-weight: bold;
        color: #2c3e50;
    }

    .assinatura {
        margin-top: 60px;
        text-align: center;
    }

    .linha-assinatura {
        border-top: 2px solid #333;
        width: 300px;
        margin: 40px auto 10px;
    }

    .profissional-info {
        font-size: 1rem;
        color: #666;
    }

    .rodape {
        margin-top: 50px;
        text-align: center;
        font-size: 0.9rem;
        color: #888;
        border-top: 1px solid #ddd;
        padding-top: 20px;
    }

    .data-emissao {
        text-align: right;
        margin-top: 30px;
        font-size: 1.1rem;
        color: #666;
    }

    @media print {
        body {
            padding: 20px;
        }

        .no-print {
            display: none;
        }
    }
</style>


</html>