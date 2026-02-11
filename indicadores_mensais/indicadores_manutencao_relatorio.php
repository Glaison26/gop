<?php
// emissão de mapa de cotação
session_start();
//if (!isset($_SESSION['newsession'])) {
//    die('Acesso não autorizado!!!');
//}

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
    <!-- monto Relatório com os valores de materias, serviços e total -->
    <div class="container">
        <h2 class="text-center">Relatório de Indicadores de Manutenção</h2><br>
        <div class="panel panel-default">

            <div class="panel panel-default">

                <!-- monto o relatório com os valores em $_SESSION['query'] -->
                <div class="panel-body">

                    <hr>
                    <p><strong>Detalhamento dos Indicadores: </strong></p>
                    <p><?php echo $_SESSION['query_indicadores']; ?></p>

                </div>
            </div>
        </div>
    </div>
</body>

</html>