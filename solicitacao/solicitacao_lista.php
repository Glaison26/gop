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
// sql do arquivo de configurações 
$c_sql_conf = "select * from configuracoes";
$result_conf = $conection->query($c_sql_conf);
$registro_conf = $result_conf->fetch_assoc();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<!-- script da tabela de recursos -->
<script>
    $(document).ready(function() {
        $('.tabsolicitacao_recursos').DataTable({
            // 
            "iDisplayLength": -1,
            "order": [0, 'desc'],
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
        $('.tabsolicitacao_espacos').DataTable({
            // 
            "iDisplayLength": -1,
            "order": [0, 'desc'],
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
        $('.tabsolicitacao_avulsas').DataTable({
            // 
            "iDisplayLength": -1,
            "order": [0, 'desc'],
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
                <h5>Solicitações de Serviços<h5>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Resultado das Solicitações Selecionadas</h5>
        </div>
        <div style="padding-bottom :15px;">
            <?php
            if ($_SESSION['pesquisamenu'] == false) {
                echo "<a class='btn btn btn-sm' align='left' href='\gop\solicitacao\solicitacao.php'><img src='\gop\images\saida.png' alt='' width='25' height='25'> Voltar</a>";
            } else {
                echo "<a class='btn btn btn-sm' align='left' href='\gop\menu.php'><img src='\gop\images\saida.png' alt='' width='25' height='25'> Voltar</a>";
            }
            ?>
        </div>

        <!-- abas de solicitações por recursos físicos, Espaços físicos e avulsos -->
        <ul class="nav nav-tabs" role="tablist">
            <?php
            if ($registro_conf['solicitacao_avulsa'] == 'S') {
                echo '
            <li role="presentation" class="active"><a href="#avulsas" aria-controls="avulsas" role="tab" data-toggle="tab">Visualizar Solicitações</a></li>';
            }
            if ($registro_conf['solicitacao_recursos'] == 'S') {
                echo '
            <li role="presentation"><a href="#recurso" aria-controls="recurso" role="tab" data-toggle="tab">Visualizar Solicitações em Recurso Físico</a></li>';
            }
            if ($registro_conf['solicitacao_espacos'] == 'S') {
                echo '
            <li role="presentation"><a href="#espaco" aria-controls="espaco" role="tab" data-toggle="tab">Visualizar Solicitações em Espaços Físicos</a></li>';
            }
            ?>
        </ul>
        <div class="tab-content">
            <!-- aba da recurso fisico-->

            <div role="tabpanel" class="tab-pane" id="recurso">
                <div style="padding-top:15px;padding-left:20px;">
                    <table class="table table-bordered table-striped tabsolicitacao_recursos">
                        <thead class="thead">
                            <tr>
                                <th scope="col"># Sol.</th>
                                <th scope="col"># OS</th>
                                <th scope="col">Status</th>
                                <th scope="col">Ocorrência</th>
                                <th scope="col">Abertura</th>
                                <th scope="col">Hora</th>
                                <th scope="col">Prazo data</th>
                                <th scope="col">Prazo Hora</th>
                                <th scope="col">Solicitante</th>
                                <th scope="col">Recurso Físico</th>
                                <th scope="col">Tipo</th>
                                <th scope="col">Conclusão</th>
                                <th scope="col">Hora Conclusão</th>
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
                                $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_abertura'])));
                                if (!empty($c_linha['prazo_data']))
                                    $c_data_prazo = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['prazo_data'])));
                                else
                                    $c_data_prazo = 'a definir';
                                // variavel que receber cor azul quando for programada e vermelho quando for urgência
                                $c_cor = '';
                                if ($c_linha['solicitacao_tipo'] == 'Programada') {
                                    $c_cor = 'style="color:blue;"';
                                } elseif ($c_linha['solicitacao_tipo'] == 'Urgência') {
                                    $c_cor = 'style="color:red;"';
                                }
                                if (!empty($c_linha['data_conclusao']))
                                    $c_data_conclusao = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_conclusao'])));
                                else
                                    $c_data_conclusao = 'a definir';
                                if (!empty($c_linha['hora_conclusao']))
                                    $c_hora_conclusao = $c_linha['hora_conclusao'];
                                else
                                    $c_hora_conclusao = 'a definir';
                                if (!empty($c_linha['prazo_hora']))
                                    $c_prazo_hora = $c_linha['prazo_hora'];
                                else
                                    $c_prazo_hora = 'a definir';
                                if ($c_linha['id_ordem']<>null)
                                    $i_os = $c_linha['id_ordem'];
                                else
                                    $i_os = 'N.G';
                                echo "
                                <tr>
                                    <td>$c_linha[id]</td>
                                    <td>$i_os</td>
                                    <td>$c_linha[solicitacao_status]</td>
                                    <td>$c_linha[descricao]</td>
                                    <td>$c_data</td>
                                    <td>$c_linha[hora_abertura]</td>
                                    <td>$c_data_prazo</td>
                                    <td>$c_prazo_hora</td>
                                    <td>$c_linha[solicitante]</td>
                                    <td>$c_linha[recurso]</td>
                                    <td $c_cor>$c_linha[solicitacao_tipo]</td>
                                    <td>$c_data_conclusao</td>
                                    <td>$c_hora_conclusao</td>
                            
                                    <td>
                                        <a class='btn btn-secondary btn-sm' href='/gop/solicitacao/solicitacao_detalhe.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Detalhe</a>
                                        
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
                    <table class="table table-bordered table-striped tabsolicitacao_espacos">
                        <thead class="thead">
                            <tr>
                                <th scope="col"># Sol.</th>
                                <th scope="col"># OS</th>
                                <th scope="col">Status</th>
                                <th scope="col">Ocorrência</th>
                                <th scope="col">Abertura</th>
                                <th scope="col">Hora</th>
                                <th scope="col">Prazo data</th>
                                <th scope="col">Prazo Hora</th>
                                <th scope="col">Solicitante</th>
                                <th scope="col">Espaço Físico</th>
                                <th scope="col">Tipo</th>
                                <th scope="col">Conclusão</th>
                                <th scope="col">Hora Conclusão</th>
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
                                $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_abertura'])));
                                if (!empty($c_linha['prazo_data']))
                                    $c_data_prazo = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['prazo_data'])));
                                else
                                    $c_data_prazo = 'a definir';
                                // variavel que receber cor azul quando for programada e vermelho quando for urgência
                                $c_cor = '';
                                if ($c_linha['solicitacao_tipo'] == 'Programada') {
                                    $c_cor = 'style="color:blue;"';
                                } elseif ($c_linha['solicitacao_tipo'] == 'Urgência') {
                                    $c_cor = 'style="color:red;"';
                                }
                                if (!empty($c_linha['data_conclusao']))
                                    $c_data_conclusao = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_conclusao'])));
                                else
                                    $c_data_conclusao = 'a definir';
                                if (!empty($c_linha['hora_conclusao']))
                                    $c_hora_conclusao = $c_linha['hora_conclusao'];
                                else
                                    $c_hora_conclusao = 'a definir';
                                if (!empty($c_linha['prazo_hora']))
                                    $c_prazo_hora = $c_linha['prazo_hora'];
                                 else
                                    $c_prazo_hora = 'a definir';
                                 if ($c_linha['id_ordem']<>null)
                                    $i_os = $c_linha['id_ordem'];
                                else
                                    $i_os = 'N.G';
                                echo "
                                <tr>
                                    <td>$c_linha[id]</td>
                                    <td>$i_os</td>
                                    <td>$c_linha[solicitacao_status]</td>
                                    <td>$c_linha[descricao]</td>
                                    <td>$c_data</td>
                                    <td>$c_linha[hora_abertura]</td>
                                    <td>$c_data_prazo</td>
                                    <td>$c_prazo_hora </td>
                                    <td>$c_linha[solicitante]</td>
                                    <td>$c_linha[espaco]</td>
                                    <td $c_cor>$c_linha[solicitacao_tipo]</td>
                                    <td>$c_data_conclusao</td>
                                    <td>$c_hora_conclusao</td>
                                    
                                    <td>
                                        <a class='btn btn-secondary btn-sm' href='/gop/solicitacao/solicitacao_detalhe.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Detalhe</a>
                                     
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
            <div role="tabpanel" class="tab-pane active" id="avulsas">
                <div style="padding-top:15px;padding-left:20px;">
                    <table class="table table-bordered table-striped tabsolicitacao_avulsas">
                        <thead class="thead">
                            <tr>
                                <th scope="col"># Sol.</th>
                                <th scope="col"># OS</th>
                                <th scope="col">Status</th>
                                <th scope="col">Ocorrência</th>
                                <th scope="col">Abertura</th>
                                <th scope="col">Hora</th>
                                <th scope="col">Prazo data</th>
                                <th scope="col">Prazo Hora</th>
                                <th scope="col">Solicitante</th>
                                <th scope="col">Tipo</th>
                                <th scope="col">Conclusão</th>
                                <th scope="col">Hora Conclusão</th>
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
                                if (!empty($c_linha['prazo_data']))
                                    $c_data_prazo = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['prazo_data'])));
                                else
                                    $c_data_prazo = 'a definir';
                                // variavel que receber cor azul quando for programada e vermelho quando for urgência
                                $c_cor = '';
                                if ($c_linha['solicitacao_tipo'] == 'Programada') {
                                    $c_cor = 'style="color:blue;"';
                                } elseif ($c_linha['solicitacao_tipo'] == 'Urgência') {
                                    $c_cor = 'style="color:red;"';
                                }
                                if (!empty($c_linha['data_conclusao']))
                                    $c_data_conclusao = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_conclusao'])));
                                else
                                    $c_data_conclusao = 'a definir';
                                if (!empty($c_linha['hora_conclusao']))
                                    $c_hora_conclusao = $c_linha['hora_conclusao'];
                                else
                                    $c_hora_conclusao = 'a definir';
                                if (!empty($c_linha['prazo_hora']))
                                    $c_prazo_hora = $c_linha['prazo_hora'];
                                 else
                                    $c_prazo_hora = 'a definir';
                                if ($c_linha['id_ordem']<>null)
                                    $i_os = $c_linha['id_ordem'];
                                else
                                    $i_os = 'N.G';
                                echo "
                                <tr>
                                    <td>$c_linha[id]</td>
                                    <td>$i_os</td>
                                    <td>$c_linha[solicitacao_status]</td>
                                    <td>$c_linha[descricao]</td>
                                    <td>$c_data</td>
                                    <td>$c_linha[hora_abertura]</td>
                                    <td>$c_data_prazo</td>
                                    <td>$c_prazo_hora</td>
                                    <td>$c_linha[solicitante]</td>
                                    <td $c_cor>$c_linha[solicitacao_tipo]</td>
                                    <td>$c_data_conclusao</td>
                                    <td>$c_hora_conclusao</td>
                                    <td>
                                        <a class='btn btn-secondary btn-sm' href='/gop/solicitacao/solicitacao_detalhe.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Detalhe</a>
                                        
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