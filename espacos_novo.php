<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// funções 

function carregadados()
{
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

$c_descricao = "";
$c_tipo = "";
$c_responsavel = "";
$c_fone1 = "";
$c_fone2 = "";
$c_endereco = "";
$c_bairro = "";
$c_cidade = "";
$c_cep = "";
$c_email = "";
$c_medida = "";

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
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

    do {
        if (empty($c_descricao) || empty($c_tipo) || empty($c_responsavel) || empty($c_endereco) || empty($c_bairro) || empty($c_cep) || empty($c_cidade)) {
            $msg_erro = "Todos os Campos com (*) devem ser preenchidos!!";
            break;
        }

        // grava dados no banco

        // faço a Leitura da tabela com sql
        $c_sql = "Insert into espacos (descricao, tipo, responsavel, fone1, fone2, endereco, bairro, cep, email, cidade, medida)" .
            "Value ('$c_descricao', '$c_tipo', '$c_responsavel', '$c_fone1', '$c_fone2', '$c_endereco', '$c_bairro', '$c_cep', '$c_email' ,'$c_cidade', '$c_medida')";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $c_descricao = "";
        $c_tipo = "";
        $c_responsavel = "";
        $c_fone1 = "";
        $c_fone2 = "";
        $c_endereco = "";
        $c_bairro = "";
        $c_cidade = "";
        $c_cep = "";
        $c_email = "";
        $c_medida = "";

        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/espacos_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <script>
        const handlePhone = (event) => {
            let input = event.target
            input.value = phoneMask(input.value)
        }

        const phoneMask = (value) => {
            if (!value) return ""
            value = value.replace(/\D/g, '')
            value = value.replace(/(\d{2})(\d)/, "($1) $2")
            value = value.replace(/(\d)(\d{4})$/, "$1-$2")
            return value
        }
    </script>

</head>


<body>
    <div class="container -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo Espaço Físico<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Campos com (*) são obrigatórios</h5>
        </div>

        <br>
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <div style='padding-left:15px;'>
                    <h5><img Align='left' src='\gop\images\aviso.png' alt='35' height='35'> $msg_erro</h5>
                </div>
                
            </div>
            ";
        }
        ?>


        <form method="post">

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Descrição (*)</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Tipo de Espaço Físico (*) </label>
                <div class="col-sm-3">
                    <select class="form-control form-control-lg" id="tipo" name="tipo">
                        <option>Instalação</option>
                        <option>Edificação</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Responsável (*)</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" class="form-control" name="responsavel" value="<?php echo $c_responsavel; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fone I</label>
                <div class="col-sm-2">
                    <input type="tel" maxlength="25" onkeyup="handlePhone(event)" id="fone1" class="form-control" name="fone1" value="<?php echo $c_fone1; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Fone II</label>
                <div class="col-sm-2">
                    <input type="tel" maxlength="25" onkeyup="handlePhone(event)" id="fone2" class="form-control" name="fone2" value="<?php echo $c_fone2; ?>">
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Endereço (*)</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" id="endereco" class="form-control" name="endereco" value="<?php echo $c_endereco; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Bairro (*)</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" id="bairro" class="form-control" name="bairro" value="<?php echo $c_bairro; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Cidade (*)</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" id="cidade" class="form-control" name="cidade" value="<?php echo $c_cidade; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">CEP (*)</label>
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
                    <input type="text" maxlength="3" id="medida" class="form-control col-xs-12" name="medida" value="<?php echo $c_medida; ?>">
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