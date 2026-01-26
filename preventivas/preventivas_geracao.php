<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
// pego data do dia
date_default_timezone_set('America/Sao_Paulo');
$agora = date('Y-m-d');
// sql com as preventiva com data da próxima realização igual ou inferior a data do dia em recurso fisico
$c_sql_recurso = "SELECT preventivas.id, preventivas.periodicidade_geracao, preventivas.calibracao, preventivas.id_recurso, recursos.descricao as recurso,
preventivas.data_ult_realizacao, preventivas.data_prox_realizacao, preventivas.gerar,
case
when preventivas.calibracao ='S' then 'Sim'
when preventivas.calibracao ='N' then 'Não'
END AS preventiva_calibracao
FROM preventivas 
JOIN recursos ON preventivas.id_recurso=recursos.id
where data_prox_realizacao<='$agora'
ORDER BY preventivas.data_prox_realizacao desc";
// sql com as preventiva com data da próxima realização igual ou inferior a data do dia em espaço fisico
$c_sql_espaco = "SELECT preventivas.id, preventivas.periodicidade_geracao, preventivas.calibracao, preventivas.id_espaco, espacos.descricao as espaco,
preventivas.data_ult_realizacao, preventivas.data_prox_realizacao, preventivas.gerar,
case
when preventivas.calibracao ='S' then 'Sim'
when preventivas.calibracao ='N' then 'Não'
END AS preventiva_calibracao
FROM preventivas 
JOIN espacos ON preventivas.id_espaco=espacos.id
where data_prox_realizacao<='$agora'
ORDER BY preventivas.data_prox_realizacao desc";



//echo $c_sql_recurso;
include('../links.php');
include('../conexao.php');
?>

<!--
///////////////////////////////////////////////////
frontend com tabela das preventivas a serem geradas
///////////////////////////////////////////////////
-->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<script language="Javascript">
    function confirma_geracao(id) {
        var resposta = confirm("Confirma a geração das preventivas?");
        if (resposta == true) {
            window.location.href = "/gop/preventivas/preventivas_gerar.php";
        }
    }
</script>
<!-- script para tabela de preventivas em recursos fisicos a serem geradas -->
<script>
    $(document).ready(function() {
        $('.tabpreventivas_recursos').DataTable({
            // 
            "iDisplayLength": -1,
            "order": [1, 'asc'],
            "aoColumnDefs": [{
                'bSortable': false,
                'aTargets': [6]
            }, {
                'aTargets': [0],
                "visible": false
            }],
            "oLanguage": {
                "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                "sLengthMenu": "_MENU_ resultados por página",
                "sInfoFiltered": " - filtrado de _MAX_ registros",
                "oPaginate": {
                    "spagingType": "full_number",
                    "sNext": "Próximo",
                    "sPrevious": "Anterior",
                    "sFirst": "Primeiro",
                    "sLoadingRecords": "Carregando...",
                    "sProcessing": "Processando...",
                    "sZeroRecords": "Nenhum registro encontrado",

                    "sLast": "Último"
                },
                "sSearch": "Pesquisar",
                "sLengthMenu": 'Mostrar <select>' +
                    '<option value="5">5</option>' +
                    '<option value="10">10</option>' +
                    '<option value="20">20</option>' +
                    '<option value="30">30</option>' +
                    '<option value="40">40</option>' +
                    '<option value="50">50</option>' +
                    '<option value="-1">Todos</option>' +
                    '</select> Registros'

            }

        });

    });
</script>
<!-- script da tabela de espaços fisicos -->
<script>
    $(document).ready(function() {
        $('.tabpreventivas_espacos').DataTable({
            // 
            "iDisplayLength": -1,
            "order": [1, 'asc'],
            "aoColumnDefs": [{
                'bSortable': false,
                'aTargets': [7]
            }, {
                'aTargets': [0],
                "visible": false
            }],
            "oLanguage": {
                "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                "sLengthMenu": "_MENU_ resultados por página",
                "sInfoFiltered": " - filtrado de _MAX_ registros",
                "oPaginate": {
                    "spagingType": "full_number",
                    "sNext": "Próximo",
                    "sPrevious": "Anterior",
                    "sFirst": "Primeiro",
                    "sLoadingRecords": "Carregando...",
                    "sProcessing": "Processando...",
                    "sZeroRecords": "Nenhum registro encontrado",

                    "sLast": "Último"
                },
                "sSearch": "Pesquisar",
                "sLengthMenu": 'Mostrar <select>' +
                    '<option value="5">5</option>' +
                    '<option value="10">10</option>' +
                    '<option value="20">20</option>' +
                    '<option value="30">30</option>' +
                    '<option value="40">40</option>' +
                    '<option value="50">50</option>' +
                    '<option value="-1">Todos</option>' +
                    '</select> Registros'

            }

        });

    });
