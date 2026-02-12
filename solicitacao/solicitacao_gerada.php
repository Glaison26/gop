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
if (isset($_POST['btn_acessar']) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {
   $_SESSION['consulta_solicitacao'] = $c_linha['id_solicitacao'];
   header('location: /gop/solicitacao/solicitacao.php');
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
        <div class="alert alert-success" role="alert">
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\certo.png" alt="30" height="35">
            </div>
            <!-- mensagem de sucesso na geração da solicitação com o numero da solicitação -->
            <h5>Solicitação de Serviço nº <?php echo $c_linha['id_solicitacao']; ?> gerada com sucesso!</h5>
        <hr>
        <form method="POST">
            <button type="submit" name="btn_acessar" class="btn btn-primary"><span class='glyphicon glyphicon-share-alt'></span> Acessar</button>
            <a class="btn btn btn-success" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Encerrar</a>
        </form>


    </div>
</body>

</html>