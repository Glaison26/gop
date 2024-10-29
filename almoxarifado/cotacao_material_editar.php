<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// conexão dom o banco de dados
include("../conexao.php");

// rotina de edição
$c_id = $_POST['c_id'];
$c_valor_unitario = $_POST['c_valor_unitario'];
$c_prazo = $_POST['c_prazo'];
$c_qtd = $_POST['c_qtd'];
$c_total = $c_qtd*$c_valor_unitario;

$c_sql = "Update cotacao_materiais_fornecedor" .
    " SET valor_unitario = '$c_valor_unitario', prazo_entrega='$c_prazo', valor_total = '$c_total' where id=$c_id";

$result = $conection->query($c_sql);

if ($result == true) {

    $data = array(
        'status' => 'true',
    );

    echo json_encode($data);
} else {
    $data = array(
        'status' => 'false',

    );

    echo json_encode($data);
}
