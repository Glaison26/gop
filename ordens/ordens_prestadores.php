<?php
///////////////////////////////////////////////////////////////////////
// arquivo de include com tabela de materiais de ordem de serviço
///////////////////////////////////////////////////////////////////////


include_once "../lib_gop.php";
include("../conexao.php"); // conexão de banco de dados
include("../links.php");
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
?>

<script language="Javascript">
    function confirmacao_prestador(id) {
        var resposta = confirm("Deseja remover esse registro?");
        if (resposta == true) {
            window.location.href = "/gop/ordens/ordens_prestadores_excluir.php?id=" + id;
        }
    }
</script>

<script>
    $(document).ready(function() {
        $('.tabprestadores').DataTable({
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
    <?php
    if (($c_linha_ordem['status'] <> 'C') && ($c_linha_ordem['status'] <> 'S') && ($c_linha_ordem['status'] <> 'X'))
        echo "<div class='panel panel-info class'>
        <div class='panel-heading'>
            
             <a class='btn btn' href='/gop/ordens/ordens_prestadores_inclusao.php'><span class='glyphicon glyphicon-plus'></span> Incluir Prestador</a>
            
        </div>
    </div>";
    ?>
    <hr>
    <table class="table display table-bordered tabprestadores">
        <thead class="thead">
            <tr>
                <th scope="col">Código</th>
                <th scope="col">Prestador</th>
                <th scope="col">Duração</th>
                <th scope="col">Valor Hora</th>
                <th scope="col">Valor Total</th>
                <th scope="col">Opções</th>
            </tr>
        </thead>
        <tbody>
            <?php

            // faço a Leitura da tabela com sql
            $c_sql = "SELECT ordens_prestadores.id, prestadores.nome, ordens_prestadores.tempo_horas, ordens_prestadores.tempo_minutos,
             ordens_prestadores.valor_hora, ordens_prestadores.valor_total
                    FROM ordens_prestadores
            JOIN prestadores ON ordens_prestadores.id_prestador=prestadores.id
            WHERE ordens_prestadores.id_ordem='$i_id'";
            $result = $conection->query($c_sql);
            // verifico se a query foi correto
            if (!$result) {
                die("Erro ao Executar Sql!!" . $conection->connect_error);
            }

            // insiro os registro do banco de dados na tabela 
            $c_custo_total = 0;
            while ($c_linha = $result->fetch_assoc()) {
                $c_duracao = $c_linha['tempo_horas'] . ':' . $c_linha['tempo_minutos'] . 'hs.';
                if ($c_linha['valor_hora'] > 0) {
                    $c_valor_hora  = $formatter->formatCurrency($c_linha['valor_hora'], 'BRL');
                    $c_valor_total = $formatter->formatCurrency($c_linha['valor_total'], 'BRL');
                    $c_custo_total = $c_custo_total + $c_linha['valor_total'];
                } else {
                    $c_valor_hora = 0;
                    $c_valor_total = 0;
                }
                echo "
                    <tr>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[nome]</td>
                    <td>$c_duracao</td>
                    <td style='text-align: right;'>$c_valor_hora</td>
                    <td style='text-align: right;'>$c_valor_total</td>
                                       
                    <td>";
                if ($c_linha_ordem['status'] <> 'C' && $c_linha_ordem['status'] <> 'S') {
                    echo "<a class='btn btn-secondary btn-sm' href='/gop/ordens/ordens_prestadores_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao_prestador($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>";
                }

                echo "</tr>";
            }
            ?>
        </tbody>
    </table>
    <hr>
    <div class="panel panel-primary class">
        <div class="panel-heading">
            <p>
            <h5>Custo Total de Serviços : <?php echo  $formatter->formatCurrency($c_custo_total, 'BRL'); ?></h5>
            </p>
        </div>
    </div>
</div>