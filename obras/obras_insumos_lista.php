<?php
include("../conexao.php");
include("../links2.php");
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
if (!isset($_GET["id"])) {
    header('location: /gop/obras/obras_lista.php');
    exit;
}
// captura id do registro de obra
$c_id = $_GET["id"];
// pego descrição da obra via sql
$c_sql = "select * from obra where id = '$c_id'";
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();
$c_descricao_obra = $c_linha['descricao'];
?>

<!--
parte de frontend
-->


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<script language="Javascript">
    function confirmacao(id) {
        var resposta = confirm("Deseja remover esse registro?");
        if (resposta == true) {
            window.location.href = "/gop/obras/obras_insumos_excluir.php?id=" + id;
        }
    }
</script>

<script language="Javascript">
    function mensagem(msg) {
        alert(msg);
    }
</script>


<script>
    $(document).ready(function() {
        $('.tabgrupos').DataTable({
            // 
            "iDisplayLength": -1,
            "order": [1, 'asc'],
            "aoColumnDefs": [{
                'bSortable': false,
                'aTargets': [9]
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
    <div class="container-fluid">
        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Lista de Insumos de Obras<h5>
            </div>
        </div>

        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Insumos da Obra : <?php echo $c_descricao_obra ?></h5>
        </div>
        <a class="btn btn-success btn-sm" href="/gop/obras/obras_insumo_novo.php"><span class="glyphicon glyphicon-plus"></span> Incluir</a>
        <a class="btn btn-secondary btn-sm" href="/gop/obras/obras_menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
        <hr>
        <table class="table table display table-bordered tabgrupos">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Insumo da Obra</th>
                    <th scope="col">Grupo</th>
                    <th scope="col">Qtd.</th>
                    <th scope="col">Unid.</th>
                    <th scope="col">Mão de Obra</th>
                    <th scope="col">Total Mão de Obra</th>
                    <th scope="col">Material</th>
                    <th scope="col">Total Material</th>
                    <th scope="col">Valor Total</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT obras_insumos.id, obras_itens.descricao AS insumo, obras_grupo.descricao as grupo,
                unidades.descricao as unidade, obras_insumos.quantidade, obras_insumos.valor_maodeobra, 
                obras_insumos.valor_material
                FROM obras_insumos 
                JOIN obras_itens ON obras_insumos.id_item = obras_itens.id
                JOIN unidades ON obras_insumos.id_unidade = unidades.id
                JOIN obras_grupo ON obras_itens.id_grupo = obras_grupo.id
                ORDER BY obras_itens.descricao";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    $n_maodeobra = $formatter->formatCurrency($c_linha['valor_maodeobra'], 'BRL');
                    $n_material = $formatter->formatCurrency($c_linha['valor_material'], 'BRL');
                    $n_total_maodeobra = $formatter->formatCurrency($c_linha['valor_maodeobra']*$c_linha['quantidade'], 'BRL'); 
                    $n_total_material = $formatter->formatCurrency($c_linha['valor_material']*$c_linha['quantidade'], 'BRL'); 
                    $n_total = ($c_linha['valor_maodeobra']*$c_linha['quantidade'])+($c_linha['valor_material']*$c_linha['quantidade']);
                    $n_total = $formatter->formatCurrency($n_total, 'BRL');  
                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[insumo]</td>
                    <td>$c_linha[grupo]</td>
                    <td>$c_linha[quantidade]</td>
                    <td>$c_linha[unidade]</td>
                    <td>$n_maodeobra</td>
                    <td>$n_total_maodeobra</td>
                    <td>$n_material</td>
                    <td>$n_total_material</td>
                    <td>$n_total</td>
                    <td>
                    <button type='button' class='btn btn-secondary btn-sm editbtn' data-toggle='modal' title='Editar Insumo de Obra'><span class='glyphicon glyphicon-pencil'></span> Editar</button>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>

                    </tr>
                    ";
                }
                ?>
            </tbody>
        </table>

    </div>


</body>

</html>