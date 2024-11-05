<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
$_SESSION['sql'] = "select";

?>




<!doctype html>
<html lang="en">

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/almoxarifado/cotacao_excluir.php?id=" + id;
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
            $('.tabunidades').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [7]
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

    </script>
    <!-- Função javascript e ajax para inclusão dos dados -->
    <script type="text/javascript">
        $(document).on('submit', '#frmadd', function(e) {
            e.preventDefault();
            var c_data = $('#add_data').val();
            var c_descritivo = $('#add_descritivo').val();
            var c_tipo = $('#add_tipo').val();


            if (c_descritivo != '') {

                $.ajax({
                    url: "cotacao_novo.php",
                    type: "post",
                    data: {
                        c_descritivo: c_descritivo,
                        c_data: c_data,
                        c_tipo: c_tipo

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
                $('#up_descritivo').val(data[1]);
                $('#up_tipo').val(data[3]);

            });
        });
    </script>

    <script type="text/javascript">
        ~
        // Função javascript e ajax para Alteração dos dados
        $(document).on('submit', '#frmup', function(e) {
            e.preventDefault();
            var c_id = $('#up_idField').val();
            var c_descritivo = $('#up_descritivo').val();
            var c_tipo = $('#up_tipo').val();


            if (c_descritivo != '') {

                $.ajax({
                    url: "cotacao_editar.php",
                    type: "post",
                    data: {
                        c_id: c_id,
                        c_descritivo: c_descritivo,
                        c_tipo: c_tipo

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

        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Lista de cotaçoes<h5>
            </div>
        </div>
        <br>

        <button type="button" title="Inclusão de Nova Cotação" class="btn btn-success btn-sm" data-toggle="modal" data-target="#novoModal"><span class="glyphicon glyphicon-plus"></span>
            Incluir
        </button>
        <a class="btn btn-secondary btn-sm" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>

        <hr>
        <table class="table table display table-bordered table-striped table-active tabunidades">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Descritivo</th>
                    <th scope="col">Data</th>
                    <th scope="col">Tipo</th>
                    <th scope="col">Responsável</th>
                    <th scope="col">Status</th>
                    <th scope="col">Encerramento</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT cotacao.id, cotacao.tipo, cotacao.descritivo, cotacao.`data`,
                usuarios.nome AS responsavel, cotacao.`status`, cotacao.data_encerramento,
                        case
                        when cotacao.status='A' then 'Aberta'
                        when cotacao.status='C' then 'Concluída'
                        END AS cotacao_status,
                        case
                        when cotacao.tipo = 'M' then 'Material'
                        when cotacao.tipo = 'S' then 'Serviço'
                        END AS cotacao_tipo
                        FROM cotacao
                        JOIN usuarios ON  cotacao.id_responsavel=usuarios.id
                        ORDER BY cotacao.`data` desc";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data'])));
                    if (!empty($c_linha['data_encerramento']))
                        $c_encerramento = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_encerramento'])));
                    else
                        $c_encerramento = "-";
                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[descritivo]</td>
                    <td>$c_data</td>
                    <td>$c_linha[cotacao_tipo]</td>
                    <td>$c_linha[responsavel]</td>
                    <td>$c_linha[cotacao_status]</td>
                    <td>$c_encerramento</td>
                    <td>
                    <button type='button' class='btn btn-secondary btn-sm editbtn' data-toggle='modal' title='Editar Cotação'><span class='glyphicon glyphicon-pencil'></span> Editar</button>&nbsp;";
                    if ($c_linha['tipo'] == 'M') {
                        echo "<a class='btn btn-info btn-sm' href='/gop/almoxarifado/cotacao_materiais_lista.php?id=$c_linha[id]'><span><img src='\gop\images\servicotecnico.png' alt='16' width='20' height='16'></span> Itens</a>
                         <a class='btn btn-success btn-sm' href='/gop/almoxarifado/cotacao_fornecedores.php?id=$c_linha[id]'><img src='\gop\images\ga.png' alt='16' width='20' height='16'> Fornecedores</a>
                     <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>";
                    } else {
                        echo "<a class='btn btn-info btn-sm' href='cotacao_servicos_lista.php?id=$c_linha[id]'><img src='\gop\images\servicotecnico.png' alt='16' width='20' height='16'> Itens</a>
                     <a class='btn btn-success btn-sm' href='/gop/almoxarifado/cotacao_fornecedores.php?id=$c_linha[id]'><img src='\gop\images\ga.png' alt='16' width='20' height='16'> Fornecedores</a>
                     <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>";
                    }
                    "</td>

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
                    <h4 class="modal-title" id="exampleModalLabel">Inclusão de nova Cotação</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmadd" action="">
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Tipo Cotação</label>
                            <div class="col-sm-4">
                                <select class="form-select form-select-lg mb-3" id="add_tipo" name="add_tipo">
                                    <option value='M'>Material</option>
                                    <option value='S'>Serviço</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-md-2 form-label">Data (*)</label>
                            <div class="col-sm-4">
                                <input type="Date" class="form-control" name="add_data" id="add_data" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-md-2 form-label">Descritivo (*)</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="add_descritivo" id="add_descritivo" required>
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
                    <h4 class="modal-title" id="exampleModalLabel">Editar Cotação</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmup" method="POST" action="">
                        <input type="hidden" id="up_idField" name="up_idField">
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Tipo Cotação</label>
                            <div class="col-sm-4">
                                <select class="form-select form-select-lg mb-3" id="up_tipo" name="up_tipo">
                                    <option>Material</option>
                                    <option>Serviço</option>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-md-2 form-label">Descritivo (*)</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="up_descritivo" id="up_descritivo">
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