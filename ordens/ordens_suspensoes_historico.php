<?php
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('../links2.php');
include('../conexao.php');
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <br>
    <div class="container-fluid">
        <hr>
        <table class="table display table-bordered tabsuspensaolist">
            <thead class="thead">
                <tr>

                    <th scope="col">Data Suspensão</th>
                    <th scope="col">Hora Suspensão</th>
                    <th scope="col">Data retirada</th>
                    <th scope="col">Hora retirada</th>
                    <th scope="col">Motivo</th>

                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT ordens_suspensao.data_suspensao, ordens_suspensao.hora_suspensao, ordens_suspensao.data_retirada, 
                ordens_suspensao.hora_retirada, ordens_suspensao.motivo
                FROM ordens_suspensao WHERE ordens_suspensao.id_ordem='$i_id' ORDER BY ordens_suspensao.data_suspensao desc";
                //echo $c_sql;
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }
                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    $c_data_retirada = "";
                    $c_data_suspensao = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_suspensao'])));
                    if (!empty($c_linha['data_retirada']))
                        $c_data_retirada = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_retirada'])));
                    echo "
                    <tr class='info'>
                    <td>$c_data_suspensao</td>
                    <td>$c_linha[hora_suspensao]</td>
                    <td>$c_data_retirada</td>
                    <td>$c_linha[hora_retirada]</td>
                    <td>$c_linha[motivo]</td>
                    </tr>";
                }
                ?>
            </tbody>
        </table>
    </div>
</body>

</html>