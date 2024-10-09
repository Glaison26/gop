<?php
/////////////////////////////////////////////
// Rotina de conclusão de ordem de serviço
////////////////////////////////////////////
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('../links2.php');
include('../conexao.php');

$i_id = $_GET["id"]; // id da ordem de serviço
$c_conclusao = "";

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
                    <h5>Fechamento de Ordem de Serviço</h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h4>Preencha os dados abaixo e clique no botão confirmar para fechar a ordem de serviço No. <?php echo $i_id ?></h4>
        </div>

        <br>
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <div style='padding-left:15px;'>
                   <h4><img Align='left' src='\gop\images\aviso.png' alt='30' height='35'> $msg_erro</h4>
                </div>
            </div>
            ";
        }
        $agora = date('H:i');
        $c_data = date('Y-m-d');
        ?>
        <form method="post">
            <div class="row mb-8">
                <label class="col-md-2 form-label">Data Conclusão</label>
                <div class="col-sm-2">
                    <input type="Date" class="form-control" name="data_geracao" id="data_geracao" value='<?php echo $c_data ?>'>
                </div>
                <label class="col-md-2 form-label">Hora Conclusão</label>
                <div class="col-sm-2">
                    <input type="time" class="form-control" name="hora_geracao" id="hora_geracao" value="<?php echo $agora ?>">
                </div>
            </div>
            <br>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Conclusão</label>
                <div class="col-sm-8">
                    <textarea class="form-control" id="conclusao" name="conclusao" rows="6"><?php echo $c_conclusao ?></textarea>
                </div>
            </div>
        </form>
    </div>

</body>

</html>