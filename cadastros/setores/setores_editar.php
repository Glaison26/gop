<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include_once "../../lib_gop.php";
include("../../conexao.php");
include("../../links2.php");

// rotina de post dos dados do formuário

$c_descricao = '';

$c_responsavel = '';
$c_fone1 = '';
$c_fone2 = '';
$c_email = '';
$c_prioritario = '';
$c_nivelprioridade = '';
// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/cadastros/setores/setores_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do setor através de sql usando id passada
    $c_sql = "select * from setores where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/cadastros/setores/setores_lista.php');
        exit;
    }
    $c_descricao = $registro['descricao'];
    $i_centrodecusto = $registro['id_centrodecusto'];
    $c_responsavel = $registro['Responsavel'];
    $c_fone1 = $registro['fone1'];
    $c_fone2 = $registro['fone2'];
    $c_email = $registro['email'];
    $c_prioritario = $registro['prioritario'];
    $c_nivelprioridade = $registro['nivelprioridade'];
} else {
    // metodo post para atualizar dados
    $c_id = $_POST["id"];
    $c_centrodecusto = $_POST["centrocusto"];
    $c_descricao = rtrim($_POST["descricao"]);
    $c_fone1 = $_POST['fone1'];
    $c_fone2 = $_POST['fone2'];
    $c_responsavel = $_POST['responsavel'];
    $c_prioritario = $_POST['prioritario'];
    $c_nivelprioridade = $_POST['nivelprioridade'];

    do {
        if (empty($c_descricao) || empty($c_responsavel)) {
            $msg_erro = "Todos os Campos com * devem ser preenchidos!!";
            break;
        }
        $c_sql_centrocusto = "SELECT centrodecusto.id FROM centrodecusto where centrodecusto.descricao='$c_centrodecusto' ORDER BY centrodecusto.descricao";
        $result_centrocusto = $conection->query($c_sql_centrocusto);
        $registro_centrocusto = $result_centrocusto->fetch_assoc();
        $i_centrodecusto = $registro_centrocusto['id'];
        // grava dados no banco
        // faço a Leitura da tabela com sql
        $c_sql = "Update SETORES" .
            " SET descricao = '$c_descricao', responsavel ='$c_responsavel', fone1 ='$c_fone1', fone2 ='$c_fone2'," .
            " email='$c_email', id_centrodecusto = '$i_centrodecusto',prioritario = '$c_prioritario', nivelprioridade = '$c_nivelprioridade'" .
            " where id=$c_id";
        echo $c_sql;
        $result = $conection->query($c_sql);

        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/cadastros/setores/setores_lista.php');
    } while (false);
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <html lang="en">
    <link rel="stylesheet" href="/gop/css/basico.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar dados de novo Setor</title>
</head>

<body>

    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Editar dados do Setor<h5>
                </div>
            </div>
        </div>
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <div style='padding-left:15px;'>
                    
                </div>
                <h4><img Align='left' src='\gop\images\aviso.png' alt='30' height='35'> $msg_erro</h4>
            </div>
            ";
        }
        ?>
        <div class="container content-box">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

                </div>
                <h5>Campos com (*) são obrigatórios</h5>
            </div>
            <form method="post">
                <input type="hidden" name="id" value="<?php echo $c_id; ?>">

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Descrição (*)</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Centro de Custo </label>
                    <div class="col-sm-6">
                        <select class="form-select form-select-lg mb-3" id="centrocusto" name="centrocusto">
                            <?php
                            // select da tabela de espacos fisicos
                            $c_sql_centro = "SELECT centrodecusto.id, centrodecusto.descricao FROM centrodecusto ORDER BY centrodecusto.descricao";
                            $result_centro = $conection->query($c_sql_centro);
                            while ($c_linha = $result_centro->fetch_assoc()) {
                                if ($c_linha['id'] == $i_centrodecusto) {
                                    $op = 'Selected';
                                } else {
                                    $op = "";
                                }
                                echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                            }
                            ?>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Responsável *</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="100" class="form-control" name="responsavel" value="<?php echo $c_responsavel; ?>" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Fone I</label>
                    <div class="col-sm-2">
                        <input type="tel" onkeyup="handlePhone(event)" maxlength="20" id="fone1" class="form-control" name="fone1" value="<?php echo $c_fone1; ?>">
                    </div>
                    <label class="col-sm-2 col-form-label">Fone II</label>
                    <div class="col-sm-2">
                        <input type="tel" onkeyup="handlePhone(event)" maxlength="20" id="fone2" class="form-control" name="fone2" value="<?php echo $c_fone2; ?>">
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">E-mail</label>
                    <div class="col-sm-6">
                        <input type="email" maxlength="120" id="email" class="form-control" name="email" placeholder="E-mail" value="<?php echo $c_email; ?>">
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Prioritário</label>
                    <div class="col-sm-2">
                        <select class="form-select form-select-lg mb-3" id="prioritario" name="prioritario">
                            <option <?= ($c_prioritario == 'SIM') ? 'selected' : '' ?>>SIM</option>
                            <option <?= ($c_prioritario == 'NÃO') ? 'selected' : '' ?>>NÃO</option>
                        </select>
                    </div>

                    <label class="col-sm-2 col-form-label">Prioridade (de 1 a 5)</label>
                    <div class="col-sm-2">
                        <select class="form-select form-select-lg mb-3" id="nivelprioridade" name="nivelprioridade">
                            <option <?= ($c_nivelprioridade == '1') ? 'selected' : '' ?>>1</option>
                            <option <?= ($c_nivelprioridade == '2') ? 'selected' : '' ?>>2</option>
                            <option <?= ($c_nivelprioridade == '3') ? 'selected' : '' ?>>3</option>
                            <option <?= ($c_nivelprioridade == '4') ? 'selected' : '' ?>>4</option>
                            <option <?= ($c_nivelprioridade == '5') ? 'selected' : '' ?>>5</option>

                        </select>
                    </div>

                </div>

                <?php
                if (!empty($msg_gravou)) {

                    echo "
                    <div class='row mb-3'>
                        <div class='offset-sm-3 col-sm-6'>
                             <div class='alert alert-success alert-dismissible fade show' role='alert'>
                                <strong>$msg_gravou</strong>
                             </div>
                        </div>     
                    </div>    
                ";
                }
                ?>
                <br>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                        <a class='btn btn-danger' href='/gop/cadastros/setores/setores_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                    </div>

                </div>

            </form>
        </div>
    </div>

</body>

</html>