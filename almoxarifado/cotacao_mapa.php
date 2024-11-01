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
$c_sql = "SELECT cotacao_fornecedor.id, fornecedores.descricao AS fornecedor, cotacao_fornecedor.valor_total,
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
    <h2>Mapa de Cotação</h2>
        <div class="panel panel-default">
            <div class="panel-heading"><strong>Mapa de Cotação No. <?php echo $i_id_cotacao ?></strong></div>
            <div class="panel-body">
                <?php
                while ($c_linha = $result->fetch_assoc()) {
                     echo '<strong>Fornecedor :</strong> ' .  $c_linha['fornecedor'].'<br>';
                     echo '<strong>Vendedor :</strong> ' . $c_linha['vendedor'].'<br>';
                     echo '<strong>Valor Total :</strong> ' . $formatter->formatCurrency($c_linha['valor_total'], 'BRL').'       '.
                     '<strong>Valor do Frete :</strong>'.$formatter->formatCurrency($c_linha['frete'], 'BRL').'        '.
                     '<strong> Valor Total :</strong>'.$formatter->formatCurrency($c_linha['frete']+$c_linha['valor_total'], 'BRL').'<br>';
                     echo '<strong> Prazo de Enterga :</strong> ' .  $c_linha['prazo'].' dias    '.
                     '<strong> Condição de Pagamento: </strong>'.$c_linha['forma_pagamento']. '<br>';
                     echo '<strong>Observação :</strong> ' .$c_linha['observacao']. '<br>';
                     echo '<br><br>';
                }
                ?>
            </div>
        </div>
    </div>


</body>

</html>