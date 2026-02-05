<?php
//Import PHPMailer classes into the global namespace
//These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

// pego dados da configuração para envio de e-mail
include '..\configuracoes_carrega.php';

//Load Composer's autoloader
require '../vendor/autoload.php';

//Create an instance; passing `true` enables exceptions
$mail = new PHPMailer(true);
// envio de email da ordem de serviço
include("../conexao.php");
include("../links2.php");
date_default_timezone_set('America/Sao_Paulo');
$c_id = $_GET["id"];
if ($_SERVER['REQUEST_METHOD'] == 'POST') {  // metodo post para envio do email

    if (!isset($_GET["id"])) {
        header('location: /gop/ordens/ordens_lista.php');
        exit;
    }

    $c_id = $_GET["id"];

    // leitura da ordem de serviço
    $c_sql = "SELECT ordens.id, ordens.data_geracao, hora_geracao, ordens.descricao,
    ordens.tipo, ocorrencias.descricao as ocorrencia, executores.nome as executor_responsavel,";
    $c_sql = $c_sql . "  case
        when tipo_ordem='C' then 'Corretiva'
        when tipo_ordem='P' then 'Preventiva'
        END AS ordens_tipo_texto,
        setores.descricao AS setor, usuarios.nome AS solicitante  
    FROM ordens";
    $c_sql = $c_sql . " JOIN ocorrencias ON ordens.id_ocorrencia=ocorrencias.id  
        JOIN setores ON ordens.id_setor=setores.id
        JOIN usuarios ON ordens.id_solicitante=usuarios.id
        join executores on ordens.id_executor_responsavel=executores.id
        where ordens.id='$c_id'";
    // echo $c_sql;
    $result = $conection->query($c_sql);
    $c_linha = $result->fetch_assoc();
    // pego o email da manutenção
    $c_sql_config = "select email_manutencao from configuracoes";
    $result = $conection->query($c_sql_config);
    $c_linha_email = $result->fetch_assoc();
    $c_email = $c_linha_email['email_manutencao'];
    // aqui vai o código para enviar o email com os dados da ordem de serviço por anexo
    $c_arquivo = "impressao\ordem_servico_" . $c_linha['id'] . ".txt";
    $c_conteudo = "Ordem de Serviço Nº: " . $c_linha['id'] . "\n";
    $c_conteudo = $c_conteudo . "Data de Geração: " . date('d/m/Y', strtotime($c_linha['data_geracao'])) . " Hora: " . $c_linha['hora_geracao'] . "\n";
    $c_conteudo = $c_conteudo . "Solicitante: " . $c_linha['solicitante'] . "\n";
    $c_conteudo = $c_conteudo . "Setor: " . $c_linha['setor'] . "\n";
    $c_conteudo = $c_conteudo . "Tipo de Ordem: " . $c_linha['ordens_tipo_texto'] . "\n";
    $c_conteudo = $c_conteudo . "Ocorrência: " . $c_linha['ocorrencia'] . "\n";
    $c_conteudo = $c_conteudo . "Executor Responsável: " . $c_linha['executor_responsavel'] . "\n";
    // descrição da solicitação
    $c_conteudo = $c_conteudo . "Descrição da Solicitação: " . $c_linha['descricao'] . "\n";
    $c_conteudo = $c_conteudo . "Descrição: " . $c_linha['descricao'] . "\n";
    file_put_contents($c_arquivo, $c_conteudo);
    // envio do email com anexo
    $mail = new PHPMailer(true);
    try {
        //Server settings
        //$mail->SMTPDebug = SMTP::DEBUG_SERVER;                      //Enable verbose debug output
        $mail->CharSet = 'UTF-8';
        $mail->isSMTP();                                            //Send using SMTP
        $mail->Host       = $c_host_email;                     //Set the SMTP server to send through
        $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
        $mail->Username   = $c_email_envio;                     //SMTP username
        $mail->Password   = $c_senha_email;                               //SMTP password
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
        $mail->Port       = $c_porta_email;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`
        //$mail->Port       = 587; 
        //Recipients
        $mail->setFrom($c_email_envio, 'GOP');
        //echo $c_email;
        //die;
        $mail->addAddress($c_email, 'GOP');     // endereco para onde será enviado
        //Attachments
        $mail->addAttachment($c_arquivo);         //Add attachments
        //Content
        $mail->isHTML(true);                                  //Set email format to HTML
        $mail->Subject = 'Ordem de Serviço Nº: ' . $c_linha['id'];
        $mail->Body    = 'Segue em anexo a Ordem de Serviço Nº: ' . $c_linha['id'];

        $mail->send();
    } catch (Exception $e) {
        echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
    }
    // mensagem de sucesso no envio




    // (omitir detalhes de implementação do email)
    echo "<div class='container mt-3'><div class='alert alert-success'>Ordem de Serviço enviada por email com sucesso!</div></div>";
}
