<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// conexão dom o banco de dados
include("../conexao.php");
// rotina de inclusão
$c_descricao = rtrim($_POST['c_descricao']);
$c_sql = "select id from ferramentas where descricao='$c_descricao'";
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();
$i_id_ferramenta = $c_linha['id'];

$i_id_ordem = $_SESSION['id_ordem'];
$c_sql = "Insert into ordens_ferramentas (id_ferramenta, id_ordem) Value ('$i_id_ferramenta', '$i_id_ordem')";

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