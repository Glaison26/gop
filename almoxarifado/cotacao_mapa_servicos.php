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
        <h2 class="text-center">Mapa de Cotação de Materiais</h2><br>
        <div class="panel panel-default">
            <div class="panel-heading text-center"><strong>Mapa de Cotação No. <?php echo $i_id_cotacao ?></strong></div>

            <?php

            while ($c_linha = $result->fetch_assoc()) {
                $i_id_cotacaogaficos = $c_linha['id_cotacao'];
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
                echo '<strong> Status : </strong>' . $c_linha['status_texto'] . '<br>';
                echo '<strong>Observação :</strong> ' . $c_linha['observacao'] . '<br>';
                echo '<br><br>';
                // loop para pegar os itens da cotação do fornecedor
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT cotacao_servicos_fornecedores.id, cotacao_servicos_fornecedores.id_servico, cotacao_servicos.descricao as servico, 
                       cotacao_servicos_fornecedores.valor, 
                        cotacao_servicos_fornecedores.prazo_entrega
                        FROM cotacao_servicos_fornecedores
                        JOIN cotacao_servicos ON cotacao_servicos_fornecedores.id_servico=cotacao_servicos.id
                        where id_cotacao_fornecedor='$i_id_cotacao'";
                //echo $c_sql;
                $result2 = $conection->query($c_sql);
                // loop de leitura dos itens
                echo '<h4 class="text-left">Cotação de serviços</h4><br>';
                while ($c_linha2 = $result2->fetch_assoc()) {

                    if ($c_linha2['valor'] == 0)
                        $c_valor_total = 'R$ 0.00';
                    else
                        $c_valor_total = $formatter->formatCurrency($c_linha2['valor'], 'BRL');
                    //
                    echo $c_linha2['servico'] . '<br>' .

                        '<strong>      Valor Total :</strong>' . $c_valor_total . '<br>';
                }
                echo '</div>';
                echo '<br>';
            }

            ?>
        </div>
    </div>


    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


    <script type="text/javascript">
        // gráfico por Valor
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Fornecedores', 'Valor da Cotação'],

                <?php
                $formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
                $c_sql3 = "SELECT cotacao_fornecedor.id, fornecedores.descricao as fornecedor, valor_total
                        FROM cotacao_fornecedor
                        JOIN fornecedores ON cotacao_fornecedor.id_fornecedor=fornecedores.id
                        WHERE cotacao_fornecedor.id_cotacao='$i_id_cotacaogaficos'
                        ORDER BY cotacao_fornecedor.valor_total";
                $result3 = $conection->query($c_sql3);
                // percorre resultado da query para para montar gráfico
                while ($registro3 = $result3->fetch_assoc()) {
                    $c_local = $registro3['fornecedor'];
                    $c_qtd =  $registro3['valor_total'];

                ?>['<?php echo $c_local ?>', <?php echo  $c_qtd ?>],
                <?php } ?>
            ]);


            var options = {
                legend: {
                    position: 'none'
                }

            };

            var chart = new google.visualization.LineChart(document.getElementById('linechart1'));

            chart.draw(data, options);
        }
    </script>

    <script type="text/javascript">
        // gráfico por Valor
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Fornecedores', 'Valor da Cotação'],

                <?php
                $formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
                $c_sql3 = "SELECT cotacao_fornecedor.id, fornecedores.descricao as fornecedor, valor_total, frete
                        FROM cotacao_fornecedor
                        JOIN fornecedores ON cotacao_fornecedor.id_fornecedor=fornecedores.id
                        WHERE cotacao_fornecedor.id_cotacao='$i_id_cotacaogaficos'
                        ORDER BY cotacao_fornecedor.valor_total+cotacao_fornecedor.frete";
                $result3 = $conection->query($c_sql3);
                // percorre resultado da query para para montar gráfico
                while ($registro3 = $result3->fetch_assoc()) {
                    $c_local = $registro3['fornecedor'];
                    $c_qtd =  $registro3['valor_total'] + $registro3['frete'];

                ?>['<?php echo $c_local ?>', <?php echo  $c_qtd ?>],
                <?php } ?>
            ]);


            var options = {
                legend: {
                    position: 'none'
                }

            };

            var chart = new google.visualization.LineChart(document.getElementById('linechart2'));

            chart.draw(data, options);
        }
    </script>

    <script type="text/javascript">
        // gráfico por Valor
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Fornecedores', 'Valor da Cotação'],

                <?php
                $formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
                $c_sql3 = "SELECT cotacao_fornecedor.id, fornecedores.descricao as fornecedor, valor_total, frete
                        FROM cotacao_fornecedor
                        JOIN fornecedores ON cotacao_fornecedor.id_fornecedor=fornecedores.id
                        WHERE cotacao_fornecedor.id_cotacao='$i_id_cotacaogaficos'
                        ORDER BY cotacao_fornecedor.frete";
                $result3 = $conection->query($c_sql3);
                // percorre resultado da query para para montar gráfico
                while ($registro3 = $result3->fetch_assoc()) {
                    $c_local = $registro3['fornecedor'];
                    $c_qtd =  $registro3['frete'];

                ?>['<?php echo $c_local ?>', <?php echo  $c_qtd ?>],
                <?php } ?>
            ]);


            var options = {
                legend: {
                    position: 'none'
                }
            };

            var chart = new google.visualization.LineChart(document.getElementById('linechart3'));

            chart.draw(data, options);
        }
    </script>

    <script type="text/javascript">
        // gráfico por Valor
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Fornecedores', 'Prazo de Entrega em dias'],

                <?php
                $formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
                $c_sql3 = "SELECT cotacao_fornecedor.id, fornecedores.descricao as fornecedor, valor_total, frete,
                        prazo
                        FROM cotacao_fornecedor
                        JOIN fornecedores ON cotacao_fornecedor.id_fornecedor=fornecedores.id
                        WHERE cotacao_fornecedor.id_cotacao='$i_id_cotacaogaficos'
                        ORDER BY cotacao_fornecedor.prazo";
                $result3 = $conection->query($c_sql3);
                // percorre resultado da query para para montar gráfico
                while ($registro3 = $result3->fetch_assoc()) {
                    $c_local = $registro3['fornecedor'];
                    $c_qtd =  $registro3['prazo'];

                ?>['<?php echo $c_local ?>', <?php echo  $c_qtd ?>],
                <?php } ?>
            ]);


            var options = {
                legend: {
                    position: 'none'
                }

            };

            var chart = new google.visualization.LineChart(document.getElementById('linechart4'));


            chart.draw(data, options);
        }
    </script>

    <div>
        <h3 class="text-center">Gráfico de Valores da Cotação por Fornecedor</h3>
        <div id="linechart1" style="width: 900px; height: 500px;"></div>
    </div>

    <div>
        <h3 class="text-center">Cotação de Preços Total por Fornecedor (Valores Cotados + Frete)</h3>
        <div id="linechart2" style="width: 900px; height: 500px;"></div>
    </div>

    <div>
        <h3 class="text-center">Cotação de Preços por Fornecedor - Frete </h3>
        <div id="linechart3" style="width: 900px; height: 500px;"></div>
    </div>

    <div>
        <h3 class="text-center">Prazos de entrega por Fornecedor</h3>
        <div id="linechart4" style="width: 900px; height: 500px;"></div>
    </div>


</body>

</html>