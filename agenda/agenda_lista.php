<?php

session_start(); // controle de acesso ao formulário
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
// executo o sql que foi montado
$c_sql = $_SESSION['sql_agenda'];
//echo $_SESSION['sql_agenda'];

$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();

$c_data = date("d-m-Y", strtotime(str_replace('/', '-', $_SESSION['data1']))) . ' a ' . date("d-m-Y", strtotime(str_replace('/', '-', $_SESSION['data2'])));

?>

<!-- html com tabela da agenda dp executor de serviço selecionado no período -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agenda de Executor de Serviço</title>
</head>

<body>
    <div class="container-fluid">

        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Agenda de Executor<h5>
            </div>
        </div>

        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h4>Agenda do Executor : <?php echo $c_linha['nome'] ?> no perído de <?php echo $c_data; ?> </h4>
        </div>

        <table class="table  table-bordered table-striped >
            <thead class="thead">
                <tr>
                    <th scope="col">Numero da OS</th>
                    <th scope="col">Data Inicio</th>
                    <th scope="col">Hora Inicio</th>
                    <th scope="col">Status</th>

                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                //echo $c_sql_recurso;
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_inicio'])));
                    echo "
                      <tr>
                         <td>$c_linha[id]</td>
                         <td>$c_data</td>
                         <td>$c_linha[hora_inicio]</td>
                         <td>$c_linha[ordens_status]</td>
                                   
                     </tr>";
                }
                ?>

            </tbody>
        </table>
    </div>

</body>

</html>