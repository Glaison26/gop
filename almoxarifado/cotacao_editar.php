<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// conexão dom o banco de dados
include("../conexao.php");

// rotina de edição
$c_id = $_POST['c_id'];
$c_descritivo = rtrim($_POST['c_descritivo']);
$c_tipo = $_POST['c_tipo'];

if ($c_tipo == 'Serviço')
    $c_tipo = 'S';
else
    $c_tipo = 'M';

$c_sql = "Update cotacao" .
    " SET descritivo = '$c_descritivo', tipo = '$c_tipo' where id=$c_id";

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
