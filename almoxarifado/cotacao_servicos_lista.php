<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");

if (isset($_GET['id'])) {
    $i_id = $_GET['id'];
    $_SESSION['id_cotacao'] = $i_id;
} else {
    $i_id = $_SESSION['id_cotacao'];
}
// dados da cotação
$c_sql_cotacao = "select * from cotacao where cotacao.id = $i_id";
$result_cotacao = $conection->query("$c_sql_cotacao");
$c_linha_cotacao = $result_cotacao->fetch_assoc();

?>
<!doctype html>
<html lang="en">

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/almoxarifado/cotacao_servicos_excluir.php?id=" + id;
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
            $('.tabmateriais').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [2]
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
            var c_descritivo = $('#add_descritivo').val();

            if (c_descritivo != '') {

                $.ajax({
                    url: "cotacao_servicos_novo.php",
                    type: "post",
                    data: {
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

            if (c_descritivo != '') {

                $.ajax({
                    url: "cotacao_servicos_editar.php",
                    type: "post",
                    data: {
                        c_id: c_id,
                        c_descritivo: c_descritivo
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
            <h5>Lista de Serviços para Cotação<h5>
        </div>
    </div>
    <br>
    <div class="container-fluid">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>

            <h5>Serviços para a Cotação No. <?php echo $i_id . ' - ' . $c_linha_cotacao['descritivo'] ?> </h5>
        </div>

        <button type="button" title="Inclusão de Nova Cotação" class="btn btn-success btn-sm" data-toggle="modal" data-target="#novoModal"><span class="glyphicon glyphicon-plus"></span>
            Incluir
        </button>
        
        <a class="btn btn-secondary btn-sm" href="/gop/almoxarifado/cotacao_lista.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>

        <hr>
        <table class="table table display table-bordered tabmateriais">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Descrição do Serviço</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT cotacao_servicos.id, cotacao_servicos.descricao 
                FROM cotacao_servicos
                WHERE cotacao_servicos.id_cotacao='$i_id'
                ORDER BY cotacao_servicos.descricao";
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
                    <button type='button' class='btn btn-secondary btn-sm editbtn' data-toggle='modal' title='Editar Serviço'><span class='glyphicon glyphicon-pencil'></span> Editar</button>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>

                    </tr>
                    ";
                }
                ?>

                <!-- janela Modal para inclusão de registro -->
                <div class="modal fade" class="modal-dialog modal-lg" id="novoModal" name="novoModal" tabindex="-1" role="dialog" aria-labelledby="novoModal" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" id="exampleModalLabel">Inclusão de Serviço para Cotação</h4>
                            </div>
                            <div class="modal-body">
                                <div class='alert alert-warning' role='alert'>
                                    <h5>Campos com (*) são obrigatórios</h5>
                                </div>
                                <form id="frmadd" action="">

                                    <div class="row mb-3">
                                        <label class="col-sm-2 col-form-label">Descrição</label>
                                        <div class="col-sm-10">
                                            <textarea class="form-control" id="add_descritivo" name="add_descritivo" rows="6"></textarea>
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
                                        <label class="col-sm-2 col-form-label">Descrição</label>
                                        <div class="col-sm-10">
                                            <textarea class="form-control" id="up_descritivo" name="up_descritivo" rows="6"></textarea>
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

            </tbody>
        </table>
    </div>


</body>

</html>