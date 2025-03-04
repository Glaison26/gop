<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
$c_sql_recurso = $_SESSION['sqlrecurso'];
$c_sql_espaco = $_SESSION['sqlespaco'];
$c_sql_avulso = $_SESSION['sqlavulso'];
//echo $c_sql_recurso;
include('../links.php');
include('../conexao.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<script language="Javascript">
    function emissao() {
        var resposta = confirm("Deseja Emitir Ordem de serviço?");
        if (resposta == true) {
            window.location.href = "/gop/ordens/ordens_emissao.php";
        }
    }
</script>
<!-- script da tabela de recursos -->
<script>
    $(document).ready(function() {
        $('.tabordens_recursos').DataTable({
            // 
            "iDisplayLength": -1,
            "order": [1, 'asc'],
            "aoColumnDefs": [{
                'bSortable': false,
                'aTargets': [7]
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
        $('.tabordens_espacos').DataTable({
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

<!-- script da tabela de solicitações avulsas -->
<script>
    $(document).ready(function() {
        $('.tabordens_avulsas').DataTable({
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
                <h5>Lista de Ordens de Serviços<h5>
            </div>
        </div>
    </div>

    <div class="container-fluid">

        <div style="padding-bottom :15px;">
            <div class="topnav">
                <?php
                if ($_SESSION['pesquisamenu'] == false) {
                    echo "<a class='btn btn btn-sm' href='\gop\ordens\ordens.php'><img src='\gop\images\saida.png' alt='' width='25' height='25'> Voltar</a>";
                } else {
                    echo "<a class='btn btn btn-sm' href='\gop\menu.php'><img src='\gop\images\saida.png' alt='' width='25' height='25'> Voltar</a>";
                }

                ?>
            </div>
        </div>

        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>

            <h5>Resultado das Ordens de Serviço Selecionadas</h5>
        </div>
        <!-- abas de solicitações por recursos físicos, Espaços físicos e avulsos -->
        <ul class="nav nav-tabs nav-tabs-responsive" role="tablist">
            <li role="presentation" class="active"><a href="#recurso" aria-controls="recurso" role="tab" data-toggle="tab">Ordens de Serviço em Recurso Físico</a></li>
            <li role="presentation"><a href="#espaco" aria-controls="espaco" role="tab" data-toggle="tab">Ordens de Serviço em Espaços Físicos</a></li>
            <li role="presentation"><a href="#avulsas" aria-controls="avulsas" role="tab" data-toggle="tab">Ordens de Serviço Avulsas</a></li>
        </ul>
        <div class="tab-content">
            <!-- aba da recurso fisico-->
            <div role="tabpanel" class="tab-pane active" id="recurso">
                <div style="padding-top:15px;padding-left:20px;">
                    <table class="table table display table-bordered table-striped table-active tabordens_recursos">
                        <thead class="thead">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col"># Sol.</th>
                                <th scope="col">Data</th>
                                <th scope="col">Hora</th>
                                <th scope="col">Data SLA</th>
                                <th scope="col">Descritivo</th>
                                <th scope="col">Patrimônio</th>
                                <th scope="col">Status</th>
                                <th scope="col">Setor</th>
                                <th scope="col">Oficina</th>
                                <th scope="col">Responsável</th>
                                <th scope="col">Tipo</th>
                                <th scope="col">Opções</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php

                            // faço a Leitura da tabela com sql
                            //echo $c_sql_recurso;
                            $result = $conection->query($c_sql_recurso);
                            // verifico se a query foi correto
                            if (!$result) {
                                die("Erro ao Executar Sql!!" . $conection->connect_error);
                            }

                            // insiro os registro do banco de dados na tabela 
                            while ($c_linha = $result->fetch_assoc()) {
                                $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_geracao'])));
                                if (!empty($c_linha['data_previsao']))
                                    $c_data_sla = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_previsao'])));
                                else
                                    $c_data_sla = '';
                                $c_hora = date("H:i", strtotime($c_linha['hora_geracao']));
                                $c_cor = "";
                                if ($c_linha['status'] == 'X')
                                    $c_cor = "class='table-danger'";
                                if ($c_linha['status'] == 'A')
                                    $c_cor = "class='table-info'";
                                if ($c_linha['status'] == 'C')
                                    $c_cor = "class='table-success'";
                                if ($c_linha['status'] == 'S')
                                    $c_cor = "class='table-warning'";

                                echo "
                                <tr>
                                    <td>$c_linha[id]</td>
                                    <td>$c_linha[id_solicitacao]</td>
                                    <td>$c_data</td>
                                    <td>$c_hora</td>
                                    <td>$c_data_sla</td>
                                    <td>$c_linha[descritivo]</td>
                                    <td>$c_linha[patrimonio]</td>
                                    <td $c_cor style='text-align:center'>$c_linha[ordens_status]</td>
                                    <td>$c_linha[setor]</td>
                                    <td>$c_linha[oficina]</td>
                                    <td>$c_linha[executor]</td>
                                    <td>$c_linha[ordens_tipo_texto]</td>
                                    
                                    <td>
                                        
                                        <a class='btn btn-success btn-sm' href='/gop/ordens/ordens_gerenciar.php?id=$c_linha[id]'>
                                        <img src='\gop\images\gerenciamento.png' alt='' width='23' height='18'> Gerenciar</a>

                                        <a class='btn btn-info btn-sm' href='/gop/ordens/ordens_emissao.php?id=$c_linha[id]'  target='_blank'>
                                        <span class='glyphicon glyphicon-print'></span> Emitir</a>
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
                    <table class="table table display table-bordered table-striped table-active tabordens_espacos">
                        <thead class="thead">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col"># Sol.</th>
                                <th scope="col">Data</th>
                                <th scope="col">Hora</th>
                                <th scope="col">Data SLA</th>
                                <th scope="col">Descritivo</th>
                                <th scope="col">Status</th>
                                <th scope="col">Setor</th>
                                <th scope="col">Oficina</th>
                                <th scope="col">Responsável</th>
                                <th scope="col">Tipo</th>
                                <th scope="col">Opções</th>
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
                                $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_geracao'])));
                                if (!empty($c_linha['data_previsao']))
                                    $c_data_sla = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_previsao'])));
                                else
                                    $c_data_sla = '';
                                $c_hora = date("H:i", strtotime($c_linha['hora_geracao']));
                                if ($c_linha['status'] == 'X')
                                    $c_cor = "class='table-danger'";
                                if ($c_linha['status'] == 'A')
                                    $c_cor = "class='table-info'";
                                if ($c_linha['status'] == 'C')
                                    $c_cor = "class='table-success'";
                                if ($c_linha['status'] == 'S')
                                    $c_cor = "class='table-warning'";
                                echo "
                                <tr>
                                   <td>$c_linha[id]</td>
                                   <td>$c_linha[id_solicitacao]</td>
                                   <td>$c_data</td>
                                   <td>$c_hora</td>
                                   <td>$c_data_sla</td>
                                   <td>$c_linha[descritivo]</td>
                                   <td $c_cor style='text-align:center'>$c_linha[ordens_status]</td>
                                   <td>$c_linha[setor]</td>
                                   <td>$c_linha[oficina]</td>
                                   <td>$c_linha[executor]</td>
                                   <td>$c_linha[ordens_tipo_texto]</td>
                                    
                                    <td>
                                        
                                        <a class='btn btn-success btn-sm' href='/gop/ordens/ordens_gerenciar.php?id=$c_linha[id]'>
                                        <img src='\gop\images\gerenciamento.png' alt='' width='23' height='18'> Gerenciar</a>
                                        <a class='btn btn-info btn-sm' href='/gop/ordens/ordens_emissao.php?id=$c_linha[id]'>
                                        <span class='glyphicon glyphicon-print'></span> Emitir</a>
                                    
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

                    <table class="table table display table-bordered table-striped table-active tabordens_avulsas">
                        <thead class="thead">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col"># Sol.</th>
                                <th scope="col">Data</th>
                                <th scope="col">Hora</th>
                                <th scope="col">Data SLA</th>
                                <th scope="col">Descritivo</th>
                                <th scope="col">Status</th>
                                <th scope="col">Setor</th>
                                <th scope="col">Oficina</th>
                                <th scope="col">Responsável</th>
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
                                $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_geracao'])));
                                if (!empty($c_linha['data_previsao']))
                                    $c_data_sla = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_previsao'])));
                                else
                                    $c_data_sla = '';
                                $c_hora = date("H:i", strtotime($c_linha['hora_geracao']));
                                if ($c_linha['status'] == 'X')
                                    $c_cor = "class='table-danger'";
                                if ($c_linha['status'] == 'A')
                                    $c_cor = "class='table-info'";
                                if ($c_linha['status'] == 'C')
                                    $c_cor = "class='table-success'";
                                if ($c_linha['status'] == 'S')
                                    $c_cor = "class='table-warning'";
                                echo "
                                <tr>
                                    <td>$c_linha[id]</td>
                                    <td>$c_linha[id_solicitacao]</td>
                                    <td>$c_data</td>
                                    <td>$c_linha[hora_geracao]</td>
                                    <td>$c_data_sla</td>
                                    <td>$c_linha[descritivo]</td>
                                    <td $c_cor style='text-align:center'>$c_linha[ordens_status]</td>
                                    <td>$c_linha[setor]</td>
                                    <td>$c_linha[oficina]</td>
                                    <td>$c_linha[executor]</td>
                                    <td>$c_linha[ordens_tipo_texto]</td>
                                    
                                    <td>
                                        
                                      <a class='btn btn-success btn-sm' href='/gop/ordens/ordens_gerenciar.php?id=$c_linha[id]'>
                                        <img src='\gop\images\gerenciamento.png' alt='' width='23' height='18'> Gerenciar</a>
                                           <a class='btn btn-info btn-sm' href='/gop/ordens/ordens_emissao.php?id=$c_linha[id]' target='_blank'>
                                        <span class='glyphicon glyphicon-print'></span> Emitir</a>
                                     
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
        <br>

    </div>

    <!--  modal para opções de emissão de ordem de serviço -->
    <!-- Modal -->
    <div class="modal fade" id="modal_emissao" tabindex="-1" role="dialog" aria-labelledby="modal_emissao" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="emissao"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Opções para emissao :</p>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="" id="chk_materiais">
                        <div style="padding-left:20px;">
                            <label class="form-check-label" for="flexCheckDefault">
                                Materiais
                            </label>
                        </div>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="" id="chk_executores">
                        <div style="padding-left:20px;">
                            <label class="form-check-label" for="flexCheckChecked">
                                Executores
                            </label>
                        </div>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="" id="chk_ferramentas">
                        <div style="padding-left:20px;">
                            <label class="form-check-label" for="flexCheckChecked">
                                Ferramentas
                            </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class='btn btn-success btn-sm' onclick='emissao()'><span class='glyphicon glyphicon-ok'></span> Emitir</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
</body>


</html>


<style>
    /* Add a black background color to the top navigation */
    .topnav {
        background-color: #4682B4;
        overflow: hidden;
    }

    /* Style the links inside the navigation bar */
    .topnav a {
        float: left;
        color: #f2f2f2;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
        font-size: 17px;
    }

    /* Change the color of links on hover */
    .topnav a:hover {
        background-color: #4682B4;
        color: black;
    }

    /* Add a color to the active/current link */
    .topnav a.active {
        background-color: #4682B4;
        color: white;
    }
</style>