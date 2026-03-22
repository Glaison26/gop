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
$c_sql_qtd = $_SESSION['sql_qtd'];
$result_qtd = $conection->query($c_sql_qtd);

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="container">
        <h2 class="text-center">Relatório de Horas trabalhadas por Executor no Período</h2><br>
        <h5 class="text-left">Filtros :<?php echo $c_query; ?></h5><br>
        <div class="panel panel-default">
            <div class="panel-heading text-center"><strong>Período :<?php echo $c_periodo ?> </strong></div>
            <hr>
            <table class="table table display table-bordered table-striped table-active tabocorrencias">
                <thead class="thead">
                    <tr>
                        <th scope="col">Executor</th>
                        <th scope="col">No de Horas</th>
                        <th scope="col">No de Minutos</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $c_sql = "select * from temp_horas";
                    $result = $conection->query($c_sql);
                    while ($c_linha = $result->fetch_assoc()) {

                        echo "
                            <tr class='info'>
                            <td>$c_linha[executor]</td>
                            <td>$c_linha[horas]</td>
                            <td>$c_linha[minutos]</td>
                          
                            </tr>
                            ";
                    }
                    ?>
                </tbody>
            </table>

        </div>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

        <!-- grágico de horas de executores -->
        <script type="text/javascript">
            // gráfico por Valor
            google.charts.load('current', {
                'packages': ['corechart']
            });
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {

                var data = google.visualization.arrayToDataTable([
                    ['Executor', 'Tempo'],

                    <?php
                    $result_grafico = $conection->query($c_sql);
                    // percorre resultado da query para para montar gráfico
                    while ($registro = $result_grafico->fetch_assoc()) {
                        $c_executor = $registro['executor'];
                        $c_horas =  $registro['tempo_grafico'];
                    ?>['<?php echo $c_executor ?>', <?php echo $c_horas ?>],
                    <?php } ?>
                ]);

                var options = {
                    legend: {
                        position: 'none'
                    }

                };

                var chart = new google.visualization.BarChart(document.getElementById('chart1'));

                chart.draw(data, options);
            }
        </script>

        <div style="padding-left:300px;">
            <h3 class="text-center">Gráfico de Horas trabalhadas por Executores</h3>
            <div id="chart1" style="width: 900px; height: 500px;"></div>
        </div>
        
        <br>
        <h2 class="text-center">Relatório de número de atendimento realizados por Executor no Período</h2><br>
        <hr>
        <table class="table table display table-bordered table-striped table-active tabocorrencias">
            <thead class="thead">
                <tr>
                    <th scope="col">Executor</th>
                    <th scope="col">Ocorrências Atendidas</th>

                </tr>
            </thead>
            <tbody>
                <?php
                $result_grafico = $result_qtd;
                while ($c_linha_qtd = $result_qtd->fetch_assoc()) {

                    echo "
                            <tr class='info'>
                            <td>$c_linha_qtd[nome]</td>
                            <td>$c_linha_qtd[total]</td>
                           
                          
                            </tr>
                            ";
                }
                ?>
            </tbody>
        </table>

    </div>
    <hr>
    <!-- gráficos de horas por executor -->




    <!-- gráfico de numero de ocorrências por executor -->

    <script type="text/javascript">
        // gráfico por Valor
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Executor', 'Quantidade'],

                <?php
                $result_grafico2 = $conection->query($c_sql_qtd);
                // percorre resultado da query para para montar gráfico
                while ($registro2 = $result_grafico2->fetch_assoc()) {
                    $c_executor = $registro2['nome'];
                    $c_qtd =  $registro2['total'];
                ?>['<?php echo $c_executor ?>', <?php echo $c_qtd ?>],
                <?php } ?>
            ]);

            var options = {
                legend: {
                    position: 'none'
                }

            };

            var chart = new google.visualization.BarChart(document.getElementById('chart2'));

            chart.draw(data, options);
        }
    </script>



    <div style="padding-left:300px;">
        <h3 class="text-center">Gráfico com número de atendimentos por Executor</h3>
        <div id="chart2" style="width: 900px; height: 500px;"></div>
    </div>

</body>

</html>