</script>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Lista de Preventivas aptas para geração de Ordens de Serviço<h5>
        </div>
    </div>
    <div class="container-fluid">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>

            <h5>Resultado das Preventivas Selecionadas para geração de ordens de serviço. Selecione as preventiava a serem geradas e clique em gerar ordens de serviço </h5>
        </div>
        <a class='btn btn btn-sm' href='javascript:func()' onclick='confirma_geracao()'><img src='\gop\images\gerar.png' alt='' width='25' height='25'> Gerar Preventivas</a>
        <a class='btn btn btn-sm' href='\gop\preventivas\preventivas.php'><img src='\gop\images\saida.png' alt='' width='25' height='25'> Voltar</a>

        <hr>
        <!-- abas de preventivas por recursos físicos, Espaços físicos e avulsos -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#recurso" aria-controls="recurso" role="tab" data-toggle="tab">Preventivas em Recurso Físico</a></li>
            <li role="presentation"><a href="#espaco" aria-controls="espaco" role="tab" data-toggle="tab">Preventivas em Espaços Físicos</a></li>
        </ul>
        <div class="tab-content">
            <!-- aba da recurso fisico-->
            <div role="tabpanel" class="tab-pane active" id="recurso">
                <div style="padding-top:15px;padding-left:20px;">
                    <table class="table table display table-bordered table-sm tabpreventivas_recursos">
                        <thead class="thead">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Recurso</th>
                                <th scope="col">Calibração</th>
                                <th scope="col">Periodicidade</th>
                                <th scope="col">Ultima Realização</th>
                                <th scope="col">Próxima Realização</th>
                                <th scope="col">Gerar</th>
                                <th scope="col">Opções</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            // faço a Leitura da tabela com sql
                            $result = $conection->query($c_sql_recurso);
                            // verifico se a query foi correto
                            if (!$result) {
                                die("Erro ao Executar Sql!!" . $conection->connect_error);
                            }

                            // insiro os registro do banco de dados na tabela 
                            while ($c_linha = $result->fetch_assoc()) {
                                $c_data_realizacao = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_ult_realizacao'])));
                                $c_data_proxima = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_prox_realizacao'])));

                                echo "
                                <tr>
                                    <td>$c_linha[id]</td>
                                    <td>$c_linha[recurso]</td>
                                   
                                    <td>$c_linha[preventiva_calibracao]</td>
                                    <td>$c_linha[periodicidade_geracao] dias</td>
                                    <td>$c_data_realizacao</td>
                                    <td>$c_data_proxima</td>
                                    <td>$c_linha[gerar]</td>
                                                                    
                                    <td>
                                        <a class='btn btn-success btn-sm' href='/gop/preventivas/preventivas_selecionar.php?id=$c_linha[id]'><img src='\gop\images\selecionar.png' alt='' width='25' height='25'> Marcar/Desmarcar</a>
                                       
                                    </td>

                                </tr>
                                ";
                            }
                            ?>

                        </tbody>
                    </table>
                </div>
            </div>
            <!-- aba da espaco fisico-->
            <div role="tabpanel" class="tab-pane" id="espaco">
                <div style="padding-top:15px;padding-left:20px;">
                    <table class="table table display table-bordered tabpreventivas_espacos">
                        <thead class="thead">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Espaço Fisico</th>
                                <th scope="col">Calibração</th>
                                <th scope="col">Periodicidade</th>
                                <th scope="col">Ultima Realização</th>
                                <th scope="col">Próxima Realização</th>
                                <th scope="col">Gerar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            // faço a Leitura da tabela com sql
                            $result = $conection->query($c_sql_espaco);
                            // verifico se a query foi correto
                            if (!$result) {
                                die("Erro ao Executar Sql!!" . $conection->connect_error);
                            }

                            // insiro os registro do banco de dados na tabela 
                            while ($c_linha = $result->fetch_assoc()) {
                                $c_data_realizacao = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_ult_realizacao'])));
                                $c_data_proxima = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_prox_realizacao'])));

                                echo "
                                <tr>
                                    <td>$c_linha[id]</td>
                                    <td>$c_linha[espaco]</td>
                                   
                                    <td>$c_linha[preventiva_calibracao]</td>
                                    <td>$c_linha[periodicidade_geracao] dias</td>
                                    <td>$c_data_realizacao</td>
                                    <td>$c_data_proxima</td>
                                    <td>$c_linha[gerar]</td>
                                                                    
                                    <td>
                                        <a class='btn btn-success btn-sm' href='/gop/preventivas/preventivas_selecionar.php?id=$c_linha[id]'><img src='\gop\images\selecionar.png' alt='' width='25' height='25'> Marcar/Desmarcar</a>
                                       
                                    </td>

                                </tr>
                                ";
                            }
                            ?>
                        </tbody>
                    </table>

                </div>
            </div>

        </div>

    </div>




</body>

</html>