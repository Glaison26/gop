<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include('../links.php');
include('../conexao.php');
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.servicos_solicitacoes, perfil_usuarios.gera_os FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";

$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['servicos_solicitacoes'] == 'N') {

    header('location: /gop/acesso.php');
}
if (!empty($_SESSION['consulta_solicitacao'])) { // consulta da solicitação após geração da mesma
    $id_nova_solicitacao = $_SESSION['consulta_solicitacao'];
    // recurso fisico
    $c_sql_recurso = "SELECT solicitacao.id, ocorrencias.descricao, solicitacao.prazo_data, solicitacao.data_conclusao,
   solicitacao.hora_conclusao, solicitacao.prazo_hora, solicitacao.id_ordem, solicitacao.data_abertura,
   solicitacao.hora_abertura, solicitacao.id_solicitante, solicitacao.id_recursos, solicitacao.tipo,
   solicitacao.`status`, usuarios.nome AS solicitante, recursos.descricao AS recurso, 
   case WHEN solicitacao.tipo='P' THEN 'Programada' ELSE 'Urgência' END AS solicitacao_tipo, 
   case when solicitacao.status='A' then 'Aberta' when solicitacao.status='E' then 'Em Andamento' 
   when solicitacao.status='C' then 'Concluída' when solicitacao.status='X' then 'Cancelada'
   END AS solicitacao_status FROM solicitacao JOIN usuarios ON solicitacao.id_solicitante=usuarios.id 
   JOIN recursos ON solicitacao.id_recursos=recursos.id JOIN ocorrencias on solicitacao.id_ocorrencia=ocorrencias.id 
   where solicitacao.id = '$id_nova_solicitacao' order by solicitacao.data_abertura desc";
    // espaço fisico
    $c_sql_espaco = "SELECT solicitacao.id, ocorrencias.descricao, solicitacao.prazo_data, solicitacao.data_conclusao,
    solicitacao.hora_conclusao, solicitacao.prazo_hora, solicitacao.id_ordem, solicitacao.data_abertura, 
    solicitacao.hora_abertura, solicitacao.id_solicitante, solicitacao.tipo, solicitacao.`status`, 
    usuarios.nome AS solicitante, espacos.descricao AS espaco, case WHEN solicitacao.tipo='P' THEN 'Programada'
    ELSE 'Urgência' END AS solicitacao_tipo, case when solicitacao.status='A' then 'Aberta' 
    when solicitacao.status='E' then 'Em Andamento' when solicitacao.status='C' then 'Concluída'
    when solicitacao.status='X' then 'Cancelada' END AS solicitacao_status FROM solicitacao 
    JOIN usuarios ON solicitacao.id_solicitante=usuarios.id JOIN espacos ON solicitacao.id_espaco=espacos.id 
    JOIN ocorrencias on solicitacao.id_ocorrencia=ocorrencias.id where solicitacao.id = '$id_nova_solicitacao'
    order by solicitacao.data_abertura desc";
    // solicitação avulsa
    $c_sql_avulso = "SELECT solicitacao.id, ocorrencias.descricao, solicitacao.prazo_data, solicitacao.data_conclusao,
     solicitacao.hora_conclusao, solicitacao.prazo_hora, solicitacao.id_ordem, solicitacao.data_abertura, 
     solicitacao.hora_abertura, solicitacao.id_solicitante, solicitacao.tipo, solicitacao.`status`, 
     usuarios.nome AS solicitante, case WHEN solicitacao.tipo='P' THEN 'Programada' ELSE 'Urgência' 
     END AS solicitacao_tipo, case when solicitacao.status='A' then 'Aberta' when solicitacao.status='E' 
     then 'Em Andamento' when solicitacao.status='C' then 'Concluída' when solicitacao.status='X' 
     then 'Cancelada' END AS solicitacao_status FROM solicitacao 
     JOIN usuarios ON solicitacao.id_solicitante=usuarios.id 
     JOIN ocorrencias on solicitacao.id_ocorrencia=ocorrencias.id 
     where solicitacao.id = '$id_nova_solicitacao' and classificacao='V' order by solicitacao.data_abertura desc";
    $_SESSION['consulta_solicitacao'] = "";
} else {
    $c_sql_recurso = $_SESSION['sqlrecurso'];
    $c_sql_espaco = $_SESSION['sqlespaco'];
    $c_sql_avulso = $_SESSION['sqlavulso'];
}
//echo $c_sql_recurso.'<br>';
//echo $c_sql_espaco.'<br>';
//echo $c_sql_avulso;

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
    <link rel="shortcut icon" type="imagex/png" href="../imagens/img_gop.ico">

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

        <!-- abas de solicitações por recursos físicos, Espaços físicos e avulsos -->
        <ul class="nav nav-tabs" role="tablist">
            <?php
            if (($registro_conf['solicitacao_avulsa'] == 'S') || ($_SESSION['tipo'] <> 'Solicitante')) {
                echo '
            <li role="presentation" class="active"><a href="#avulsas" aria-controls="avulsas" role="tab" data-toggle="tab">Visualizar Solicitações</a></li>';
            }
            if (($registro_conf['solicitacao_recursos'] == 'S') || ($_SESSION['tipo'] <> 'Solicitante')) {
                echo '
            <li role="presentation"><a href="#recurso" aria-controls="recurso" role="tab" data-toggle="tab">Visualizar Solicitações em Recurso Físico</a></li>';
            }
            if (($registro_conf['solicitacao_espacos'] == 'S' || ($_SESSION['tipo'] <> 'Solicitante'))) {
                echo '
            <li role="presentation"><a href="#espaco" aria-controls="espaco" role="tab" data-toggle="tab">Visualizar Solicitações em Espaços Físicos</a></li>';
            }
            ?>
        </ul>
        <div class="tab-content">
            <!-- aba da recurso fisico-->

            <div role="tabpanel" class="tab-pane" id="recurso">
                <div style="padding-top:15px;padding-left:20px;">
                    <table class="table table display table-bordered table-striped table-active tabsolicitacao_recursos">
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
                                if ($c_linha['id_ordem'] <> null)
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
                    <table class="table table display table-bordered table-striped table-active tabsolicitacao_espacos">
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
                                if ($c_linha['id_ordem'] <> null)
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
                    <table class="table table display table-bordered table-striped table-active tabsolicitacao_avulsas">
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
                                if ($c_linha['id_ordem'] <> null)
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
        <hr>
        <div style="padding-bottom :15px;">
            <?php
            if ($_SESSION['pesquisamenu'] == false) {
                echo "<a class='btn btn btn-sm' align='left' href='\gop\solicitacao\solicitacao.php'><img src='\gop\images\saida.png' alt='' width='25' height='25'> Voltar</a>";
            } else {
                echo "<a class='btn btn btn-sm' align='left' href='\gop\menu.php'><img src='\gop\images\saida.png' alt='' width='25' height='25'> Voltar</a>";
            }
            ?>
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