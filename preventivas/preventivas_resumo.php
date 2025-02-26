<?php // controle de acesso ao formulário
////////////////////////////////////////////////////////////////////////
// pagina informativa com as Ordens de serviços geradas pelas preventivas
/////////////////////////////////////////////////////////////////////////

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
date_default_timezone_set('America/Sao_Paulo');
// pegar ordens geradas
$c_data = date('Y/m/d');

$c_sql =  "SELECT ordens.id, ordens.id_oficina, ordens.descritivo, oficinas.descricao as oficina FROM ordens
JOIN oficinas ON ordens.id_oficina=oficinas.id
WHERE ordens.data_geracao='$c_data' and tipo_ordem='P'  ORDER BY ordens.id desc";
//echo $c_sql;
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();

// verifico se a query foi correto
if (!$result) {
    die("Erro ao Executar Sql!!" . $conection->connect_error);
}

// rotina para envio de e-mail para oficinas com as preventivas geradas
if (isset($post['btn_email'])) {
    // leio todas as oficinas com sql
    $c_sql_oficinas = "SELECT oficinas.id, oficinas.descricao FROM oficinas ORDER BY oficinas.descricao";
    $result_oficina = $conection->query($c_sql_oficinas);
    while ($c_linha_oficina = $result_oficina->fetch_assoc()){
       // Faço sql com as preventivas com a oficina do loop
       $i_id_oficina = $c_linha_oficina['id'];  // pego a id da oficina no loop da tabela de oficinas
       $c_sql_geradas = "SELECT ordens.id, ordens.id_oficina, ordens.descritivo, oficinas.descricao as oficina FROM ordens
                        JOIN oficinas ON ordens.id_oficina=oficinas.id
                        WHERE ordens.data_geracao='$c_data' and ordens.id_oficina='$i_id_oficina' ORDER BY ordens.id desc";
       $result_registro = $conection->query($c_sql_geradas);
        // segundo loop com os registro por oficina a serem enviados po e-mail
       while ($c_linha_registro = $result_registro->fetch_assoc()){
          // pego parametros para enviar o e-mail
          
          // chamo rotina para enviar o e-mail com as preventivas

        }                ;
                        
    }
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
            <h4>Lista de Ordens de Serviço Geradas pelas preventivas do dia <?php echo date('d/m/y'); ?> </h4>
        </div>

        <table class="table table display table-bordered tabordens">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Descritivo</th>
                    <th scope="col">Oficina</th>
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
                                    <td>$c_linha[oficina]</td>

                                </tr>
                                ";
                }
                ?>

            </tbody>
        </table>
        <ul class="nav nav-tabs" role="tablist">
<<<<<<< HEAD
            <button type="submit" class="btn btn-info"><span class='glyphicon glyphicon-envelope'></span> enviar e-mail</button>&nbsp;
            <?php
            if ($_SESSION['consulta_resumo'] == 'N')
                echo '<a class="btn btn btn-primary" href="/gop/preventivas/preventivas.php"><span class="glyphicon glyphicon-off"></span> Finalizar</a>';
            else
            echo '<a class="btn btn btn-primary" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Finalizar</a>';
            ?>
=======
            <button type="submit" name="btn_email" class="btn btn-info"><span class='glyphicon glyphicon-envelope'></span> enviar e-mail</button>&nbsp;
            <a class="btn btn btn-primary" href="/gop/preventivas/preventivas.php"><span class="glyphicon glyphicon-off"></span> Finalizar</a>
>>>>>>> 72a00c22a8c06fca21b7f2afacd7bc1b8b541258
        </ul>
        <br>
    </div>

</body>

</html>