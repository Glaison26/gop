<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
$c_sql_recurso = $_SESSION['sqlrecurso'];
$c_sql_espaco = $_SESSION['sqlespaco'];

//echo $c_sql_recurso;
include('../links.php');
include('../conexao.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/preventivas/preventivas_excluir.php?id=" + id;
            }
        }
    </script>
</head>
<!-- script da tabela de recursos -->
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
                "visible": true
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
                'aTargets': [6]
            }, {
                'aTargets': [0],
                "visible": true
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
    <div class="container-fluid">
        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Lista de Preventivas<h5>
            </div>
        </div>


        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Resultado das Preventivas Selecionadas</h5>
        </div>
        <?php
        if ($_SESSION['pesquisamenu'] == false) {
            echo "<a class='btn btn btn-sm' href='\gop\preventivas\preventivas.php'><img src='\gop\images\saida.png' alt='' width='25' height='25'> Voltar</a>";
        } else {
            echo "<a class='btn btn btn-sm' href='\gop\menu.php'><img src='\gop\images\back.png' alt='' width='25' height='25'> Voltar</a>";
        }

        ?>
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
                    <table class="table table-bordered table-striped tabpreventivas_recursos">
                        <thead class="thead">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Recurso</th>
                                <th scope="col">Patrimônio</th>

                                <th scope="col">Tipo</th>
                                <th scope="col">Calibração</th>
                                <th scope="col">Periodicidade</th>
                                <th scope="col">Ultima Realização</th>
                                <th scope="col">Próxima Realização</th>
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
                                    <td>$c_linha[patrimonio]
                                    
                                    <td>$c_linha[preventiva_tipo_completo]</td>
                                    <td>$c_linha[preventiva_calibracao]</td>
                                    <td>$c_linha[periodicidade_geracao] dias</td>
                                    <td>$c_data_realizacao</td>
                                    <td>$c_data_proxima</td>
                                                                    
                                    <td>
                                        <a class='btn btn-secondary btn-sm' href='/gop/preventivas/preventivas_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                                      <a class='btn btn-success btn-sm' href='/gop/preventivas/preventivas_anexos.php?id=$c_linha[id]'>
                                        <img src='\gop\images\anexo.png' alt='' width='23' height='18'> Anexos</a> 
                                        <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>

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
                    <table class="table table-bordered table-striped tabpreventivas_espacos">
                        <thead class="thead">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Espaço Físico</th>

                                <th scope="col">Tipo</th>
                                <th scope="col">Periodicidade</th>
                                <th scope="col">Ultima Realização</th>
                                <th scope="col">Próxima Realização</th>
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
                                    
                                    <td>$c_linha[preventiva_tipo_completo]</td>
                                    <td>$c_linha[periodicidade_geracao] dias</td>
                                    <td>$c_data_realizacao</td>
                                    <td>$c_data_proxima</td>
                                    
                                    <td>
                                        <a class='btn btn-secondary btn-sm' href='/gop//preventivas/preventivas_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                                        <a class='btn btn-success btn-sm' href='/gop/preventivas/preventivas_anexos.php?id=$c_linha[id]'>
                                        <img src='\gop\images\anexo.png' alt='' width='23' height='18'> Anexos</a>  
                                    </td>

                                </tr>
                                ";
                            }
                            ?>
                        </tbody>
                    </table>

                </div>
            </div>
            <!-- aba das avulsas-->
            <div role="tabpanel" class="tab-pane" id="avulsas">
                <div style="padding-top:15px;padding-left:20px;">
                    <table class="table table display table-bordered tabsolicitacao_avulsas">
                        <thead class="thead">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Status</th>
                                <th scope="col">Abertura</th>
                                <th scope="col">Hora</th>
                                <th scope="col">Solicitante</th>
                                <th scope="col">Tipo</th>
                                <th scope="col">Opções</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php

                            // faço a Leitura da tabela com sql

                            $result = $conection->query($c_sql_avulso);
                            // verifico se a query foi correto
                            if (!$result) {
                                die("Erro ao Executar Sql!!" . $conection->connect_error);
                            }

                            // insiro os registro do banco de dados na tabela 
                            while ($c_linha = $result->fetch_assoc()) {
                                $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_abertura'])));
                                echo "
                                <tr class='info'>
                                    <td>$c_linha[id]</td>
                                    <td>$c_linha[solicitacao_status]</td>
                                    <td>$c_data</td>
                                    <td>$c_linha[hora_abertura]</td>
                                    <td>$c_linha[solicitante]</td>
                                    <td>$c_linha[solicitacao_tipo]</td>
                                    
                                    <td>
                                        <a class='btn btn-secondary btn-sm' href='/gop/solicitacao_detalhe.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Detalhe</a>
                                        
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