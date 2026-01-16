<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
include("../../links2.php");

?>
<!doctype html>
<html lang="en">

<body>
    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/cadastros/tipos/tipos_excluir.php?id=" + id;
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
            $('.tabtipos').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [3]
                }, {
                    'aTargets': [0],
                    "visible": true
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
    <!-- Função javascript e ajax para inclusão dos dados -->
    <script type="text/javascript">
        $(document).on('submit', '#frmadd', function(e) {
            e.preventDefault();
            var c_descricao = $('#add_descricaoField').val();
            var c_classe = $('#add_classeField').val();
            var c_horas = $('#add_horasField').val();

            if (c_descricao != '') {

                $.ajax({
                    url: "tipos_novo.php",
                    type: "post",
                    data: {
                        c_descricao: c_descricao,
                        c_classe:c_classe,
                        c_horas:c_horas

                    },
                    success: function(data) {
                        var json = JSON.parse(data);
                        var status = json.status;

                        location.reload();
                        if (status == 'true') {

                            $('#novoModal').modal('hide');
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

    <!-- Coleta dados da tabela para edição do registro -->
    <script>
        $(document).ready(function() {

            $('.editbtn').on('click', function() {

                $('#editmodal').modal('show');

                $tr = $(this).closest('tr');

                var data = $tr.children("td").map(function() {
                    return $(this).text();
                }).get();

                console.log(data);

                $('#up_idField').val(data[0]);
                $('#up_descricaoField').val(data[1]);
                $('#up_classeField').val(data[2]);
                $('#up_horasField').val(data[3]);
            });
        });
    </script>

    <script type="text/javascript">
        ~
        // Função javascript e ajax para Alteração dos dados
        $(document).on('submit', '#frmup', function(e) {
            e.preventDefault();
            var c_id = $('#up_idField').val();
            var c_descricao = $('#up_descricaoField').val();
            var c_classe = $('#up_classeField').val();
            var c_horas = $('#up_horasField').val();

            if (c_descricao != '') {

                $.ajax({
                    url: "tipos_editar.php",
                    type: "post",
                    data: {
                        c_id: c_id,
                        c_descricao: c_descricao,
                        c_classe:c_classe,
                        c_horas:c_horas
                    },
                    success: function(data) {
                        var json = JSON.parse(data);
                        var status = json.status;
                        if (status == 'true') {
                            $('#editmodal').modal('hide');
                            location.reload();
                        } else {
                            alert('falha ao alterar dados');
                        }
                    }
                });

            } else {
                alert('Todos os campos devem ser preenchidos!!');
            }
        });
    </script>


    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Lista de Tipos de Recursos Físicos<h5>
        </div>
    </div>

    <div class="container-fluid">
        <br>
        <button type="button" title="Inclusão de Novo Tipo" class="btn btn-success btn-sm" data-toggle="modal" data-target="#novoModal"><span class="glyphicon glyphicon-plus"></span>
            Incluir
        </button>
        <a class="btn btn-secondary btn-sm" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>

        <hr>
        <table class="table-bordered tabtipos">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Classe</th>
                    <th scope="col">Horas em Operação</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT tipos.id, tipos.descricao, tipos.classe, tipos.horas_operacao FROM tipos ORDER BY tipos.descricao";
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
                    <td>$c_linha[classe]</td>
                    <td>$c_linha[horas_operacao]</td>
                    <td>
                    <button type='button' class='btn btn-secondary btn-sm editbtn' data-toggle='modal' title='Editar Tipo'><span class='glyphicon glyphicon-pencil'></span> Editar</button>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>

                    </tr>
                    ";
                }
                ?>
            </tbody>
        </table>
    </div>

    <!-- janela Modal para inclusão de registro -->
    <div class="modal fade" class="modal-dialog modal-lg" id="novoModal" name="novoModal" tabindex="-1" role="dialog" aria-labelledby="novoModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">Inclusão de novo Tipo</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmadd" action="">
                        <div class="mb-3 row">
                            <label for="add_descricaoField" class="col-md-3 form-label">Descrição *</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="add_descricaoField" name="add_dscricaoField" required>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">Classe *</label>
                            <div class="col-sm-6">
                                <select class="form-select form-select-lg mb-3" id="add_classeField" name="add_classeField" required>
                                    <option></option>
                                    <option>Clinico</option>
                                    <option>Infra Estrutura</option>
                                    <option>Médico</option>
                                    <option>Operacional</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="add_descricaoField" class="col-md-3 form-label">Horas em Operação*</label>
                            <div class="col-md-4">
                                <input type="number" class="form-control" id="add_horasField" name="add_horasField" required>
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


    <!-- Modal para edição dos dados -->
    <div class="modal fade" id="editmodal" tabindex="-1" role="dialog" aria-labelledby="editmodal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">Editar Tipo</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmup" method="POST" action="">
                        <input type="hidden" id="up_idField" name="up_idField">
                        <div class="mb-3 row">
                            <label for="up_descricaoField" class="col-md-3 form-label">Descrição *</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="up_descricaoField" name="up_dscricaoField" required>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">Classe *</label>
                            <div class="col-sm-6">
                                <select class="form-select form-select-lg mb-3" id="up_classeField" name="up_classeField" required>
                                    <option>Clinico</option>
                                    <option>Infra Estrutura</option>
                                    <option>Médico</option>
                                    <option>Operacional</option>

                                </select>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="add_descricaoField" class="col-md-3 form-label">Horas em Operação</label>
                            <div class="col-md-4">
                                <input type="number" class="form-control" id="up_horasField" name="up_horasField" require>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                            <button class="btn btn-secondary" data-dismiss="modal"><span class='glyphicon glyphicon-remove'></span> Fechar</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>

</body>

</html>