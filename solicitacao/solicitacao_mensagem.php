<?php
/////////////////////////////////////////////////
// Rotina de Tirar Suspensão de ordem de serviço
////////////////////////////////////////////////
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('../links2.php');
include('../conexao.php');
date_default_timezone_set('America/Sao_Paulo');

// gravação e envio da mensagem

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    // rotina de inclusão
    $i_id_solicitacao = $_SESSION['id_solicitacao'];
    $c_descricao = rtrim($_POST['mensagem']);
    $i_id_usuario = $_SESSION["id_usuario"];
    // tipo de envio. se feito por solicitante ou operador do sistema
    if ($_SESSION['tipo'] == 'Solicitante') {
        $c_tipo = "1";
    } else {
        $c_tipo = "0";
    }
    $d_data = date("Y-m-d");
    $d_hora = date('H:i:s');
    $c_sql = "Insert into mensagens (mensagem,id_solicitacao, id_usuario,tipo, data, hora, status) 
            Value ('$c_descricao', '$i_id_solicitacao', '$i_id_usuario','$c_tipo', '$d_data', '$d_hora','N')";
    $result = $conection->query($c_sql);
    // rotina para envio do email
    // pego o email da manutenção
    $c_email_manutencao = "";
    $c_sql_config = "select email_manutencao, email_envio from configuracoes";
    $result_solicitante = $conection->query($c_sql_config);
    $c_linha_email = $result_solicitante->fetch_assoc();
    $c_email_envio = $c_linha_email['email_envio'];
    if ($c_tipo == "1") { // solicitante enviando email para manutenção
        $c_email = $c_linha_email['email_manutencao'];
        $c_email_manutencao = "";
    } else {
        // manutenção enviando e-mail para solicitante
        $c_sql_solicitante = "Select email from usuarios where id='$i_id_usuario'";
        $result_solicitante = $conection->query($c_sql_solicitante);
        $registro_solicitante = $result_solicitante->fetch_assoc();
        $c_email = $registro_solicitante['email'];
        $c_email_manutencao = "";
    }
    // chamo o envio de email
    // barra de progresso
    // mensagem em javascript de espera do envio do email
    if (filter_var($c_email, FILTER_VALIDATE_EMAIL)) {
        $c_assunto = "Mensagem de sobre solicitação de Serviço No.:" . $i_id_solicitacao . " no Sistema GOP";
        $c_body = $c_descricao;
        $c_email_oficina = "";
        include('../email_gop.php');
    }
    header('location: /gop/solicitacao/solicitacao_detalhe.php');
}


?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/gop/css/basico.css">
</head>

<body>
    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Mensagem de Solicitação de Serviço</h5>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="container content-box">

            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="25">

                </div>
                <h4>Escreva a mensagem, clique em enviar mensagem e aguarde o envio do e-mail</h4>
            </div>


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
            $agora_retirada = date('H:i');
            $c_data_retirada = date('Y-m-d');
            ?>
            <form method="post">
                <div class="row mb-3">

                    <div class="col-sm-12">
                        <textarea class="form-control" id="mensagem" name="mensagem" rows="7"></textarea>
                    </div>
                </div>
                <hr>
                <div class="row mb-6">
                    <div class="offset-sm-0 col-sm-6">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-envelope'></span> Enviar mensagem</button>
                        <a class='btn btn-danger' href='/gop/solicitacao/solicitacao_detalhe.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                    </div>
                </div>

            </form>
        </div>
    </div>

</body>

</html>