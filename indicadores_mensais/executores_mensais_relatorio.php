<?php
// emissão de mapa de cotação
session_start();
//if (!isset($_SESSION['newsession'])) {
//    die('Acesso não autorizado!!!');
//}
include("../conexao.php");
include("../links2.php");
include("../lib_gop.php");
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
        <h2 class="text-center">Relatório de Comparativo de  Horas trabalhadas do Executor no Período</h2><br>
        <h4 class="text-left">Filtros :<?php echo $c_query; ?></h4><br>
        <div class="panel panel-default">
            <div class="panel-heading text-center"><strong>Período :<?php echo $c_periodo ?> </strong></div>
            <hr>
            <table class="table table display table-bordered table-striped table-active tabocorrencias">
                <thead class="thead">
                    <tr>
                        <th scope="col">Mês</th>
                        <th scope="col">No de Horas</th>
                        <th scope="col">No de Minutos</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $c_sql = "select * from tempo_horas_mes";
                    $result = $conection->query($c_sql);
                    while ($c_linha = $result->fetch_assoc()) {
                        $c_mes = mes_extenso($c_linha['mes']);
                        echo "
                            <tr class='info'>
                            <td>$c_mes</td>
                            <td>$c_linha[horas]</td>
                            <td>$c_linha[minutos]</td>
                          
                            </tr>
                            ";
                    }
                    ?>
                </tbody>
            </table>

        </div>
    </div>
    <hr>
    <!-- gráficos de horas por executor -->

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


    <script type="text/javascript">
        // gráfico por Valor
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Mês', 'Tempo'],

                <?php
                $result_grafico = $conection->query($c_sql);
                // percorre resultado da query para para montar gráfico
                while ($registro = $result_grafico->fetch_assoc()) {
                    $c_executor = mes_extenso($registro['mes']);
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

    <div style="padding-left:200px;">
        <h3 class="text-center">Gráfico comparativo de Horas trabalhadas por Executores</h3>
        <div id="chart1" style="width: 900px; height: 500px;"></div>
    </div>


</body>

</html>