<?php // controle de acesso ao formulário

/////////////////////////////////////////////
// Lista de Planejamentos para Planos de Ação
/////////////////////////////////////////////


session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
$c_texto = "";
?>
<!doctype html>
<html lang="en">

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/plano_acao/planejamento_excluir.php?id=" + id;
            }
        }
    </script>

    <script language="Javascript">
        function mensagem(msg) {
            alert(msg);
        }
    </script>

    <script language="Javascript">
        function chamada_plano(id) {
            window.location.href = "/gop/ordens/ordens_plano_visualizar.php?id=" + id;
        }
    </script>

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

    <!-- Função javascript e ajax para inclusão dos dados -->
    <script type="text/javascript">
        $(document).on('submit', '#frmadd', function(e) {
            e.preventDefault();
            var c_data = $('#add_dataField').val();
            var c_setor = $('#add_setorField').val();
            var c_gerencia = $('#add_gerenciaField').val();
            var c_meta = $('#add_metaField').val();
            var c_descritivo = $('#add_descritivoField').val();

            if ((c_setor != '') || (c_gerencia != '') || (c_descritivo != '')) {

                $.ajax({
                    url: "planejamento_novo.php",
                    type: "post",
                    data: {
                        c_data: c_data,
                        c_setor: c_setor,
                        c_gerencia: c_gerencia,
                        c_meta: c_meta,
                        c_descritivo: c_descritivo

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
                alert('Preencha todos os campos com (*) são obrigatórios');
            }
        });
    </script>





    <!-- montagem da página -->
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Lista de Planejamentos<h5>
        </div>
    </div>

    <br>
    <div class="container-fluid">

        <button type="button" title="Inclusão de novo Planejamento" class="btn btn-success btn-sm" data-toggle="modal" data-target="#novoModal">
            <span class="glyphicon glyphicon-plus"></span>
            Incluir
        </button>
        <a class="btn btn-secondary btn-sm" href="/gop/plano_acao/planos_menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>

        <hr>
        <table class="table table display table-bordered tabplanejamento">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Data</th>
                    <th scope="col">Gerência</th>
                    <th scope="col">Descritivo</th>
                    <th scope="col">Setor</th>

                    <th scope="col">Meta</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT planejamento.id, setores.descricao AS setor, planejamento.id_setor, planejamento.`data`, planejamento.gerencia,
                        planejamento.descritivo, planejamento.meta FROM planejamento 
                        JOIN setores ON planejamento.id_setor=setores.id
                        ORDER BY planejamento.`data` desc";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data'])));
                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_data</td>
                    <td>$c_linha[gerencia]</td>
                    <td>$c_linha[descritivo]</td>
                    <td>$c_linha[setor]</td>
                    
                    <td>$c_linha[meta]</td>
                    <td>
                    <a class='btn btn-secondary btn-sm' title='Editar Planejamento' href='/gop/plano_acao/planejamento_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                    <a class='btn btn-success btn-sm' title='Incluir Estratégia' href='/gop/plano_acao/planejamento_estrategia.php?id=$c_linha[id]'><img src='\gop\images\iconeestrategia.png' alt='' width='16' height='15'> Estratégias</a>
                    <a class='btn btn-info btn-sm' href='javascript:func()'onclick='chamada_plano($c_linha[id])'><span class='glyphicon glyphicon-eye-open'></span> Visualizar</a>
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
                    <h4 class="modal-title" id="exampleModalLabel">Inclusão de novo Planejamento</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmadd" action="">
                        <div class="mb-3 row">
                            <label for="add_descricaoField" class="col-md-3 form-label">Data (*)</label>
                            <div class="col-md-5">
                                <input type="date" class="form-control" id="add_dataField" name="add_dataField" value='<?php echo date("Y-m-d"); ?>'>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="add_descricaoField" class="col-md-3 form-label">Descritivo (*)</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="add_descritivoField" name="add_descritivoField">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="add_gerenciaField" class="col-md-3 form-label">Gerência (*)</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="add_gerenciaField" name="add_gerenciaField">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Setor (*)</label>
                            <div class="col-sm-9">
                                <select class="form-select form-select-lg mb-3" id="add_setorField" name="add_setorField">
                                    <option></option>
                                    <?php
                                    // select da tabela de setores
                                    $c_sql_setor = "SELECT setores.id, setores.descricao FROM setores ORDER BY setores.descricao";
                                    $result_setor = $conection->query($c_sql_setor);
                                    while ($c_linha = $result_setor->fetch_assoc()) {
                                        echo "<option>$c_linha[descricao]</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Meta</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" id="add_metaField" name="add_metaField" rows="5"></textarea>
                            </div>
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
                    <h4 class="modal-title" id="exampleModalLabel">Editar Estratégia</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmup" method="POST" action="">
                        <div class="mb-3 row">
                            <label for="up_dataField" class="col-md-3 form-label">Data (*)</label>
                            <div class="col-md-5">
                                <input type="date" class="form-control" id="up_dataField" name="up_dataField">
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="add_descritivoField" class="col-md-3 form-label">Descritivo (*)</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="up_descritivoField" name="up_descritivoField">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="up_gerenciaField" class="col-md-3 form-label">Gerência (*)</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="up_gerenciaField" name="up_gerenciaField">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Setor (*)</label>
                            <div class="col-sm-9">
                                <select class="form-select form-select-lg mb-3" id="up_setorField" name="up_setorField">
                                    <?php
                                    // select da tabela de setores
                                    $c_sql_setor = "SELECT setores.id, setores.descricao FROM setores ORDER BY setores.descricao";
                                    $result_setor = $conection->query($c_sql_setor);
                                    while ($c_linha = $result_setor->fetch_assoc()) {
                                        echo "<option>$c_linha[descricao]</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Meta</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" id="up_metaField" name="up_metaField" rows="5"></textarea>
                            </div>
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