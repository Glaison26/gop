<?php // controle de acesso ao formulário
////////////////////////////////////////////////////////////////////////
// pagina informativa com as Ordens de serviços geradas pelas preventivas
/////////////////////////////////////////////////////////////////////////

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("conexao.php");
include("links2.php");
// pegar ordens geradas
$c_data = date('Y/m/d');
$c_sql =  "SELECT ordens.id, ordens.descritivo FROM ordens
WHERE ordens.data_geracao='$c_data' ORDER BY ordens.id desc";
//echo $c_sql;
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();

// verifico se a query foi correto
if (!$result) {
    die("Erro ao Executar Sql!!" . $conection->connect_error);
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Resumo de Ordens de Serviços Geradas por preventivas<h5>
        </div>
    </div>

    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h4>Lista de Ordens de Serviço Geradas pelas preventivas do dia.</h4>
        </div>
        <div style="padding-bottom:15px;">
            <a class="btn btn btn-success" href="/gop/preventivas.php"><span class="glyphicon glyphicon-off"></span> Encerrar</a><br>
        </div>
        <table class="table table display table-bordered tabordens">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Descritivo</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql

                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {

                    echo "
                                <tr class='info'>
                                    <td>$c_linha[id]</td>
                                    <td>$c_linha[descritivo]</td>

                                </tr>
                                ";
                }
                ?>

            </tbody>
        </table>
    </div>

</body>

</html>