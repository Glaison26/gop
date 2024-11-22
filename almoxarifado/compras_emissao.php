<?php

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
$i_id_pedido = $_GET['id'];
// sql para pegar dados do pedido de compra de acordo com a escolha
$c_sql = "SELECT *, fornecedores.descricao as fornecedor , fornecedores.cnpj_cpf, fornecedores.insc_estad, 
fornecedores.insc_munic,fone1, fone2,endereco,bairro, cidade,estado, email,contato from compras
JOIN fornecedores ON compras.id_fornecedor = fornecedores.id
where compras.id='$i_id_pedido'";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
// pego os itens do pedido de compra selecionado
$c_sql = "Select *, unidades.abreviatura as unidade, materiais.descricao as material from compras_materiais 
join unidades on compras_materiais.id_unidade=unidades.id
join materiais on compras_materiais.id_material=materiais.id
where id_compra='$i_id_pedido'";
$result_itens = $conection->query($c_sql);
?>

<!----------------------------------------------------
     Montagem do formulario com os dados selecionados
 ----------------------------------------------------->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="container">
        <h2 class="text-center">Pedido de Compra</h2><br>
        <div class="panel panel-default">
            <div class="panel-heading text-center"><strong>Pedido de Compra No. <?php echo $i_id_pedido ?></strong></div>
            <?php
            echo '<h4 class="text-center">Informações do Pedido</h4><br>';
            echo '&nbsp; <strong>Descrição do Pedido :&nbsp;' . $registro['descritivo'] . '</strong><br><br>';
            echo '&nbsp; <strong>Fornecedor :&nbsp;' . $registro['fornecedor'] . '&nbsp;&nbsp;&nbsp; CNPJ/CPF :  ' . $registro['cnpj_cpf'] . '</strong><br><br>';
            echo '&nbsp; <strong>Inscrição Estatual :&nbsp;' . $registro['insc_estad'] . '&nbsp;&nbsp;&nbsp; Inscrição Municipal :&nbsp; ' .
                $registro['insc_munic'] . '&nbsp; Fone 1 :&nbsp; ' . $registro['fone1'] . '&nbsp;&nbsp; Fone 2 :&nbsp; ' . $registro['fone2'] . '</strong><br><br>';
            echo '&nbsp; <strong>Endereço :' . $registro['endereco'] . '&nbsp; -&nbsp;' . $registro['bairro'] . '&nbsp;&nbsp; CEP : ' .
                $registro['cep'] . '&nbsp;&nbsp;Cidade/UF : ' . $registro['cidade'] . '/' . $registro['estado'] . '<br><br>';
            echo '&nbsp; <strong>e-mail :' . $registro['email'] . '&nbsp;&nbsp; Contato : ' . $registro['contato'] . '</strong><br><br>';
            echo '<div class="panel panel-default">';
            echo '<div class="panel-heading text-center"><h4>Itens do Pedido</h4></div>';

            $i_contador = 0;
            while ($registro_itens = $result_itens->fetch_assoc()) {
                $i_contador += 1;
                if ($i_contador < 10)
                    $i_contador = '0' . $i_contador;

                echo '<h5><b>&nbsp;Item</b>' . ' ' . $i_contador . '&nbsp;&nbsp;<b>Qtde. :</b>' . $registro_itens['quantidade'] .
                    '&nbsp;&nbsp;<b>Und.:</b>' . $registro_itens['unidade'] . '&nbsp;&nbsp;&nbsp;<b>Descrição do Item :</b> ' . $registro_itens['material'] . '&nbsp;&nbsp;' .
                    '<b>Valor Unitário :</b>' . $formatter->formatCurrency($registro_itens['valor_unitario'], 'BRL') . '&nbsp;&nbsp;&nbsp;
                 <b>Valor Total :</b>' . $formatter->formatCurrency($registro_itens['valor_total'], 'BRL') . '</h5>';
            }
            ?>
        </div>
        <?php
        echo '&nbsp;' . 'Valor do Frete :' . $formatter->formatCurrency($registro['valor_frete'], 'BRL') . '<br>';
        echo '&nbsp;' . 'Valor dos Itens :' . $formatter->formatCurrency($registro['valor'], 'BRL') . '<br>';
        echo '&nbsp;' . 'Total do Pedido :' . $formatter->formatCurrency($registro['valor'] + $registro['valor_frete'], 'BRL') . '<br>';
        ?>
    </div>
</body>