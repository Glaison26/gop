<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// conexão dom o banco de dados
include("conexao.php");
// rotina de inclusão
$c_descricao = rtrim($_POST['c_descricao']);
$c_valor = $_POST['c_valor'];
$c_sql = "Insert into funcoes (descricao, ValorHora) Value ('$c_descricao', '$c_valor')";
$result = $conection->query($c_sql);

if($result ==true)
{
   
    $data = array(
        'status'=>'true',
       
    );

    echo json_encode($data);
}
else
{
     $data = array(
        'status'=>'false',
  
    );

    echo json_encode($data);
} 

?>