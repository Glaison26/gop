<?php
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('../links2.php');
include('../conexao.php');
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <script>
        $(document).ready(function() {
            $('.tabplanejamento').DataTable({
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

    <script language="Javascript">
        function confirmacao_plano(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/ordens/ordens_plano_excluir.php?id=" + id;
            }
        }
    </script>

    <script language="Javascript">
        function chamada_plano(id) {
             window.open("/gop/ordens/ordens_plano_visualizar.php?id=" + id, '_blank');
        }
    </script>

    <script type="text/javascript">
        // Função javascript e ajax para inclusão dos dados

        $(document).on('submit', '#frmadd_plano', function(e) {
            e.preventDefault();
            var c_descricao = $('#add_plano').val();

            if (c_descricao != '') {

                $.ajax({
                    url: "ordens_plano_inclusao.php",
                    type: "post",
                    data: {
                        c_descricao: c_descricao

                    },
                    success: function(data) {
                        var json = JSON.parse(data);
                        var status = json.status;

                        location.reload();
                        if (status == 'true') {

                            $('#novoModal_plano').modal('hide');
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

    <br>
    <div class="container-fluid">
        <?php
        if ($c_linha_ordem['status'] <> 'C' && $c_linha_ordem['status'] <> 'S')
            echo "
        <div class='panel panel-info class'>
            <div class='panel-heading'>
                <button type='button' title='Inclusão de Planejamento' class='btn btn' data-toggle='modal' data-target='#novoModal_plano'>
                    <span class='glyphicon glyphicon-plus'></span>
                    Incluir Planejamento
                </button>
            </div>
        </div>";
        ?>


        <hr>
        <table class="table display table-bordered tabchecklist">
            <thead class="thead">
                <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Data</th>
                    <th scope="col">Gerência</th>
                    <th scope="col">Descritivo do Planejamento</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT ordens_plano.id, planejamento.descritivo, ordens_plano.id_plano, planejamento.data, planejamento.gerencia FROM ordens_plano
            JOIN planejamento ON ordens_plano.id_plano=planejamento.id
            WHERE ordens_plano.id_ordem='$i_id'
            ORDER BY planejamento.descritivo";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }
                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data'])));
                    echo "
                    <tr>
                    <td>$c_linha[id]</td>
                    <td>$c_data</td>
                    <td>$c_linha[gerencia]</td>
                    <td>$c_linha[descritivo]</td>
                    <td>
                    <a class='btn btn-info btn-sm' href='javascript:func()'onclick='chamada_plano($c_linha[id_plano])'><span class='glyphicon glyphicon-eye-open'></span> Visualizar</a>&nbsp;";
                    if ($c_linha_ordem['status'] <> 'C' && $c_linha_ordem['status'] <> 'S')
                        echo "<a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao_plano($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>";

                    echo "</td>";

                    "</tr>
                    ";
                }
                ?>
            </tbody>
        </table>
    </div>

    <!-- janela Modal para inclusão de registro -->
    <div class="modal fade" class="modal-dialog modal-lg" id="novoModal_plano" name="novoModal_plano" tabindex="-1" role="dialog" aria-labelledby="novoModal_plano" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">Inclusão de Planejamento a Ordem de Serviço</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmadd_plano" action="">
                        <div class="mb-3 row">
                            <label for="add_plano" class="col-md-3 form-label">Selecionar Planejamento</label>
                            <div class="col-sm-9">
                                <select class="form-select form-select-lg mb-3" id="add_plano" name="add_plano">
                                    <option></option>
                                    <?php
                                    // select da tabela de planejamentos
                                    $c_sql_plano = "SELECT planejamento.id, planejamento.descritivo FROM planejamento ORDER BY planejamento.descritivo";
                                    $result_plano = $conection->query($c_sql_plano);
                                    while ($c_linha = $result_plano->fetch_assoc()) {
                                        echo "<option >$c_linha[descritivo]</option>";
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