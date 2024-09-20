<script>
    $(document).ready(function() {
        $('.tabferramentas').DataTable({
            // 
            "iDisplayLength": -1,
            "order": [1, 'asc'],
            "aoColumnDefs": [{
                'bSortable': false,
                'aTargets': [3]
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
    <br>
    <a class="btn btn-success btn-sm" href="/gop/ferramentas_novo.php"><span class="glyphicon glyphicon-plus"></span> Incluir</a>
    <hr>
    <table class="table display table-hover  table-condensed tabferramentas">
        <thead class="thead">
            <tr>
                <th scope="col">Código</th>
                <th scope="col">Descrição</th>
                <th scope="col">Marca</th>
                <th scope="col">Patrimônio</th>
                <th scope="col">Opções</th>
            </tr>
        </thead>
        <tbody>
            <?php
            // faço a Leitura da tabela com sql
            $c_sql = "SELECT ordens_ferramentas.id, ferramentas.descricao, ferramentas.patrimonio, marcas.descricao AS marca FROM ordens_ferramentas
                    JOIN ferramentas ON ordens_ferramentas.id_ferramenta=ferramentas.id
                    JOIN marcas ON ferramentas.id_marca = marcas.id
                    WHERE ordens_ferramentas.id_ordem='$i_id'
                    ORDER BY ferramentas.descricao";

            $result = $conection->query($c_sql);
            // verifico se a query foi correto
            if (!$result) {
                die("Erro ao Executar Sql!!" . $conection->connect_error);
            }

            // insiro os registro do banco de dados na tabela 
            while ($c_linha = $result->fetch_assoc()) {

                echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[descricao]</td>
                    <td>$c_linha[marca]</td>
                    <td>$c_linha[patrimonio]</td>
                               
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/ferramentas_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>

                    </tr>
                    ";
            }
            ?>
        </tbody>
    </table>
</div>