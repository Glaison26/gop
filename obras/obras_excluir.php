<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

if (!isset($_GET["id"])) {
    header('location: /gop/obras/obras_lista.php');
    exit;
}
$c_id = "";
$c_id = $_GET["id"];
// conexão dom o banco de dados
// conexão dom o banco de dados
include("../conexao.php");
include("../links2.php");
include('../cabec_exclusao.php');
// Exclusão do registro
// verico se elxistem recursos com o tipo no cadastro
$c_sql_conta = "select count(*) nregistros from obras_insumos where id_obra=$c_id";  // relacionamnto com tabela de insumos de obras
$result = $conection->query($c_sql_conta);
$registro = $result->fetch_assoc();
if ($registro['nregistros'] == 0) {
    $c_sql = "delete from obra where id=$c_id";
    $result = $conection->query($c_sql);
    header('location: /gop/obras/obras_lista.php');
} else {
    echo "<script>alert('Não é possivel excluir registro!')</script>";
    echo "<div class='container-fluid'>
     <a class='btn btn-primary' href='/gop/obras/obras_lista.php'><span class='glyphicon glyphicon-off'></span> Voltar a Lista</a>
    </div>";
}
