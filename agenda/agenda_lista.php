<?php

session_start(); // controle de acesso ao formulário
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
// verifico se usuário e operador de tem autorização de acesso
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.servicos_agenda FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";
$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['servicos_agenda'] == 'N') {
    header('location: /gop/acesso.php');
}
// executo o sql que foi montado
$c_sql = $_SESSION['sql_agenda'];
$registro['status'] = 'C';
//echo $_SESSION['sql_agenda'];

$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();

$c_data = date("d-m-Y", strtotime(str_replace('/', '-', $_SESSION['data1']))) . ' a '
    . date("d-m-Y", strtotime(str_replace('/', '-', $_SESSION['data2'])));

?>

<!-- html com tabela da agenda dp executor de serviço selecionado no período -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agenda de Executor de Serviço</title>

    <!-- script da tabela de solicitações avulsas -->
    <script>
        $(document).ready(function() {
            $('.tab_agenda').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [5]
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

</head>

<body>
    <div class="container-fluid">
        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Agenda de Executor<h5>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h4>Agenda do Executor : <?php echo $_SESSION['executor'] ?> no período de <?php echo $c_data; ?> </h4>
        </div>
        <hr>
        <a class='btn btn btn-sm' href='\gop\agenda\agenda.php'><img src='\gop\images\saida.png' alt='' width='25' height='25'> Voltar</a>
        <hr>
        <table class="table table-bordered table-striped tab_agenda">
            <thead class=" thead">
                <tr>
                    <th scope="col">Numero da OS</th>
                    <th scope="col">Data Inicio</th>
                    <th scope="col">Hora Inicio</th>
                    <?php
                    if ($_SESSION['executor'] == 'Todos os Executores') {
                        echo "<th scope='col'>Executor</th>";
                    }
                    ?>
                    <th scope="col">Descritivo</th>
                    <th scope="col">Setor</th>
                    <th scope="col">Solicitante</th>
                    <th scope="col">Status</th>
                    <th scope="col">Ação</th>

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
                         <td>$c_linha[hora_inicio]</td>";
                         if ($_SESSION['executor'] == 'Todos os Executores') {
                            echo "<td>$c_linha[nome]</td>";
                        }
                        echo "
                         <td>$c_linha[descritivo]</td>
                         <td>$c_linha[setor]</td>
                         <td>$c_linha[solicitante]</td>
                         <td>$c_linha[ordens_status]</td>
                         <td>
                         <a class='btn btn-info btn-sm' href='/gop/ordens/ordens_editar.php?id=$c_linha[id]'>
                                        <span class='glyphicon glyphicon-eye-open'></span> Visualizar</a>
                        </td>               
                                   
                     </tr>";
                }
                ?>
            </tbody>
        </table>
    </div>

</body>

</html>