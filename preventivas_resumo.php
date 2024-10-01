<?php // controle de acesso ao formulário
////////////////////////////////////////////////////////////////////////
// pagina informativa com as Ordens de serviços geradas pelas preventivas
/////////////////////////////////////////////////////////////////////////

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("conexao.php");
include("links2.php");
// pegar ordens geradas
$c_data = date('Y/m/d H:i');
$c_sql =  "SELECT  FROM ordens";

$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();
$solicitacao = $c_linha['id_solicitacao'];
// verifico se a query foi correto
if (!$result) {
    die("Erro ao Executar Sql!!" . $conection->connect_error);
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
            <h3>Lista de Ordens de Serviço Geradas pelas preventivas do dia.</h3>
        </div>

        <a class="btn btn btn-success" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Encerrar</a>
    </div>

</body>

</html>