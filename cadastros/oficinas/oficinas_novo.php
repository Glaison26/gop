<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// conexão dom o banco de dados
include("../../conexao.php");
// rotina de inclusão
$c_descricao = rtrim($_POST['c_descricao']);
$c_fone1 = $_POST['c_fone1'];
$c_fone2 = $_POST['c_fone2'];
$c_responsavel = $_POST['c_responsavel'];
$c_email = $_POST['c_email'] ;
$c_sql = "Insert into oficinas (descricao, fone1, fone2, responsavel, email) 
Value ('$c_descricao', '$c_fone1', '$c_fone2', '$c_responsavel', '$c_email')";
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