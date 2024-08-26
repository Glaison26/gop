<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// funções 

function carregadados()
{
    $c_nome = $_POST['nome'];
    $c_login = $_POST['login'];
    $c_cpf = $_POST['cpf'];
    $c_senha = $_POST['senha'];
    $c_tipo = $_POST['tipo'];
}

include_once "lib_gop.php";


$c_nome = "";
$c_login = "";
$c_cpf = "";
$c_senha = "";
$c_tipo = "";

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
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $c_nome = $_POST['nome'];
    $c_login = $_POST['login'];
    $c_cpf = $_POST['cpf'];
    $c_senha = $_POST['senha'];
    $c_tipo = $_POST['tipo'];
    if (!isset($_POST['chkativo'])) {
        $c_ativo = 'N';
    } else {
        $c_ativo = 'S';
    }

    do {
        if (empty($c_nome) || empty($c_login) || empty($c_senha) || empty($c_cpf)) {
            $msg_erro = "Todos os Campos devem ser preenchidos!!";
            break;
        }

        // valido o cpf informado
        if (!validaCPF($c_cpf)) {
            $msg_erro = "CPF Inválido! Favor verificar.";
            carregadados();
            break;
        }

        $i_tamsenha = strlen($c_senha);
        if (($i_tamsenha < 8) || ($i_tamsenha > 32)) {
            $msg_erro = "Campo Senha deve ter no mínimo 8 caracteres e no máximo 32 caracteres";
            carregadados();
            break;
        }
        // criptografo a senha digitada
        $c_senha = base64_encode($c_senha);
        // grava dados no banco

        // faço a Leitura da tabela com sql
        $c_sql = "Insert into usuarios (nome,login,senha, ativo, cpf, tipo)" .
            "Value ('$c_nome', '$c_login', '$c_senha', '$c_ativo','$c_cpf', '$c_tipo' )";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $c_nome = "";
        $c_login = "";
        $c_cpf = "";
        $c_senha = "";
        $c_tipo = "";

        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/usuarios_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Novos Usuários</title>

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

    <script type="text/javascript">
        $(document).ready(function() {
            $("#cpf").mask("999.999.999-99");
        });
    </script>

</head>
<div class="panel panel-light" style="background-color: #e3f2fd;">
    <div class="panel-heading text-center">
        <h2>Novo Usuário do Sistema</h2>
    </div>
</div>
<br>
<div class="container -my5">

    <body>
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <h3>$msg_erro</h3>
            </div>
                ";
        }
        ?>
        <form method="post">
            <div class="row mb-3">
                <div class="form-check col-sm-3">
                    <label class="form-check-label col-form-label">Usuário Ativo</label>
                    <div class="col-sm-3">
                        <input class="form-check-input" type="checkbox" value="S" name="chkativo" id="chkativo" checked>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Nome</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="nome" value="<?php echo $c_nome; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Login</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="40" class="form-control" name="login" value="<?php echo $c_login; ?>">
                </div>

            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Tipo de usuário </label>
                <div class="col-sm-6">
                    <select class="form-control form-control-lg" id="tipo" name="tipo">
                        <option>Operador</option>
                        <option>Consulta</option>
                        <option>Administrador</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">CPF</label>
                <div class="col-sm-6">
                    <input type="text" id="cpf" maxlength="14" class="form-control" name="cpf" value="<?php echo $c_CPF; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Senha</label>
                <div class="col-sm-6">
                    <input type="password" maxlength="32" class="form-control" name="senha" value="<?php echo $c_senha; ?>">
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
                    <a class='btn btn-danger' href='/gop/Usuarios_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
</div>

</body>

</html>