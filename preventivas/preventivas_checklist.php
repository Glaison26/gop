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
            $('.tabchecklist').DataTable({
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
        function confirmacao_check(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/preventivas/preventivas_check_excluir.php?id=" + id;
            }
        }
    </script>

    <script language="Javascript">
        function chamada_check(id) {
            window.location.href = "/gop/ordens/ordens_checklist_visualizar.php?id=" + id;
        }
    </script>

    <script type="text/javascript">
        // Função javascript e ajax para inclusão dos dados

        $(document).on('submit', '#frmadd_check', function(e) {
            e.preventDefault();
            var c_descricao = $('#add_check').val();

            if (c_descricao != '') {

                $.ajax({
                    url: "preventivas_check_inclusao.php",
                    type: "post",
                    data: {
                        c_descricao: c_descricao

                    },
                    success: function(data) {
                        var json = JSON.parse(data);
                        var status = json.status;

                        location.reload();
                        if (status == 'true') {

                            $('#novoModal_check').modal('hide');
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
        <div class="panel panel-info class">
            <div class="panel-heading">
                <button type="button" title="Inclusão de CheckList" class="btn btn-success" data-toggle="modal" data-target="#novoModal_check">
                    <span class="glyphicon glyphicon-plus"></span>
                    Incluir Check List
                </button>
            </div>
        </div>


        <hr>
        <table class="table display table-bordered tabchecklist">
            <thead class="thead">
                <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT preventivas_checklist.id, checklist.descricao, preventivas_checklist.id_check, checklist.descritivo FROM preventivas_checklist
            JOIN checklist ON preventivas_checklist.id_check=checklist.id
            WHERE preventivas_checklist.id_preventiva='$i_id'
            ORDER BY checklist.descricao";
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
                    <td>
                   <a class='btn btn-info btn-sm' href='javascript:func()'onclick='chamada_check($c_linha[id_check])'><span class='glyphicon glyphicon-eye-open'></span> Visualizar</a>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao_check($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>

                    </tr>
                    ";
                }
                ?>
            </tbody>
        </table>
    </div>

    <!-- janela Modal para inclusão de registro -->
    <div class="modal fade" class="modal-dialog modal-lg" id="novoModal_check" name="novoModal_check" tabindex="-1" role="dialog" aria-labelledby="novoModal_check" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">Inclusão de Check List a Ordem de Serviço</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmadd_check" action="">
                        <div class="mb-3 row">
                            <label for="add_check" class="col-md-3 form-label">Selecionar CheckList</label>
                            <div class="col-sm-9">
                                <select class="form-select form-select-lg mb-3" id="add_check" name="add_check">
                                    <option></option>
                                    <?php
                                    // select da tabela de checklist
                                    $c_sql_check = "SELECT checklist.id, checklist.descricao FROM checklist ORDER BY checklist.descricao";
                                    $result_check = $conection->query($c_sql_check);
                                    while ($c_linha = $result_check->fetch_assoc()) {
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