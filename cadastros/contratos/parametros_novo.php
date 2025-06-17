<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// conexão dom o banco de dados
include("../../conexao.php");
// rotina de inclusão
$i_id_contrato = $_SESSION['id_contrato'];
$c_descricao = rtrim($_POST['c_descricao']);
$c_unidade = $_POST['c_unidade'];
$c_sql = "Insert into contratos_parametros (descricao, unidade, id_contrato ) Value ('$c_descricao','$c_unidade', '$i_id_contrato')";
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