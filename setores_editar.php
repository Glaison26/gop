<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

function carregadados()
{
    $msg_erro = "CPF Inválido! Favor verificar.";
    $c_descricao = $_POST['descricao'];
    $c_responsavel = $_POST['responsavel'];
    $c_fone1 = $_POST['fone1'];
    $c_fone2 = $_POST['fone2'];
    $c_email = $_POST['email'];
    $c_prioritario = $_POST['prioritario'];
    $c_nivelprioridade = $_POST['nivelprioridade'];
    $c_centrodecusto = $_POST['centrocusto'];
}

include_once "lib_gop.php";

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
// conexão dom o banco de dados
$servername = $_SESSION['local'];
$username = $_SESSION['usuario'];
$password =  $_SESSION['senha'];
$database = $_SESSION['banco'];
// criando a conexão com banco de dados
$conection = new mysqli($servername, $username, $password, $database);
// checo erro na conexão
if ($conection->connect_error) {
    die("Erro na Conexão com o Banco de Dados!! " . $conection->connect_error);
}
if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/setores_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do setor através de sql usando id passada
    $c_sql = "select * from setores where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/setores_lista.php');
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
    $c_descricao = $_POST["descricao"];
    $c_fone1 = $_POST['fone1'];
    $c_fone2 = $_POST['fone2'];
    $c_responsavel = $_POST['responsavel'];
    $c_prioritario = $_POST['prioritario'];
    $c_nivelprioridade = $_POST['nivelprioridade'];

    do {
        if (empty($c_descricao) || empty($c_responsavel)) {
            $msg_erro = "Todos os Campos devem ser preenchidos!!";
            carregadados();
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
        header('location: /gop/setores_lista.php');
    } while (false);
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Editar Setor</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css">
    <link rel="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css">
    <link href="https://nightly.datatables.net/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
    <script type="text/javascript" src="js/jquery.maskedinput-1.1.4.pack.js"></script>
</head>

<body>
    <div class="panel panel-light" style="background-color: #e3f2fd;">
        <div class="panel-heading text-center">
            <h2>Editar Setor</h2>
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
                <label class="col-sm-3 col-form-label">Responsável</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" class="form-control" name="responsavel" value="<?php echo $c_responsavel; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fone I</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="20" id="fone1" class="form-control" name="fone1" value="<?php echo $c_fone1; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fone II</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="20" id="fone2" class="form-control" name="fone2" value="<?php echo $c_fone2; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">E-mail</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" id="email" class="form-control" name="email" placeholder="E-mail" value="<?php echo $c_email; ?>">
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
                <div class="offset-sm-3 col-sm-3 d-grid">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/setores_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>

        </form>
    </div>

</body>

</html>