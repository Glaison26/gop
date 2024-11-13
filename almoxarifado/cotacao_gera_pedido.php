<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Geração de Pedido de Compra<h5>
        </div>
    </div>
    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="" width="50" height="45">

            </div>
            <h5>Entre com as informações para geração do Pedido de Compra</h5>
        </div>

        <form method="POST" onsubmit="return confirm('Confirma geração do Pedido de Compra?')">
            <hr>
            <button type="submit" class="btn btn btn-sm" name="btnpedido" id="btnpedido" href=""><img src="\gop\images\compras.png" alt="" width="25" height="25"> Gerar Pedido de Compra</button>
            <a class="btn btn btn-sm" href="\gop\almoxarifado\cotacao_fornecedores.php"><img src="\gop\images\saida.png" alt="" width="25" height="25"> Voltar</a>
            <hr>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Tipo do pedido</label>
                <div class="col-sm-5">
                    <select class="form-select form-select-lg mb-3" id="tipo" name="tipo" required>
                        <option></option>
                        <option>Avulsas Internas</option>
                        <option>Manutenção</option>
                        <option>Operacionais</option>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Comprador</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="comprador" required>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Observação</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="obs" name="obs" rows="6"></textarea>
                </div>
            </div>

        </form>
    </div>

</body>

</html>


<?php

$c_data = date('Y-m-d');
// rotina para gerar pedido a apartir de uma cotação realizada
$i_id = $_GET['id'];
// rotina de geração do pedido
if (isset($_POST['btnpedido']) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {
    // Seleciono cotação de fornecedor requisitada
    $c_sql = "select * from cotacao_fornecedor where id='$i_id'";
    $result = $conection->query($c_sql);
    $c_linha = $result->fetch_assoc();
    // capturo cotação de origem para pegar o tipo (M=material/S==serviços)
    $c_sql = "select cotacao.id, cotacao.tipo from cotacao where id ='$c_linha[id_cotacao]'";
    $result2 = $conection->query($c_sql);
    $c_linha2 = $result2->fetch_assoc();
    // insiro dados na tabela de compras
    $c_sql_ins = "insert into compras (id_fornecedor, id_cotacao_fornecedor, data, condicoes_pag, prazo,
     valor, valor_frete, tipo_compra, comprador,tipo, status) 
value ('$c_linha[id_fornecedor]', '$i_id','$c_data','$c_linha[forma_pagamento]','$c_linha[prazo]',
'$c_linha[valor_total]','$c_linha[frete]','$c_linha2[tipo]', '$_POST[comprador]','$_POST[tipo]','A' )";
    //echo $c_sql_ins;    
    $result_ins = $conection->query($c_sql_ins);
    // insiro materiais da cotação
    // pego a ultima compra gerada
    $c_sql_ult = "SELECT MAX(compras.ID) AS id_compra FROM compras";
    $result_ult = $conection->query($c_sql_ult);
    $registro_compra = $result_ult->fetch_assoc();
    //
    $c_sql = "SELECT * FROM cotacao_materiais_fornecedor 
    WHERE cotacao_materiais_fornecedor.id_cotacao_fornecedor='$i_id'";
    $result = $conection->query($c_sql);
    while ($c_linha = $result->fetch_assoc()) {
        // inserir na tabela de materias de compra
        $c_sql_ins = "insert into compras_materiais (id_compra, id_material, quantidade, valor_unitario,
        valor_total,  id_unidade) 
        value ('$registro_compra[id_compra]', '$c_linha[id_material]', '$c_linha[quantidade]', 
        '$c_linha[valor_unitario]', '$c_linha[valor_total]', '$c_linha[id_unidade]')";
        $result_compras = $conection->query($c_sql_ins);

    }

    echo "<script>alert('Pedido de Compra gerado com Sucesso!!')</script>";
    //header('location: /gop/almoxarifado/cotacao_fornecedores.php');

}

?>