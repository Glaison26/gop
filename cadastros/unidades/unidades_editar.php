<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// conexão dom o banco de dados
include("../../conexao.php");

// rotina de edição
$c_id = $_POST['c_id'];
$c_descricao = rtrim($_POST['c_descricao']);
$c_abreviatura = rtrim($_POST['c_abreviatura']);

$c_sql = "Update unidades" .
    " SET descricao = '$c_descricao', abreviatura = '$c_abreviatura' where id=$c_id";

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