<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// funções 


include_once "../../lib_gop.php";
include("../../conexao.php");
include("../../links2.php");

$c_descricao = "";
$c_descritivo = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $c_descricao = $_POST['descricao'];
    $c_descritivo = $_POST['descritivo'];

    do {
        if (empty($c_descricao)) {
            $msg_erro = "Todos os Campos com (*) devem ser preenchidos!!";
            break;
        }

        // grava dados no banco

        // faço a Leitura da tabela com sql
        $c_sql = "Insert into checklist (descricao, descritivo)" .
            "Value ('$c_descricao', '$c_descritivo')";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/cadastros/checklist/checklist_lista.php');
    } while (false);
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

    <div class="container  -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo CheckList<h5>
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
                    <input type="text" maxlength="150" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>" required>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Descritivo </label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="descritivo" name="descritivo" rows="10"><?php echo $c_descritivo; ?></textarea>
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
                    <a class='btn btn-danger' href='/gop/cadastros/checklist/checklist_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>