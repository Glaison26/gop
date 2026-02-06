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
define('FPDF_FONTPATH', '../fpdf/font/');

$c_id = $_GET["id"];
if ($_SERVER['REQUEST_METHOD'] == 'POST') {  // metodo post para envio do email

    if (!isset($_GET["id"])) {
        header('location: /gop/ordens/ordens_lista.php');
        exit;
    }

    $c_id = $_GET["id"];

    // leitura da ordem de serviço
    $c_sql = "SELECT ordens.id, ordens.data_geracao, hora_geracao, ordens.descricao,
    ordens.tipo, ocorrencias.descricao as ocorrencia, executores.nome as executor_responsavel, oficinas.descricao 
        as oficina, oficinas.email as email_oficina, executores.email as email_executor, case
        when ordens.tipo_ordem='C' then 'Corretiva'
        when ordens.tipo_ordem='P' then 'Preventiva'
        END AS ordens_tipo_texto,
        setores.descricao AS setor, usuarios.nome AS solicitante,";
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
        join oficinas on ordens.id_oficina=oficinas.id
        where ordens.id='$c_id'";
    // echo $c_sql;
    $result = $conection->query($c_sql);
    $c_linha = $result->fetch_assoc();
        // sql para pegar material utilizado na ordem de serviço contendo o nome do material, quantidade, unidades de medida usando a tabela ordens_materiais
    $c_sql_materiais = "SELECT materiais.descricao, ordens_materiais.quantidade, unidades.descricao as unidade_medida FROM ordens_materiais
    JOIN materiais ON ordens_materiais.id_material=materiais.id
    JOIN unidades ON materiais.id_unidadeSaida=unidades.id
    where ordens_materiais.id_ordem='$c_id'";
    $result_materiais = $conection->query($c_sql_materiais);

    // sql para pegar os executores envolvidos na ordem de serviço usando a tabela ordens_executores
    $c_sql_executores = "SELECT executores.nome, funcoes.descricao as funcao FROM ordens_executores
    JOIN executores ON ordens_executores.id_executor=executores.id
    JOIN funcoes ON executores.id_funcao=funcoes.id
    where ordens_executores.id_ordem='$c_id'";
    $result_executores = $conection->query($c_sql_executores);

    // pego o email da manutenção
    $c_sql_config = "select email_manutencao from configuracoes";
    $result = $conection->query($c_sql_config);
    $c_linha_email = $result->fetch_assoc();
    $c_email = $c_linha_email['email_manutencao'];
    // pego o email da oficina
    $c_email_oficina = $c_linha['email_oficina'];
    // pego o email do executor
    $c_email_executor = $c_linha['email_executor'];
    // aqui vai o código para enviar o email com os dados da ordem de serviço por anexo
    // Gero arquivo em pdpf com os dados da ordem de serviço usando a biblioteca FPDF
    require('../fpdf/fpdf.php');
    
    $pdf = new FPDF();
    $pdf->AddPage();
    $pdf->SetFont('Arial','B',16);
    $pdf->Cell(40,10, ('Ordem de Serviço Nº: ' . $c_linha['id']));
    $pdf->Ln();
    $pdf->SetFont('Arial','',12);
    $pdf->Cell(40,10,'Data de Geração: ' . date('d/m/Y', strtotime($c_linha['data_geracao'])) . ' Hora: ' . $c_linha['hora_geracao']);
    $pdf->Ln();
    $pdf->Cell(40,10,'Solicitante: ' . $c_linha['solicitante']);
    $pdf->Ln();
    $pdf->Cell(40,10,'Setor: ' . $c_linha['setor']);
    $pdf->Ln();
    if ($c_linha['tipo'] == 'R')
        $pdf->Cell(40,10,'Recurso: ' . $c_linha['recurso']);
    if ($c_linha['tipo'] == 'E')
        $pdf->Cell(40,10,'Espaço: ' . $c_linha['espaco']);
    $pdf->Ln();
    $pdf->Cell(40,10,'Tipo de Ordem: ' .  $c_linha['ordens_tipo_texto']);
    $pdf->Ln();
    $pdf->Cell(40,10,'Ocorrência: ' .  $c_linha['ocorrencia']);
    $pdf->Ln();
    if (!empty($c_linha['oficina']))
        $pdf->Cell(40,10,'Oficina: ' .  $c_linha['oficina']);
    $pdf->Ln();
    $pdf->Cell(40,10,'Executor Responsável: ' .  $c_linha['executor_responsavel']);
    $pdf->Ln();
    $pdf->Cell(40,10,'Descrição da Solicitação:');
    $pdf->Ln();
    $pdf->MultiCell(0,10,$c_linha['descricao']);
    $pdf->Ln();
    $pdf->Cell(40,10,'Materiais Utilizados:');
    $pdf->Ln();
    if ($result_materiais->num_rows > 0) {
        while ($row = $result_materiais->fetch_assoc()) {
            $pdf->Cell(40,10,'- ' . $row['descricao'] . ' - Quantidade: ' . $row['quantidade'] . ' ' . $row['unidade_medida']);
            $pdf->Ln();
        }
    }
    $pdf->Ln();
    $pdf->Cell(40,10,'Executores Envolvidos:');
    if ($result_executores->num_rows > 0) {
        while ($row = $result_executores->fetch_assoc()) {
            $pdf->Cell(40,10,'- ' . $row['nome'] . ' - Função: ' . $row['funcao']);
            $pdf->Ln();
        }
    } else {
         $pdf->Cell(40,10,'Nenhum executor envolvido.');
         $pdf->Ln();
     }

    // salvo o pdf em um arquivo temporário
    $c_arquivo_pdf = "impressao\ordem_servico_" . $c_linha['id'] . ".pdf";
    $pdf->Output('F', $c_arquivo_pdf);
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
        // envio para oficina
        if (!empty($c_email_oficina))
            $mail->addCC($c_email_oficina, 'GOP');
         // envio para executor
        if (!empty($c_email_executor))
            $mail->addCC($c_email_executor, 'GOP');
        //Attachments
        $mail->addAttachment($c_arquivo_pdf);         //Add attachments
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
