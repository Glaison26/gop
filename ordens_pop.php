<?php
///////////////////////////////////////////////////////////////////////
// arquivo de include com tabela de materiais de ordem de serviço
///////////////////////////////////////////////////////////////////////

if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('links2.php');
include('conexao.php');
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
            $('.tabpops').DataTable({
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

    <script type="text/javascript">
        // Função javascript e ajax para inclusão dos dados

        $(document).on('submit', '#frmadd', function(e) {
            e.preventDefault();
            var c_descricao = $('#pop').val();

            if (c_descricao != '') {

                $.ajax({
                    url: "ordens_pop_inclusao.php",
                    type: "post",
                    data: {
                        c_descricao: c_descricao

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
                $('#pop').val(data[1]);


            });
        });
    </script>

<script type="text/javascript">
        ~
        // Função javascript e ajax para Alteração dos dados
        $(document).on('submit', '#frmup', function(e) {
            e.preventDefault();
            var c_id = $('#up_idField').val();
            var c_descricao = $('#pop').val();

            if (c_descricao != '') {

                $.ajax({
                    url: "ordens_pop_editar.php",
                    type: "post",
                    data: {
                        c_id: c_id,
                        c_descricao: c_descricao
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

    <div class="container-fluid">

        <div class="panel panel-info class">
            <div class="panel-heading">
                <button type="button" title="Inclusão de POP" class="btn btn-success" data-toggle="modal" data-target="#novoModal"><span class="glyphicon glyphicon-plus"></span>
                    Incluir POP
                </button>
            </div>
        </div>

        <hr>
        <table class="table table display table-bordered tabpops">
            <thead class="thead">
                <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Tipo</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT ordens_pop.id, pops.descricao, CASE WHEN pops.tipo ='1' THEN 'Administrativo'" .
                    "WHEN pops.tipo ='2' THEN 'Instalação'" .
                    "END AS tipopop FROM ordens_pop
                        JOIN pops ON ordens_pop.id_pop=pops.id
                        WHERE ordens_pop.id_ordem='$i_id'";
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
                    <td>$c_linha[tipopop]</td>
                    
                   
                    <td>
                    <button type='button' class='btn btn-secondary btn-sm editbtn' data-toggle='modal' title='Editar POP da Ordem de Serviço'><span class='glyphicon glyphicon-pencil'></span> Editar</button>
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

<!-- janela Modal para inclusão de registro -->
<div class="modal fade" class="modal-dialog modal-lg" id="novoModal" name="novoModal" tabindex="-1" role="dialog" aria-labelledby="novoModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Inclusão de POP a Ordem de Serviço</h4>
            </div>
            <div class="modal-body">
                <div class='alert alert-warning' role='alert'>
                    <h5>Campos com (*) são obrigatórios</h5>
                </div>
                <form id="frmadd" action="">
                    <div class="mb-3 row">
                        <label for="add_descricaoField" class="col-md-3 form-label">Selecionar POP</label>
                        <div class="col-sm-9">
                            <select class="form-select form-select-lg mb-3" id="pop" name="pop">
                                <option></option>
                                <?php
                                // select da tabela de pops
                                $c_sql_pop = "SELECT pops.id, pops.descricao FROM pops ORDER BY pops.descricao";
                                $result_pop = $conection->query($c_sql_pop);
                                while ($c_linha = $result_pop->fetch_assoc()) {

                                    echo "<option $op>$c_linha[descricao]</option>";
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

<!-- Modal para edição dos dados -->
<div class="modal fade" id="editmodal" tabindex="-1" role="dialog" aria-labelledby="editmodal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Editar POP da Ordem de Serviço</h4>
            </div>
            <div class="modal-body">
                <div class='alert alert-warning' role='alert'>
                    <h5>Campos com (*) são obrigatórios</h5>
                </div>
                <form id="frmup" method="POST" action="">
                    <input type="hidden" id="up_idField" name="up_idField">
                    <div class="mb-3 row">
                        <label for="add_descricaoField" class="col-md-3 form-label">Selecionar POP</label>
                        <div class="col-sm-9">
                            <select class="form-select form-select-lg mb-3" id="pop" name="pop">
                                <option></option>
                                <?php
                                // select da tabela de pops
                                $c_sql_pop = "SELECT pops.id, pops.descricao FROM pops ORDER BY pops.descricao";
                                $result_pop = $conection->query($c_sql_pop);
                                while ($c_linha = $result_pop->fetch_assoc()) {
                                    $op = '';
                                    if ($c_linha['id']==$_POST['up_idField']){
                                       $op='selected' ;
                                    }

                                    echo "<option $op>$c_linha[descricao]</option>";
                                }
                                ?>
                            </select>
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

</html>