<?php
////////////////////////////////////////////////////////////
// rotina verifica se os itens foram anexados ao fornecedor.
// se não inclui os itens já inclui a cotação por fornecedor
////////////////////////////////////////////////////////////
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");

if (isset($_GET['id'])) {
    $i_id = $_GET['id'];
    $_SESSION['id_material_fornecedor'] = $i_id;
} else {
    $i_id = $_SESSION['id_material_fornecedor'];
}
// sql para captura id do fornecedor
$c_sql_fornec = "select id_fornecedor from cotacao_fornecedor where id='$i_id '";
$result_fornec = $conection->query($c_sql_fornec);
$c_linha_fornec = $result_fornec->fetch_assoc();
$i_id_fornecedor = $c_linha_fornec['id_fornecedor'];
// verifico se já existem dados para o fornecedor 
$c_sql_conta = "SELECT COUNT(*) AS registros FROM cotacao_materiais_fornecedor where id_cotacao_fornecedor=' $i_id' and id_fornecedor='$i_id_fornecedor'";

$result_conta = $conection->query($c_sql_conta);
$c_linha = $result_conta->fetch_assoc();
//
// checo se existem registros
if ($c_linha['registros'] == 0) {
    $i_id_cotacao = $_SESSION['id_cotacao'];
    // monto sql para pegar os materias incluido para cotação
    $c_sql = "SELECT cotacao_materiais.id, cotacao_materiais.id_material, cotacao_materiais.id_unidade,
                    cotacao_materiais.quantidade
                    FROM cotacao_materiais
                    WHERE cotacao_materiais.id_cotacao='$i_id_cotacao'";
    $result = $conection->query($c_sql);
    echo $c_sql;
    // verifico se a query foi correto
    if (!$result) {
        die("Erro ao Executar Sql!!" . $conection->connect_error);
    }
    // loop para inclusão dos materias nata tabea de cotação X materiais
    while ($c_linha = $result->fetch_assoc()) {
        $i_id_material = $c_linha['id_material'];
        // insiro registro com os dados dos materiais selecionados
        $c_sql_add = "Insert into cotacao_materiais_fornecedor (id_cotacao_fornecedor,id_fornecedor, id_material) values ('$i_id', '$i_id_fornecedor', '$i_id_material' )";
        $result_add = $conection->query($c_sql_add);
        // verifico se a query foi correto
        if (!$result_add) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>

</body>

</html>