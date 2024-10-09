<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// conexão dom o banco de dados
include("../conexao.php");
// sql para pegar o id do setor selecionado
$c_setor = $_POST['c_setor'];
$c_sql_setor = "Select id from setores where descricao='$c_setor'";
$result_setor = $conection->query($c_sql_setor);
$registro_setor = $result_setor->fetch_assoc();
$i_setor = $registro_setor['id'];
// rotina de inclusão
$c_data=$_POST['c_data'];
$c_gerencia = $_POST['c_gerencia'];
$c_meta = $_POST['c_meta'];
$c_descritivo = $_POST['c_descritivo'];
//
$c_sql = "Insert into planejamento (id_setor, data, gerencia, descritivo, meta) 
Value ('$i_setor', '$c_data', '$c_gerencia', '$c_descritivo', '$c_meta')";

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
