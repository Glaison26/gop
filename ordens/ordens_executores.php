<?php
///////////////////////////////////////////////////////////////////////
// arquivo de include com tabela de materiais de ordem de serviço
///////////////////////////////////////////////////////////////////////

include_once "../lib_gop.php";
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
?>

<script language="Javascript">
    function confirmacao(id) {
        var resposta = confirm("Deseja remover esse registro?");
        if (resposta == true) {
            window.location.href = "/gop/ordens/ordens_executores_excluir.php?id=" + id;
        }
    }
</script>

<script>
    $(document).ready(function() {
        $('.tabexecutores').DataTable({
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
            <a class="btn btn-success" href="/gop/ordens/ordens_executores_inclusao.php"><span class="glyphicon glyphicon-plus"></span> Incluir Executor</a>
        </div>
    </div>
    <hr>
    <table class="table display table-bordered tabexecutores">
        <thead class="thead">
            <tr>
                <th scope="col">Código</th>
                <th scope="col">Executor</th>
                <th scope="col">Duração</th>
                <th scope="col">Valor Hora</th>
                <th scope="col">Valor Total</th>
                <th scope="col">Opções</th>
            </tr>
        </thead>
        <tbody>
            <?php

            // faço a Leitura da tabela com sql
            $c_sql = "SELECT ordens_executores.id, executores.nome, ordens_executores.tempo_horas, ordens_executores.tempo_minutos,
             ordens_executores.valor_hora, ordens_executores.valor_total
                    FROM ordens_executores
            JOIN executores ON ordens_executores.id_executor=executores.id
            WHERE ordens_executores.id_ordem='$i_id'";
            $result = $conection->query($c_sql);
            // verifico se a query foi correto
            if (!$result) {
                die("Erro ao Executar Sql!!" . $conection->connect_error);
            }

            // insiro os registro do banco de dados na tabela 
            $c_custo_total=0;
            while ($c_linha = $result->fetch_assoc()) {
                $c_duracao = $c_linha['tempo_horas'].':'.$c_linha['tempo_minutos'].'hs.';
                $c_valor_hora  = $formatter->formatCurrency($c_linha['valor_hora'], 'BRL');
                $c_valor_total = $formatter->formatCurrency($c_linha['valor_total'], 'BRL');
                $c_custo_total = $c_custo_total + $c_linha['valor_total'];
                echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[nome]</td>
                    <td>$c_duracao</td>
                    <td style='text-align: right;'>$c_valor_hora</td>
                    <td style='text-align: right;'>$c_valor_total</td>
                                       
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/ordens/ordens_executores_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
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
            <p><h5>Custo Total de Serviços : <?php echo  $formatter->formatCurrency($c_custo_total, 'BRL');?></h5></p>
        </div>
    </div>
</div>