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
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    do {
        // consistencias
        $c_sql = "select * from ordens where id='$i_id'";
        $result = $conection->query($c_sql);
        $registro = $result->fetch_assoc();
        // data da conclusão inferior a data da abertura
        if ($registro['data_geracao'] > $_POST['data_conclusao']) {
            $msg_erro = "Data da Conclusão deve ser igual ou superior a data da Geração !!!";
            break;
        }
        if (empty($_POST['conclusao'])) {
            $msg_erro = "Campo de conclusão deve ser preenchido !!!";
            break;
        }
        // fecho a ordem de serviço
        // verifico se houve solicitação para a ordem de serviço
        if ($registro['tipo_ordem'] == 'C') {
            $c_sql = "select * from solicitacao where id_ordem = '$i_id'";
            $result = $conection->query($c_sql);
            $i_total = mysqli_num_rows($result);
            if ($i_total > 0) {
                // atualizo o status da solicitação
                $c_sql_up = "update solicitacao set status='C' where id_ordem = '$i_id'";
                $result_up = $conection->query($c_sql_up);
            }
        }
        // atualizo o status da ordem de servico e colo data hora e texto de conclusão
        $c_data_conclusao = $_POST['data_conclusao'];
        $c_hora_conclusao = $_POST['hora_conclusao'];
        $c_conclusao = $_POST['conclusao'];
        $c_sql_up = "update ordens set status='C', data_conclusao='$c_data_conclusao', 
           hora_conclusao='$c_hora_conclusao', conclusao='$c_conclusao' where id=$i_id";
        $result_up = $conection->query($c_sql_up);
        header('location: /gop/ordens/ordens_gerenciar.php');
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
                    <input type="Date" class="form-control" name="data_conclusao" id="data_conclusao" value='<?php echo $c_data ?>'>
                </div>
                <label class="col-md-2 form-label">Hora Conclusão</label>
                <div class="col-sm-2">
                    <input type="time" class="form-control" name="hora_conclusao" id="hora_conclusao" value="<?php echo $agora ?>">
                </div>
            </div>
            <br>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Conclusão</label>
                <div class="col-sm-8">
                    <textarea class="form-control" id="conclusao" name="conclusao" rows="6"><?php echo $c_conclusao ?></textarea>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-ok'></span> Fechar</button>
                    <a class='btn btn-danger' href='/gop/ordens/ordens_gerenciar.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>
            </div>

        </form>
    </div>

</body>

</html>