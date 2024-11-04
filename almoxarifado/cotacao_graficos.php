<?php
include("../conexao.php");
include("../links2.php");
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
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
                        WHERE cotacao_fornecedor.id_cotacao='1'
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
                title: 'Cotação de Preços por Fornecedor (Valores Cotados)'
            };

            var chart = new google.visualization.LineChart(document.getElementById('piechart'));

            chart.draw(data, options);
        }
    </script>
    <div>
        <div id="piechart" style="width: 900px; height: 500px;"></div>
    </div>

</body>

</html>