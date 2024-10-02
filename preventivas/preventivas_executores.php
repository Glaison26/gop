<?php
///////////////////////////////////////////////////////////////////////
// arquivo de include com tabela de executores de preventivas
///////////////////////////////////////////////////////////////////////

include_once "../lib_gop.php";
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
?>

<script language="Javascript">
    function confirmacao(id) {
        var resposta = confirm("Deseja remover esse registro?");
        if (resposta == true) {
            window.location.href = "/gop/preventivas/preventivas_executores_excluir.php?id=" + id;
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
                'aTargets': [2]
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
            <a class="btn btn-success" href="/gop/preventivas/preventivas_executores_inclusao.php"><span class="glyphicon glyphicon-plus"></span> Incluir Executor</a>
        </div>
    </div>
    <hr>
    <table class="table display table-bordered tabexecutores">
        <thead class="thead">
            <tr>
                <th scope="col">Código</th>
                <th scope="col">Executor</th>
                <th scope="col">Opções</th>
            </tr>
        </thead>
        <tbody>
            <?php

            // faço a Leitura da tabela com sql
            $c_sql = "SELECT preventivas_executores.id, executores.nome 
                    FROM preventivas_executores
            JOIN executores ON preventivas_executores.id_executor=executores.id
            WHERE preventivas_executores.id_preventiva='$i_id'";
            $result = $conection->query($c_sql);
            // verifico se a query foi correto
            if (!$result) {
                die("Erro ao Executar Sql!!" . $conection->connect_error);
            }

            while ($c_linha = $result->fetch_assoc()) {
               
                echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[nome]</td>
                                                        
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/ordens_executores_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>

                    </tr>
                    ";
            }
            ?>
        </tbody>
    </table>
  
</div>