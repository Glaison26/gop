<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('../links2.php');
include('../conexao.php');

$c_id = $_SESSION['id_preventiva'];


$c_indice = '';
$msg_erro = "";


// inclusão do material no banco de dados
if ($_SERVER['REQUEST_METHOD'] == 'POST' && !isset($_POST['btncusto'])) {
    
    $c_executor = $_POST['executor'];


    //
    do {
        if (empty($c_executor)) {
            $msg_erro = "Todos os campos devem ser preencidos !!";
            break;
        }

        // sql para pegar codigo do executor
        $c_sql_executor = "SELECT executores.id, executores.nome FROM executores
    where executores.nome = '$c_executor' ORDER BY executores.nome";
        $result_executor = $conection->query($c_sql_executor);
        $c_linha = $result_executor->fetch_assoc();
        $i_id_executor = $c_linha['id'];
        //
        $c_sql = "Insert into preventivas_executores (id_executor, id_preventiva)
                 Value ('$i_id_executor','$c_id')";
        $result = $conection->query($c_sql);
        // somatório dos valores de custo de material
        
        $result = $conection->query($c_sql);
        header('location: /gop/preventivas/preventivas_anexos.php');
    } while (false);
}


?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="container -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo registro de executor para Preventiva<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Entre com os dados do Executor a ser anexado a Preventiva.</h5>
        </div>

        <br>
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

        <form method="post">

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Executor</label>
                <div class="col-sm-5">
                    <select class="form-select form-select-lg mb-3" id="executor" name="executor">

                        <?php
                        if ($c_indice == '')
                            echo "<option></option>";
                        // select da tabela de Material
                        $c_sql_executor = "SELECT executores.id, executores.nome FROM executores ORDER BY executores.nome";
                        $result_executor = $conection->query($c_sql_executor);
                        while ($c_linha = $result_executor->fetch_assoc()) {

                            echo "  
                          <option $op>$c_linha[nome]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/preventivas/preventivas_anexos.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>
            </div>
        </form>
    </div>

</body>

</html>