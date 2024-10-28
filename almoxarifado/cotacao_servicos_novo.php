<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// conexão dom o banco de dados
include("../conexao.php");

// rotina de inclusão
$c_descritivo = rtrim($_POST['c_descritivo']);
$i_id_cotacao = $_SESSION['id_cotacao']; // pego o id da cotação
$c_sql = "Insert into cotacao_servicos (id_cotacao, descricao) Value 
('$i_id_cotacao','$c_descritivo')";
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