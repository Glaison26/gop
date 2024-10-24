<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// conexão dom o banco de dados
include("../conexao.php");
// sql para responsavel (usuário logado)
// procuro solicitante
$c_responsavel = $_SESSION['c_usuario'];
$c_sql = "Select id from usuarios where login='$c_responsavel'";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
$id_responsavel = $registro['id'];

// rotina de inclusão
$c_descritivo = rtrim($_POST['c_descritivo']);
$c_data = $_POST['c_data'];
$c_sql = "Insert into cotacao (descritivo, data, id_responsavel, status) Value ('$c_descritivo', '$c_data','$id_responsavel', 'A')";
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