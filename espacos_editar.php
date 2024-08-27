<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

function carregadados()
{
    $msg_erro = "CPF Inválido! Favor verificar.";
    $c_descricao = $_POST['descricao'];
    $c_tipo = $_POST['tipo'];
    $c_responsavel = $_POST['responsavel'];
    $c_fone1 = $_POST['fone1'];
    $c_fone2 = $_POST['fone2'];
    $c_endereco = $_POST['endereco'];
    $c_bairro = $_POST['bairro'];
    $c_cidade = $_POST['cidade'];
    $c_cep = $_POST['cep'];
    $c_email = $_POST['email'];
    $c_medida = $_POST['medida'];
}

include_once "lib_gop.php";
include("conexao.php");
include("links.php");

// rotina de post dos dados do formuário
$c_id = "";
$c_descricao = "";
$c_tipo = "";
$c_responsavel = "";
$c_fone1 = "";
$c_fone2 = '';
$c_endereco = "";
$c_bairro = "";
$c_cidade = "";
$c_cep = "";
$c_email = "";
$c_medida = "";



// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/espacos_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from espacos where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/espacos_lista.php');
        exit;
    }
    $c_descricao = $registro["descricao"];
    $c_tipo = $registro['tipo'];
    $c_fone1 = $registro['fone1'];
    $c_fone2 = $registro['fone2'];
    $c_responsavel = $registro['responsavel'];
    $c_endereco = $registro['endereco'];
    $c_bairro = $registro['bairro'];
    $c_cidade = $registro['cidade'];
    $c_cep = $registro['cep'];
    $c_email = $registro['email'];
    $c_medida = $registro['medida'];
} else {
    // metodo post para atualizar dados
    $c_id = $_POST["id"];
    $c_descricao = $_POST["descricao"];
    $c_tipo = $_POST['tipo'];
    $c_fone1 = $_POST['fone1'];
    $c_fone2 = $_POST['fone2'];
    $c_responsavel = $_POST['responsavel'];
    $c_endereco = $_POST['endereco'];
    $c_bairro = $_POST['bairro'];
    $c_cidade = $_POST['cidade'];
    $c_cep = $_POST['cep'];
    $c_email = $_POST['email'];
    $c_medida = $_POST['medida'];

    do {
        if (empty($c_descricao) || empty($c_responsavel)) {
            $msg_erro = "Todos os Campos devem ser preenchidos!!";
            break;
        }
        // grava dados no banco
        // faço a Leitura da tabela com sql
        $c_sql = "Update espacos" .
            " SET descricao = '$c_descricao', tipo ='$c_tipo', responsavel ='$c_responsavel', fone1 ='$c_fone1', fone2='$c_fone2', endereco='$c_endereco', bairro='$c_bairro'" .
            ", cidade='$c_cidade', cep='$c_cep', email='$c_email', medida='$c_medida'" .
            " where id=$c_id";
        echo $c_sql;
        $result = $conection->query($c_sql);

        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/espacos_lista.php');
    } while (false);
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    
</head>

<body>
<div class="panel panel-primary class">
    <div class="panel-heading text-center">
        <h4>GOP - Gestão Operacional</h4>
        <h5>Editar Espaço Físico<h5>
    </div>
</div>
    <br>
    <div class="container -my5">


        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <h4>$msg_erro</h4>
            </div>
                ";
        }
        ?>

        <form method="post">
            <input type="hidden" name="id" value="<?php echo $c_id; ?>">

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Descrição</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>">
                </div>
            </div>

            <?php
            $op1 = '';
            $op2 = '';
            if ($c_tipo == 'Instalação') {
                $op1 = 'Selected';
            }
            if ($c_tipo == 'Edificação') {
                $op2 = 'Selected';
            }
            ?>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Tipo de Espaço Físico </label>
                <div class="col-sm-6">
                    <select class="form-control form-control-lg" id="tipo" name="tipo">
                        <option <?php echo $op1; ?>>Instalação</option>
                        <option <?php echo $op2; ?>>Edificação</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Responsável</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" class="form-control" name="responsavel" value="<?php echo $c_responsavel; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fone I</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" id="fone1" class="form-control" name="fone1" value="<?php echo $c_fone1; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fone II</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" id="fone2" class="form-control" name="fone2" value="<?php echo $c_fone2; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Endereço</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" id="endereco" class="form-control" name="endereco" value="<?php echo $c_endereco; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Bairro</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" id="bairro" class="form-control" name="bairro" value="<?php echo $c_bairro; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Cidade</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" id="cidade" class="form-control" name="cidade" value="<?php echo $c_cidade; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">CEP</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="10" id="cep" class="form-control" name="cep" value="<?php echo $c_cep; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">E-mail</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" id="email" class="form-control" name="email" placeholder="E-mail" value="<?php echo $c_email; ?>">
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Medida (m2)</label>
                <div class="col-sm-1">
                    <input type="text" maxlength="3" id="medida" class="form-control" name="medida" value="<?php echo $c_medida; ?>">
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
                <div class="offset-sm-3 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/espacos_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>