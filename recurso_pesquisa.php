<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// conexão dom o banco de dados
include("conexao.php");
include("links.php");

$_SESSION['tiposolicitacao'] = 'R';

// faço a Leitura da tabela de recursos com sql
if ((isset($_POST["btnpesquisa"])) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {  // botão para executar sql de pesquisa de recursos
    $c_pesquisa = $_POST['pesquisa'];
    $c_sql =    "SELECT recursos.id, recursos.descricao, recursos.id_setor, recursos.patrimonio, recursos.id_marca,
                marcas.descricao AS marca, setores.descricao AS setor
                FROM recursos
                JOIN setores ON recursos.id_setor=setores.id
                JOIN marcas ON recursos.id_marca=marcas.id";
    if ($c_pesquisa != ' ') {
        $c_sql = $c_sql . " where recursos.descricao LIKE " .  "'" . $c_pesquisa . "%'";
    }
    $c_sql = $c_sql . " order by recursos.descricao";
    $result = $conection->query($c_sql);
    // verifico se a query foi correto
    if (!$result) {
        die("Erro ao Executar Sql!!" . $conection->connect_error);
    }
}

?>
<!--  


Pagina da rotina para selecionar o recurso da solicitação 

-->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<script>
    $(document).ready(function() {
        $('.tabrecursos').DataTable({
            // 
            "iDisplayLength": -1,
            "order": [1, 'asc'],
            "aoColumnDefs": [{
                'bSortable': false,
                'aTargets': [5]
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

<!-- função para chamar conclusão da solicitação -->
<script>
    function conclusao(id) {
        window.location.href = "/gop/solicitacao_conclusao.php?id=" + id;
    }

    function conclusao_prev(id) {
        window.location.href = "/gop/preventivas/preventiva_conclusao.php?id=" + id;
    }
</script>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Seleção de Recurso Físico<h5>
        </div>
    </div>

    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Digite a descrição do recurso físico ou parte dela e clique em buscar. Clique em selecionar ao lado do recurso que deseja abrir.</h5>
        </div>
        <!-- inputs para pesquisa de recurso -->
        <form method="post">
            <hr>
            <div class="mb-5 row">
                <hr>
                <label for="up_parametroField" class="col-sm-3 col-form-label">Buscar Recurso</label>

                <div class="col-sm-6">
                    <input type="text" class="form-control" id="pesquisa" name="pesquisa">

                </div>
                <div class="col-md-3">
                    <button class="btn btn btn-sm" type="submit" id='bntpesquisa' name='btnpesquisa' class="btn btn"><img src='\gop\images\buscar.png' alt='' width='20' height='20'></span> Buscar</button>
                    <?php
                    if ($_SESSION['opcao'] == 'S')
                        echo "<a class='btn btn btn-sm' href='\gop\solicitacao_nova.php'><img src='\gop\images\saida.png' alt='' width='25' height='25'> Voltar</a>";
                    else
                        echo "<a class='btn btn btn-sm' href='\gop\preventivas_nova.php'><img src='\gop\images\saida.png' alt='' width='25' height='25'> Voltar</a>";
                    ?>
                </div>
            </div>
        </form>
        <!-- tabela de recursos fisicos segundo busca executada com sql -->
        <hr>
        <table class="table display  tabrecursos">
            <thead class="thead">
                <tr class="info">
                    <th scope="col">#</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Patrimônio</th>
                    <th scope="col">Marca</th>
                    <th scope="col">Setor</th>
                    <th scope="col">Opção</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if (!empty($c_sql)) {
                    // insiro os registro do banco de dados na tabela 
                    while ($c_linha = $result->fetch_assoc()) {

                        echo "
                    <tr>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[descricao]</td>
                    <td>$c_linha[patrimonio]</td>
                    <td>$c_linha[marca]</td>
                    <td>$c_linha[setor]</td>
                                                       
                    <td>";
                    if ($_SESSION['opcao']=='S')
                      echo "<a class='btn btn' title='Selecionar Recurso' href='javascript:func()'onclick='conclusao($c_linha[id])'><img src='\gop\images\selecionar.png'  width='20' height='20'> Selecionar</a>";
                    else
                      echo "<a class='btn btn' title='Selecionar Recurso' href='javascript:func()'onclick='conclusao_prev($c_linha[id])'><img src='\gop\images\selecionar.png'  width='20' height='20'> Selecionar</a>";
                    echo "</td></tr>";
                    }
                }
                ?>
            </tbody>
        </table>

    </div>



</body>

</html>