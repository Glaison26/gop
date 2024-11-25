<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include_once "lib_gop.php";


$c_senhaatual = "";
$c_senhanova = "";
$c_senhaconfirma = "";

// conexão dom o banco de dados
$servername = "localhost";
$username = "root";
$password = "";
$database = "gop";
// criando a conexão com banco de dados
$conection = new mysqli($servername, $username, $password, $database);
// checo erro na conexão
if ($conection->connect_error) {
    die("Erro na Conexão com o Banco de Dados!! " . $conection->connect_error);
}


// variaveis para mensagens de erro e suscessso da gravação
$msg_erro = "";
$msg_acerto = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $c_senhaatual = $_POST['senhaatual'];
    $c_senhanova = $_POST['senhanova'];
    $c_senhaconfirma = $_POST['senhaconfirma'];

    do {
        $c_login = $_SESSION['c_usuario'];
        $c_sql = "SELECT usuarios.senha, usuarios.id FROM usuarios where usuarios.login='$c_login'";
        $result = $conection->query($c_sql);
        $registro = $result->fetch_assoc();
        $c_senhaatual = base64_decode($registro['senha']);
        $i_tamsenha = strlen($c_senhanova);
        // consitencias de senha
        if ($c_senhaatual != $_POST['senhaatual']) {
            $msg_erro = "Senha Atual Inválida!!";
            break;
        }
        if (($i_tamsenha < 8) || ($i_tamsenha > 32)) {
            $msg_erro = "Campo Senha nova deve ter no mínimo 8 caracteres e no máximo 32 caracteres!!";
            break;
        }

        if ($c_senhanova != $c_senhaconfirma) {
            $msg_erro = "Campo Senha diferente de senha de confirmação!!";
            break;
        }
        // consiste se senha tem pelo menos 1 caracter numérico
        if (filter_var($c_senhanova, FILTER_SANITIZE_NUMBER_INT) == '') {
            $msg_erro = "Campo Senha deve ter pelo menos (1) caracter numérico";
            break;
        }
        if (ctype_digit($c_senhanova)) {
            $msg_erro = "Campo Senha deve conter pelo menos uma letra do Alfabeto";
            break;
        }
        // criptografo a senha digitada
        $c_senhanova = base64_encode($c_senhanova);
        // grava dados no banco
        $c_id = $registro['id'];
        // faço a Leitura da tabela com sql

        $c_sql = "Update usuarios SET usuarios.senha ='$c_senhanova' where id=$c_id";
        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        $msg_acerto = "Senha foi alterada com sucesso!!!";
        // header('location: /gop/menu.php');
    } while (false);
}

?>


<!DOCTYPE html>
<html lang="en">

<head>
    <title>gop - Gestão de Serviços</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script language="Javascript">
        function mensagem(msg) {
            alert(msg);
        }
    </script>

</head>
<div class="clearfix" style="display:none"></div>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>Alteração de Senha</h4>
        </div>
    </div>
    <div class='alert alert-info' role='alert'>
        <div style="padding-left:15px;">
            <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

        </div>
        <h5>A senha do usário deve conter pelo menos 1 letra do alfabeto, 1 caracter numérico, no mínimo 8 caracteres e no máximo 30 caracteres</h5>
    </div>

    <br>
    <?php
    if (!empty($msg_erro)) {
        echo "
              <div class='alert alert-warning' role='alert'>
              <h4>$msg_erro</h4>
              </div>
            ";
    }
    if (!empty($msg_acerto)) {
        echo "
        <div class='alert alert-warning' role='alert'>
        <h4>$msg_acerto</h4>
        </div>
      ";
    }
    ?>
    <div class="container" style="width: 400px">

        <form method="post" class="row g-3">
            </br>
            </br>
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h5>Troca de Senha </h5>
                </div>
            </div>

            <div class="well" style="width:400px">
                <div class="form-group row" class="form-control">
                    <label class="col-sm-6 col-form-label">Senha Atual</label>
                    <div class="col-xs-12">
                        <input type="password" maxlength="32" required class="form-control" name="senhaatual" placeholder="Digite sua senha atual">
                    </div>
                </div>

                <div class="form-group row" class="form-control">
                    <label class="col-sm-6 col-form-label">Nova Senha</label>
                    <div class="col-xs-12">
                        <input type="password" maxlength="32" required class="form-control" name="senhanova" placeholder="Digite a senha nova">
                    </div>
                </div>

                <div class="form-group row" class="form-control">
                    <label class="col-sm-6 col-form-label">Confirmação de senha</label>
                    <div class="col-xs-12">
                        <input type="password" maxlength="32" required class="form-control" name="senhaconfirma" placeholder="confirme senha nova">
                    </div>
                </div>


                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button name="btnentra" type="submit" class="btn btn-primary btn-sm"><span class='glyphicon glyphicon-check'></span> Confirma</button>
                        <a class='btn btn-dark btn-sm' href='/gop/menu.php'><span class='glyphicon glyphicon-log-out'></span> Voltar</a>
                    </div>

                </div>
            </div>
        </form>
    </div>



</body>

</html>