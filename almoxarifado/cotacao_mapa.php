<?php
// emissão de mapa de cotação
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
$i_id_cotacao = $_SESSION['id_cotacao'];
$c_sql = "SELECT cotacao_fornecedor.id, cotacao_fornecedor.id_cotacao,  fornecedores.id as fornecedor_id, fornecedores.descricao AS fornecedor, cotacao_fornecedor.valor_total,
          cotacao_fornecedor.frete, cotacao_fornecedor.prazo, forma_pagamento, cotacao_fornecedor.vendedor,
          case 
            when status='P' then 'Participante'
            when status='V' then 'Vencedor'
            when status='B' then 'Melhor Preço e Prazo'
            when status='C' then 'Melhor Preço'
            when status='Z' then 'Melhor Prazo'
          END AS status_texto,
          cotacao_fornecedor.observacao
          FROM cotacao_fornecedor
          JOIN fornecedores ON cotacao_fornecedor.id_fornecedor=fornecedores.id
          WHERE cotacao_fornecedor.id_cotacao='$i_id_cotacao'
          ORDER BY fornecedores.descricao";
//echo $c_sql;
$result = $conection->query($c_sql);
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="container">
        <h2 class="text-center">Mapa de Cotação</h2><br>
        <div class="panel panel-default">
            <div class="panel-heading text-center"><strong>Mapa de Cotação No. <?php echo $i_id_cotacao ?></strong></div>

            <?php
            while ($c_linha = $result->fetch_assoc()) {
                echo '<div class="panel-body">';
                $i_id_fornecedor = $c_linha['fornecedor_id'];
                $i_id_cotacao = $c_linha['id'];
                echo '<h4 class="text-left">Informações do Participante</h4><br>';
                echo '<strong>Fornecedor :</strong> ' .  $c_linha['fornecedor'] . '<br>';
                echo '<strong>Vendedor :</strong> ' . $c_linha['vendedor'] . '<br>';
                echo '<strong>Valor Total :</strong> ' . $formatter->formatCurrency($c_linha['valor_total'], 'BRL') . '       ' .
                    '<strong>Valor do Frete :</strong>' . $formatter->formatCurrency($c_linha['frete'], 'BRL') . '        ' .
                    '<strong> Valor Total :</strong>' . $formatter->formatCurrency($c_linha['frete'] + $c_linha['valor_total'], 'BRL') . '<br>';
                echo '<strong> Prazo de Enterga :</strong> ' .  $c_linha['prazo'] . ' dias    ' .
                    '<strong> Condição de Pagamento: </strong>' . $c_linha['forma_pagamento'] . '<br>';
                echo '<strong>Observação :</strong> ' . $c_linha['observacao'] . '<br>';
                echo '<br><br>';
                // loop para pegar os itens da cotação do fornecedor
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT cotacao_materiais_fornecedor.id, materiais.descricao AS material, cotacao_materiais_fornecedor.valor_unitario,
                    cotacao_materiais_fornecedor.valor_total, cotacao_materiais_fornecedor.prazo_entrega,cotacao_materiais_fornecedor.quantidade
                    FROM cotacao_materiais_fornecedor
                    JOIN materiais ON cotacao_materiais_fornecedor.id_material=materiais.id
                    where id_cotacao_fornecedor='$i_id_cotacao'";
                //echo $c_sql;
                $result2 = $conection->query($c_sql);
                // loop de leitura dos itens
                echo '<h4 class="text-left">Cotação dos Materiais</h4><br>';
                while ($c_linha2 = $result2->fetch_assoc()) {
                    if ($c_linha2['valor_unitario'] == 0)
                        $c_valor_unitario = 'R$ 0.00';
                    else
                        $c_valor_unitario = $formatter->formatCurrency($c_linha2['valor_unitario'], 'BRL');
                    //
                    if ($c_linha2['valor_total'] == 0)
                        $c_valor_total = 'R$ 0.00';
                    else
                        $c_valor_total = $formatter->formatCurrency($c_linha2['valor_total'], 'BRL');
                    //
                    echo $c_linha2['material'] . ' -' . '<strong>      Valor Unitário :</strong>' . '   ' .
                        $c_valor_unitario . ' - ' . '<strong>Quantidade :</strong> ' .  $c_linha2['quantidade'] . ' -' . '</strong>
                        <strong>      Valor Total :</strong>' . $c_valor_total . '<br>';
                }
                echo '</div>';
                echo '<br>';
            }

            ?>
        </div>
    </div>
    </div>


</body>

</html>