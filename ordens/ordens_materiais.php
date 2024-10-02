<?php
///////////////////////////////////////////////////////////////////////
// arquivo de include com tabela de materiais de ordem de serviço
///////////////////////////////////////////////////////////////////////

include_once "lib_gop.php";
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);

?>
<script language="Javascript">
    function confirmacao(id) {
        var resposta = confirm("Deseja remover esse registro?");
        if (resposta == true) {
            window.location.href = "/gop/ordens_materiais_excluir.php?id=" + id;
        }
    }
</script>

<script>
    $(document).ready(function() {
        $('.tabmateriais').DataTable({
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


<div class="container-fluid">
    <div class="panel panel-info class">
        <div class="panel-heading">
            <a class="btn btn-success" href="/gop/ordens_materiais_inclusao.php"><span class="glyphicon glyphicon-plus"></span> Incluir Material</a>
        </div>
    </div>
    <hr>
    <table class="table table display table-bordered tabmateriais">
        <thead class="thead">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Material</th>
                <th scope="col">Qtd.</th>
                <th scope="col">Unidade</th>
                <th scope="col">Valor</th>
                <th scope="cod">Vlr. Total</th>
                <th scope="col">Opções</th>
            </tr>
        </thead>
        <tbody>
            <?php

            // faço a Leitura da tabela com sql
            $c_sql = "SELECT ordens_materiais.id, materiais.descricao as material, unidades.abreviatura as unidade, ordens_materiais.quantidade,
                    ordens_materiais.valor FROM ordens_materiais
                    JOIN materiais ON ordens_materiais.id_material=materiais.id
                    JOIN unidades ON ordens_materiais.id_unidade=unidades.id
                    WHERE ordens_materiais.id_ordem='$i_id'";
            $result = $conection->query($c_sql);
            // verifico se a query foi correto
            if (!$result) {
                die("Erro ao Executar Sql!!" . $conection->connect_error);
            }

            // insiro os registro do banco de dados na tabela 
            $c_custo_total = 0;
            while ($c_linha = $result->fetch_assoc()) {

                $c_custo = $formatter->formatCurrency($c_linha['valor'], 'BRL');
                $c_total = $c_linha['valor'] * $c_linha['quantidade'];
                $c_total = $formatter->formatCurrency($c_total, 'BRL');
                $c_custo_total = $c_custo_total + $c_linha['valor'] * $c_linha['quantidade'];

                echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[material]</td>
                    <td>$c_linha[quantidade]</td>
                    <td>$c_linha[unidade]</td>
                    <td style='text-align: right;'>$c_custo</td>
                    <td style='text-align: right;'>$c_total</td>
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/ordens_materiais_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>

                    </tr>
                    ";
            }
            ?>
        </tbody>
    </table>
    <hr>
    <div class="panel panel-primary class">
        <div class="panel-heading">
            <p><h5>Custo Total de Material : <?php echo  $formatter->formatCurrency($c_custo_total, 'BRL');?></h5></p>
        </div>
    </div>
</div>