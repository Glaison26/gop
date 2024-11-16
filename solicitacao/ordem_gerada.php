<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
// pegar recurso
$c_sql =    "SELECT MAX(ordens.ID) AS id_ordem FROM ordens";

$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();
$ordem = $c_linha['id_ordem'];
// verifico se a query foi correto
if (!$result) {
    die("Erro ao Executar Sql!!" . $conection->connect_error);
}
if (isset($_POST['btn_acessar']) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {
    $_SESSION['consulta_ordem'] = $c_linha['id_ordem'];
    header('location: /gop/ordens/ordens.php');
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
            <h5>Conclusão de Geração de Ordem de Serviço<h5>
        </div>
    </div>
   

    <div class="container  -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h3>Ordem de serviço No. <?php echo $ordem?> foi gerada com sucesso!  Clique em encerrar para voltar ao menu ou em acessar para consultar Ordem a gerada.</h3>
        </div>
        <form method="post" action="">
        <button type="submit" name="btn_acessar" class="btn btn-primary"><span class='glyphicon glyphicon-share-alt'></span> Acessar</button>
        <a class="btn btn btn-success" href="/gop/solicitacao/solicitacao_lista.php"><span class="glyphicon glyphicon-off"></span> Encerrar</a>
        </form>
    </div>
</body>

</html>