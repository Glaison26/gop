<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// conexão dom o banco de dados
include("../conexao.php");
// rotina de inclusão
$c_descricao = rtrim($_POST['c_descricao']);
$c_sql = "select id from executores where nome='$c_descricao'";
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();
$i_id_executor = $c_linha['id'];

$i_id_preventiva = $_SESSION['id_preventiva'];
$c_sql = "Insert into preventivas_executores (id_executor, id_preventiva) Value ('$i_id_executor', '$i_id_preventiva')";

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