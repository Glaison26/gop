<?php
// emissão de mapa de cotação
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
$c_sql = $_SESSION['sql'];
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
        <h2 class="text-center">Relatório de Manutenções por Solicitante no Período</h2><br>
        <h5 class="text-left">Filtros :<?php echo $c_query;?></h5><br>
        <div class="panel panel-default">
            <div class="panel-heading text-center"><strong>Período :<?php echo $c_periodo?> </strong></div>
            <hr>
            <table class="table table display table-bordered table-striped table-active tabocorrencias">
                <thead class="thead">
                    <tr>
                        <th scope="col">Solicitantes</th>
                        <th scope="col">No de Chamados</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $i_chamados = 0;
                    while ($c_linha = $result->fetch_assoc()) {
                        $i_chamados += $c_linha['total'];
                        echo "
                            <tr class='info'>
                            <td>$c_linha[nome]</td>
                            <td>$c_linha[total]</td>
                          
                            </tr>
                            ";
                    }
                    ?>
                </tbody>
            </table>
            <div><?php echo "Total de Chamados : ". $i_chamados?></div>
        </div>
    </div>
    <hr>
    <!-- gráficos das ocorrencias -->

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


    <script type="text/javascript">
        // gráfico por Valor
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Solicitantes', 'chamados'],

                <?php
                $result_grafico = $conection->query($c_sql);
                // percorre resultado da query para para montar gráfico
                while ($registro = $result_grafico->fetch_assoc()) {
                    $c_solicitante = $registro['nome'];
                    $c_qtd =  $registro['total'];
                ?>['<?php echo $c_solicitante ?>', <?php echo $c_qtd ?>],
                <?php } ?>
            ]);

            var options = {
                
            };

            var chart = new google.visualization.PieChart(document.getElementById('chart1'));

            chart.draw(data, options);
        }
    </script>

    <div style="padding-left:400px;">
        <h3 class="text-center">Relatório de Manutenções por Solicitante no Período</h3>
        <div id="chart1" style="width: 900px; height: 500px;"></div>
    </div>

</body>

</html>