<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// conexão dom o banco de dados
include("../../conexao.php");
// rotina de inclusão
$c_descricao = rtrim($_POST['c_descricao']);
$c_texto = $_POST['c_texto'];
$c_texto_fechamento = $_POST['c_texto_fechamento'];
$c_tempo_horas = $_POST['c_tempo_hora'];
$c_tempo_minutos = $_POST['c_tempo_minuto'];
$c_sql = "Insert into ocorrencias (descricao, texto, texto_fechamento, tempo_hora, tempo_minuto)
 Value ('$c_descricao', '$c_texto', '$c_texto_fechamento', '$c_tempo_horas', '$c_tempo_minutos')";
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
