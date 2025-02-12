<?php // controle de acesso ao formulário
////////////////////////////////////////////////////////////////////////
// pagina informativa com as Ordens de serviços geradas pelas preventivas
/////////////////////////////////////////////////////////////////////////

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
date_default_timezone_set('America/Sao_Paulo');
// pegar ordens geradas
$c_data = date('Y/m/d');

$c_sql =  "SELECT ordens.id, ordens.id_oficina, ordens.descritivo, oficinas.descricao as oficina FROM ordens
JOIN oficinas ON ordens.id_oficina=oficinas.id
WHERE ordens.data_geracao='$c_data' ORDER BY ordens.id desc";
//echo $c_sql;
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();

// verifico se a query foi correto
if (!$result) {
    die("Erro ao Executar Sql!!" . $conection->connect_error);
}

// rotina para enviar e-mail para as oficinas e manutenção
// pego email de configuração via sql
$c_sql_config = 'select * from config';
$result = $conection->query($c_sql_config);
$c_linha_conf = $result->fetch_assoc();
$c_email = $c_linha_conf['email'];
// loop para capturar preventivas geradas no dia
while ($c_linha = $result->fetch_assoc()) {
    // variaveis para envio de e-mail 

    if (filter_var($c_email, FILTER_VALIDATE_EMAIL)) {
        $c_sql = "SELECT MAX(solicitacao.ID) AS id_solicitacao FROM solicitacao";
        $result = $conection->query($c_sql);
        $c_linha = $result->fetch_assoc();
        $solicitacao = $c_linha['id_solicitacao'];
        $c_assunto = "Abertura de Solicitação de Serviço no GOP";
        $c_body = "Solicitação No.<b> $solicitacao </b> foi gerada com suceso! Aguarde o atendimento <br>"
            . "Descrição da Solicitação :" . $c_descricao;
        include('../email_gop.php');
    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Resumo de Ordens de Serviços Geradas por preventivas<h5>
        </div>
    </div>

    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h4>Lista de Ordens de Serviço Geradas pelas preventivas do dia <?php echo date('d/m/y'); ?> </h4>
        </div>

        <table class="table table display table-bordered tabordens">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Descritivo</th>
                    <th scope="col">Oficina</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql

                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {

                    echo "
                                <tr class='info'>
                                    <td>$c_linha[id]</td>
                                    <td>$c_linha[descritivo]</td>
                                    <td>$c_linha[oficina]</td>

                                </tr>
                                ";
                }
                ?>

            </tbody>
        </table>
        <div style="padding-bottom:15px;">
            <a class="btn btn btn-primary" href="/gop/preventivas/preventivas.php"><span class="glyphicon glyphicon-off"></span> Finalizar</a><br>
        </div>
    </div>

</body>

</html>