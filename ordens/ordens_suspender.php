<?php
/////////////////////////////////////////////
// Rotina de suspensão de ordem de serviço
////////////////////////////////////////////
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('../links2.php');
include('../conexao.php');
date_default_timezone_set('America/Sao_Paulo');

$i_id =  $_SESSION['id_ordem']; // id da ordem de serviço
$c_motivo = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    do {
        // consistencias
        $c_sql = "select * from ordens where id='$i_id'";
        $result = $conection->query($c_sql);
        $registro = $result->fetch_assoc();
        // data da conclusão inferior a data da abertura
        if ($registro['data_geracao'] > $_POST['data_suspensao']) {
            $msg_erro = "Data da suspensão deve ser igual ou superior a data da Geração !!!";
            break;
        }
        if (empty($_POST['motivo'])) {
            $msg_erro = "Campo de motivo deve ser preenchido !!!";
            break;
        }
        // suspendo a ordem de serviço

        // atualizo o status da ordem de servico e colo data hora e texto de conclusão
        $c_data_suspensao = $_POST['data_suspensao'];
        $c_hora_suspensao = $_POST['hora_suspensao'];
        $c_motivo = $_POST['motivo'];
        $c_sql_up = "update ordens set status='S' where id=$i_id";
        $result_up = $conection->query($c_sql_up);
        // incluir dados da suspensão na tabela de históricos da suspensão
        $c_sql = "insert into ordens_suspensao (id_ordem,data_suspensao,hora_suspensao,motivo) value ('$i_id','$c_data_suspensao', '$c_hora_suspensao', '$c_motivo')";
        $result = $conection->query($c_sql);

        // rotina para envio de email quando houver suspensão
        // envio para solicitante, oficina e 
        // rotina de envio de email da conclusão para solicitante, manutenção e oficina
        // pego o email da manutenção
        $c_sql_config = "select email_manutencao from configuracoes";
        $result = $conection->query($c_sql_config);
        $c_linha_email = $result->fetch_assoc();
        $c_email_manutencao = $c_linha_email['email_manutencao'];
        //echo $c_email_oficina;
        // procuro solicitante para enviar e-mail
        $c_sql_sol = "select id_solicitante from ordens where id=$i_id";
        $result_sol = $conection->query($c_sql_sol);
        $registro_sol = $result_sol->fetch_assoc();
        $i_id_solicitante = $registro_sol['id_solicitante'];
        // procuro o email do solicitante
        $c_sql_sol = "select email from usuarios where id= '$i_id_solicitante'";
        $result_sol = $conection->query($c_sql_sol);
        $registro_sol = $result_sol->fetch_assoc();
        $c_email = $registro_sol['email'];
        $c_descricao = $registro['descricao'];
        // chamo o envio de email ordem de serviço gerada
        if (filter_var($c_email, FILTER_VALIDATE_EMAIL)) {
            $ordem = $i_id;
            $c_data_suspensao = new DateTime($_POST['data_suspensao']);
            $c_data_suspensao = $c_data_suspensao->format('Y-m-d');
            $c_motivo_suspensao = $_POST['motivo'];

            $c_assunto = "Suspensão de Ordem de Serviço no GOP";
            $c_body = "A Ordem de serviço No.<b> $ordem </b> teve que ser suspensa Suspensa!<br>"
                . "Descrição da Solicitação :" . $c_descricao . "<br>" .
                "Motivo da Suspensão:<br>" .
                $c_motivo;

            include('../email_gop.php');
        }



        header('location: /gop/ordens/ordens_gerenciar.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GOP - Suspenção de Ordem de Serviço</title>
    <link rel="stylesheet" href="/gop/css/basico.css">

</head>

<body>
    <script>
        // função para confirmar coonclusão
        function pergunta() {
            // retorna true se confirmado, ou false se cancelado
            return confirm('Tem certerza que deseja Suspender a Ordem de Serviço?');
        }
    </script>

    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Suspensão de Ordem de serviço</h5>
                </div>
            </div>
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
        <div class="container content-box">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

                </div>
                <h4>Preencha os dados abaixo e clique no botão confirmar para Suspender a ordem de serviço No. <?php echo $i_id ?></h4>
            </div>
            <form method="post">
                <div class="row mb-8">
                    <label class="col-md-2 form-label">Data Suspensão</label>
                    <div class="col-sm-2">
                        <input type="Date" class="form-control" name="data_suspensao" id="data_suspensao" value='<?php echo $c_data ?>'>
                    </div>
                    <label class="col-md-2 form-label">Hora Suspensão</label>
                    <div class="col-sm-2">
                        <input type="time" class="form-control" name="hora_suspensao" id="hora_suspensao" value="<?php echo $agora ?>">
                    </div>
                </div>
                <br>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Motivo</label>
                    <div class="col-sm-8">
                        <textarea class="form-control" id="motivo" name="motivo" rows="6"><?php echo $c_motivo ?></textarea>
                    </div>
                </div>
                <hr>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary" onclick='return pergunta();'><span class='glyphicon glyphicon-ok'></span> Suspender</button>
                        <a class='btn btn-danger' href='/gop/ordens/ordens_gerenciar.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                    </div>
                </div>

            </form>
        </div>
    </div>

</body>

</html>