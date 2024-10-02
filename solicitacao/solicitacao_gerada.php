<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
// pegar recurso
$c_sql =    "SELECT MAX(solicitacao.ID) AS id_solicitacao FROM solicitacao";

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
            <h5>Conclusão de abertura de Solicitação de Serviço<h5>
        </div>
    </div>


    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h3>Solicitação de serviço No. <?php echo $solicitacao ?> foi gerada com sucesso! Clique em encerrar para voltar ao menu.</h3>
        </div>

        <a class="btn btn btn-success" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Encerrar</a>
    </div>
</body>

</html>