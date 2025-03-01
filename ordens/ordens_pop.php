<?php
///////////////////////////////////////////////////////////////////////
// arquivo de include com tabela de materiais de ordem de serviço
///////////////////////////////////////////////////////////////////////

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
    <script language="Javascript">
        function chamada(id) {

            window.open("/gop/ordens/ordens_pop_visualizar.php?id=" + id, '_blank');

        }
    </script>

    <script language="Javascript">
        function confirmacao_pop(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/ordens/ordens_pop_excluir.php?id=" + id;
            }
        }
    </script>

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
                //alert('Preencha todos os campos obrigatórios');
            }
        });
    </script>




    <div class="container-fluid">
        <?php
        if ($c_linha_ordem['status'] <> 'C' && $c_linha_ordem['status'] <> 'S')
            echo "
        <div class='panel panel-info class'>
            <div class='panel-heading'>
               
                <button type='button' title='Inclusão de POP' class='btn btn-success' data-toggle='modal' data-target='#novoModal'>
                    <span class='glyphicon glyphicon-plus'></span>
                    Incluir POP
                </button>
       
            </div>
        </div>";
        ?>

        <hr>
        <table class="table table display table-bordered tabpops">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Tipo</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT ordens_pop.id, ordens_pop.id_pop, pops.descricao, 
                        CASE WHEN pops.tipo ='1' THEN 'Administrativo'" .
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
                    <a class='btn btn-info btn-sm' href='javascript:func()'onclick='chamada($c_linha[id_pop]);' target='_blank'><span class='glyphicon glyphicon-eye-open'></span> Visualizar</a>&nbsp;";
                    if ($c_linha_ordem['status'] <> 'C' && $c_linha_ordem['status'] <> 'S')
                        echo "<a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao_pop($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>";
                    "</td>

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


</html>