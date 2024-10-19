<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
include("../links2.php");
$c_id = $_GET["id"];

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/ordens/ordens_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do plano
    $c_sql = "SELECT * FROM ordens  
    where ordens.id='$c_id'";
    $result = $conection->query($c_sql);
    $c_linha = $result->fetch_assoc();
}


?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
    <div class="container">
        <h2>Ordem de Serviço no. <?php echo $c_id ?></h2>
        <div class="panel panel-default">
            <div class="panel-heading"></div>
            <div class="panel-body">
           
             <?php echo '<strong>Data da Geração :</strong>'.  date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_geracao']))). '<strong>  Hora da Geração :</strong>'.$c_linha['hora_geracao'];
             ?> 
            </div>
            <div class="panel-footer">Panel Footer</div>
        </div>
    </div>


</body>

</html>