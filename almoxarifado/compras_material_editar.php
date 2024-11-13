<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// conexão dom o banco de dados
include("../conexao.php");

// rotina de edição
$c_id = $_POST['c_id'];
$c_fator = ltrim($_POST['c_fator']);

//

$c_sql = "Update compras_materiais" .
    " SET fator_conversao = '$c_fator' where id=$c_id";

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
