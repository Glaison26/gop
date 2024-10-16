<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<body>

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


    <script language="Javascript">
        function confirmacao_ferramentas(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/ordens/ordens_ferramentas_excluir.php?id=" + id;
            }
        }
    </script>


    <script type="text/javascript">
        // Função javascript e ajax para inclusão dos dados

        $(document).on('submit', '#frmadd_ferramenta', function(e) {
            e.preventDefault();
            var c_descricao = $('#ferramentas').val();

            if (c_descricao != '') {

                $.ajax({
                    url: "ordens_ferramentas_inclusao.php",
                    type: "post",
                    data: {
                        c_descricao: c_descricao

                    },
                    success: function(data) {
                        var json = JSON.parse(data);
                        var status = json.status;

                        location.reload();
                        if (status == 'true') {

                            $('#novoModal_ferramenta').modal('hide');
                            location.reload();
                        } else {
                            alert('falha ao incluir dados');
                        }
                    }
                });
            } else {
                alert('Preencha todos os campos obrigatórios');
            }
        });
    </script>

    <div class="container-fluid">
        <br>
        <?php
        if ($c_linha_ordem['status'] <> 'C' && $c_linha_ordem['status'] <> 'S')
            echo "<div class='panel panel-info class'>
            <div class='panel-heading'>
                <button type='button' title='Inclusão de Ferramenta' class='btn btn-success' data-toggle='modal' data-target='#novoModal_ferramenta'>
                    <span class='glyphicon glyphicon-plus'></span>
                    Incluir Ferramenta
                </button>
            </div>
        </div>";
        ?>
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
                    <td>";
                    if ($c_linha_ordem['status'] <> 'C' && $c_linha_ordem['status'] <> 'S')
                        echo
                    "<a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao_ferramentas($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>";
                    echo "</td>";

                    echo "</tr>";
                }
                ?>
            </tbody>
        </table>
    </div>

    <!-- janela Modal para inclusão de registro -->
    <div class="modal fade" class="modal-dialog modal-lg" id="novoModal_ferramenta" name="novoModal_ferramenta" tabindex="-1" role="dialog" aria-labelledby="novoModal_ferramenta" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">Inclusão de ferramenta a Ordem de Serviço</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmadd_ferramenta" action="">
                        <div class="mb-3 row">
                            <label for="add_descricaoField" class="col-md-3 form-label">Selecionar ferramenta</label>
                            <div class="col-sm-9">
                                <select class="form-select form-select-lg mb-3" id="ferramentas" name="ferramentas">
                                    <option></option>
                                    <?php
                                    // select da tabela de checklist
                                    $c_sql_ferramenta = "SELECT ferramentas.id, ferramentas.descricao FROM ferramentas ORDER BY ferramentas.descricao";
                                    $result_ferramenta = $conection->query($c_sql_ferramenta);
                                    while ($c_linha = $result_ferramenta->fetch_assoc()) {
                                        echo "<option >$c_linha[descricao]</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal"><span class='glyphicon glyphicon-remove'></span> Fechar</button>

                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>

</body>

</html>