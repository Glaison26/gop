<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
$id_anexo =  $_GET["id"];
// sql para buscar descrição do POP
$c_sql_anexo = "Select id, path from pop_anexos where id='$id_anexo'";
$result_anexo = $conection->query($c_sql_anexo);
$registro_anexo = $result_anexo->fetch_assoc();
$arquivo = $registro_anexo['path'];

$file = $arquivo;

if (file_exists($file)) {
    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename="'.basename($file).'"');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($file));
    readfile($file);
    exit;
}
?>