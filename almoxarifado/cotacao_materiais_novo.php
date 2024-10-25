<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// conexão dom o banco de dados
include("../conexao.php");
$c_material = rtrim($_POST['c_material']);
$c_unidade = rtrim($_POST['c_unidade']);
$c_quantidade = $_POST['c_quantidade'];

// sql para pegar o id do material
$c_sql = "select id, descricao, id_unidadeEntrada from materiais where descricao = '$c_material'";

$result = $conection->query($c_sql);
$c_registro = $result->fetch_assoc();
$i_id_material = $c_registro['id'];
//$i_id_unidade = $c_registro['id_unidadeEntrada'];
//

// pego o id da unidade de medida com sql
$c_sql2 = "select id, descricao from unidades where descricao = '$c_unidade'";
//$_SESSION['sql']=$c_sql2;
$result2 = $conection->query($c_sql2);
$c_registro2 = $c_result2->fetch_assoc();
$i_id_unidade = $c_registro2['id'];
$_SESSION['sql']=$i_id_unidade;
// rotina de inclusão
//$i_id_unidade = 10;
$i_id_cotacao = $_SESSION['id_cotacao']; // pego o id da cotação
$c_sql3 = "Insert into cotacao_materiais (id_cotacao, id_material, id_unidade, quantidade) Value ('$i_id_cotacao', '$i_id_material','$i_id_unidade','$c_quantidade' )";

$result3 = $conection->query($c_sql3);

if($result3 ==true)
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