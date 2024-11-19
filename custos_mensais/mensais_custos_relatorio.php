<?php
// emissão de mapa de cotação
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
include("../lib_gop.php");
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
$c_sql = $_SESSION['sql'];
//echo $c_sql;
$result = $conection->query($c_sql);
$result_grafico = $result;
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
        <h3 class="text-center"><?php echo $_SESSION['titulo_rel'] ?></h3><br>
        <h4 class="text-left">Filtros :</h4><br>
        <h4 class="text-left"><?php echo $c_query; ?></h4><br>
        <div class="panel panel-default">
            <div class="panel-heading text-center"><strong>Período :<?php echo $c_periodo ?> </strong></div>
            <hr>
            <table class="table table display table-bordered table-striped table-active tabocorrencias">
                <thead class="thead">
                    <tr>
                        <th scope="col">Mês</th>
                        <th scope="col">Custo Material</th>
                        <th scope="col">Custo Serviços</th>
                        <th scope="col">Custo Total</th>
                    </tr>
                </thead>
                <tbody>
                    <?php

                    while ($c_linha = $result->fetch_assoc()) {
                        if (is_numeric($c_linha['total_material']))
                            $c_material = $formatter->formatCurrency($c_linha['total_material'], 'BRL');
                        else
                            $c_material = 'R$ 0,00';
                        if (is_numeric($c_linha['total_servico']))
                            $c_servico = $formatter->formatCurrency($c_linha['total_servico'], 'BRL');
                        else
                            $c_servico = 'R$ 0,00';
                        if (is_numeric($c_linha['total']))
                            $c_total = $formatter->formatCurrency($c_linha['total'], 'BRL');
                        else
                            $c_total = 'R$ 0,00';

                        $c_mes = mes_extenso($c_linha['mes']);
                        echo "
                            <tr class='info'>
                            <td>$c_mes</td>
                            <td>$c_material</td>
                            <td>$c_servico</td>
                            <td>$c_total</td>
                          
                            </tr>
                            ";
                    }
                    ?>
                </tbody>
            </table>

        </div>
    </div>
    <hr>
    <!-- gráficos das ocorrencias -->

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <!-- Gráfico de custos de materiais -->
    <script type="text/javascript">
        // gráfico por mes
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Mês', 'Custo'],

                <?php
                $result_grafico = $conection->query($c_sql);
                // percorre resultado da query para para montar gráfico
                while ($registro = $result_grafico->fetch_assoc()) {
                    $c_ocorrencia = mes_extenso($registro['mes']);
                    $c_qtd =  $registro['total_material'];
                ?>['<?php echo $c_ocorrencia ?>', <?php echo $c_qtd ?>],
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


    <!-- Gráfico de custos de servicos -->

    <script type="text/javascript">
        // gráfico por mes
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Mês', 'Custo'],

                <?php
                $result_grafico = $conection->query($c_sql);
                // percorre resultado da query para para montar gráfico
                while ($registro = $result_grafico->fetch_assoc()) {
                    $c_ocorrencia = mes_extenso($registro['mes']);
                    $c_qtd =  $registro['total_servico'];
                ?>['<?php echo $c_ocorrencia ?>', <?php echo $c_qtd ?>],
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

    <!-- Gráfico de custos Totais  -->

    <script type="text/javascript">
        // gráfico por mes
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Mês', 'Custo'],

                <?php
                $result_grafico = $conection->query($c_sql);
                // percorre resultado da query para para montar gráfico
                while ($registro = $result_grafico->fetch_assoc()) {
                    $c_ocorrencia = mes_extenso($registro['mes']);
                    $c_qtd =  $registro['total'];
                ?>['<?php echo $c_ocorrencia ?>', <?php echo $c_qtd ?>],
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

    <div style="padding-left:100px;">
        <h4 class="text-center"><?php echo $_SESSION['titulo_graf'] ?></h4>
        <h5 class="text-center">Custos de Materiais</h5>
        <div id="chart1" style="width: 900px; height: 500px;"></div>
    </div>

    <br>

    <div style="padding-left:100px;">
        <h4 class="text-center"><?php echo $_SESSION['titulo_graf'] ?></h4>
        <h5 class="text-center">Custos de Serviços</h5>
        <div id="chart2" style="width: 900px; height: 500px;"></div>
    </div>

    <br>

    <div style="padding-left:100px;">
        <h4 class="text-center"><?php echo $_SESSION['titulo_graf'] ?></h4>
        <h5 class="text-center">Custo Total</h5>
        <div id="chart3" style="width: 900px; height: 500px;"></div>
    </div>


</body>

</html>