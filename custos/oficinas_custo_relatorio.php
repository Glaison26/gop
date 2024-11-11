<?php
// emissão de mapa de cotação
session_start();
//if (!isset($_SESSION['newsession'])) {
//    die('Acesso não autorizado!!!');
//}
include("../conexao.php");
include("../links2.php");
//$c_sql = $_SESSION['sql'];
//$result = $conection->query($c_sql);
//$result_grafico = $result;
$c_periodo = $_SESSION['periodo'];
$c_query = $_SESSION['query'];

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="container">
        <h2 class="text-center">Relatório de Custos por Oficinas</h2><br>
        <h5 class="text-left">Filtros :<?php echo $c_query; ?></h5><br>
        <div class="panel panel-default">
            <div class="panel-heading text-center"><strong>Período :<?php echo $c_periodo ?> </strong></div>
            <hr>
            <table class="table table display table-bordered table-striped table-active tabocorrencias">
                <thead class="thead">
                    <tr>
                        <th scope="col">Oficina</th>
                        <th scope="col">Valor Material</th>
                        <th scope="col">Valor Serviços</th>
                        <th scope="col">Valor Total</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $c_sql = "select * from temp_custos";
                    $result = $conection->query($c_sql);
                    $formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
                    $n_custo_material = 0;
                    $n_custo_servico = 0;
                    $n_custo = 0;
                    while ($c_linha = $result->fetch_assoc()) {
                        if ($c_linha['valor_material'] > 0)
                            $c_valor_material = $formatter->formatCurrency($c_linha['valor_material'], 'BRL');
                        else
                            $c_valor_material = 'R$ 0,00';
                        if ($c_linha['valor_servico'] > 0)
                            $c_valor_servico = $formatter->formatCurrency($c_linha['valor_servico'], 'BRL');
                        else
                            $c_valor_servico = 'R$ 0,00';
                        if ($c_linha['valor_total'] > 0)
                            $c_valor_total = $formatter->formatCurrency($c_linha['valor_total'], 'BRL');
                        else
                            $c_valor_total = 'R$ 0,00';
                        $n_custo_material += $c_linha['valor_material'];
                        $n_custo_servico += $c_linha['valor_servico'];
                        $n_custo = $n_custo + ($n_custo_material + $n_custo_servico);

                        echo "
                            <tr class='info'>
                            <td>$c_linha[descricao]</td>
                            <td>$c_valor_material</td>
                            
                            <td>$c_valor_servico</td>
                            <td>$c_valor_total</td>
                          
                            </tr>
                            ";
                    }
                    ?>
                </tbody>
            </table>
            <?php
            $n_custo_total = $n_custo_material+$n_custo_servico;
            $c_custo = "";
            $c_custo_material = "";
            $c_custo_servico = "";
            if ($n_custo > 0)
                $c_custo = $formatter->formatCurrency($n_custo_total, 'BRL');
            if ($n_custo_material > 0)
                $c_custo_material = $formatter->formatCurrency($n_custo_material, 'BRL');
            if ($n_custo > 0)
                $c_custo_servico = $formatter->formatCurrency($n_custo_servico, 'BRL');
            ?>
            <div><?php echo "<b>" . "Total Material :   " . $c_custo_material . " Total Serviço :    " .
             $c_custo_servico . " Custo Total :   " . $c_custo . "</b>" ?></div>

        </div>
    </div>
    <hr>


    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <!--   Valor Total -->
    <script type="text/javascript">
        // gráfico por Valor
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Oficinas', 'Valor'],

                <?php
                $result_grafico = $conection->query($c_sql);
                // percorre resultado da query para para montar gráfico
                while ($registro = $result_grafico->fetch_assoc()) {
                    $c_oficina = $registro['descricao'];
                    $c_valor_total =  $registro['valor_total'];
                ?>['<?php echo $c_oficina ?>', <?php echo $c_valor_total ?>],
                <?php } ?>
            ]);

            var options = {
                legend: {
                    position: 'none'
                }

            };

            var chart = new google.visualization.ColumnChart(document.getElementById('chart1'));

            chart.draw(data, options);
        }
    </script>

    <!--   Valor Material -->
    <script type="text/javascript">
        // gráfico por Valor
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Ocorrencia', 'Valor'],

                <?php
                $result_grafico = $conection->query($c_sql);
                // percorre resultado da query para para montar gráfico
                while ($registro = $result_grafico->fetch_assoc()) {
                    $c_ocorrencia = $registro['descricao'];
                    $c_valor_material =  $registro['valor_material'];
                ?>['<?php echo $c_ocorrencia ?>', <?php echo $c_valor_material ?>],
                <?php } ?>
            ]);

            var options = {
                legend: {
                    position: 'none'
                }

            };

            var chart = new google.visualization.ColumnChart(document.getElementById('chart2'));

            chart.draw(data, options);
        }
    </script>
    <!--   Valor Serviço -->
    <script type="text/javascript">
        // gráfico por Valor
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Ocorrencia', 'Valor'],

                <?php
                $result_grafico = $conection->query($c_sql);
                // percorre resultado da query para para montar gráfico
                while ($registro = $result_grafico->fetch_assoc()) {
                    $c_ocorrencia = $registro['descricao'];
                    $c_valor_servico =  $registro['valor_servico'];
                ?>['<?php echo $c_ocorrencia ?>', <?php echo $c_valor_servico ?>],
                <?php } ?>
            ]);

            var options = {
                legend: {
                    position: 'none'
                }

            };

            var chart = new google.visualization.ColumnChart(document.getElementById('chart3'));

            chart.draw(data, options);
        }
    </script>



    <!--   grafico pizza com custo total -->
    <script type="text/javascript">
        // gráfico por Valor
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Descricao', 'Valor'],

                <?php

                // percorre resultado da query para para montar gráfico
                $c_descricao = 'Material';
                $c_valor_material = $n_custo_material;
                ?>['<?php echo $c_descricao ?>', <?php echo $c_valor_material ?>],
                <?php

                // percorre resultado da query para para montar gráfico
                $c_descricao = 'Servico';
                $c_valor_servico = $n_custo_servico;
                ?>['<?php echo $c_descricao ?>', <?php echo $c_valor_servico ?>],
            ]);

            var options = {


            };

            var chart = new google.visualization.PieChart(document.getElementById('chart4'));

            chart.draw(data, options);
        }
    </script>

    <div style="padding-left:300px;">
        <h5 class="text-left">Gráfico Custos por Oficinas no Período - Valor Total</h5>
        <div id="chart1" style="width: 400px; height: 400px;"></div>
    </div>

    <div style="padding-left:300px;">
        <h5 class="text-left">Gráfico Custos por Oficinas no Período - Valor Material</h5>
        <div id="chart2" style="width: 400px; height: 400px;"></div>
    </div>

    <div style="padding-left:300px;">
        <h5 class="text-left">Gráfico Custos por Oficinas no Período - Valor Serviço</h5>
        <div id="chart3" style="width: 400px; height: 400px;"></div>
    </div>
    <br>
    <div style="padding-left:300px;">
        <h5 class="text-left">Gráfico Custos no Período - Valor Serviço e Material</h5>
        <div id="chart4" style="width: 400px; height: 300px;"></div>
    </div>


</body>

</html>