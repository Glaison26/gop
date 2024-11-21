<?php

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
$i_id_pedido = $_GET['id'];

$c_sql = "SELECT *, fornecedores.descricao AS fornecedor from compras
JOIN fornecedores ON compras.id_fornecedor = fornecedores.id";
$result = $conection->

?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="container">
        <h2 class="text-center">Pedido de Compra</h2><br>
        <div class="panel panel-default">
            <div class="panel-heading text-center"><strong>Pedido de Compra No. <?php echo $i_id_pedido ?></strong></div>
        </div>
        <?php
        echo '<h4 class="text-left">- Informações do Pedido -</h4><br>';
        echo '<strong>Fornecedor :</strong><br>';
        ?>
    </div>
</body>