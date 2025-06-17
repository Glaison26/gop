<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
include("../../conexao.php");
include("../../links2.php");

// verifico se usuário e operador de tem autorização de acesso
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.cadastros_executores FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";
// id do contrato
$c_id = $_GET["id"];
$_SESSION['id_contrato'] = $c_id;

$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
// pego o contrato selecionado via sql
$c_sql_contrato = "SELECT contratos.id, contratos.empresa, contratos.numero_contrato FROM contratos where id=$c_id";
$resul_contrato = $conection->query($c_sql_contrato);
$registro_contrato = $resul_contrato->fetch_assoc();
//if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['cadastros_executores'] == 'N') {

//    header('location: /gop/acesso.php');
//}
?>
<!doctype html>
<html lang="en">

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/cadastros/contratos/parametros_excluir.php?id=" + id;
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
            $('.tabcontratos').DataTable({
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
            var c_unidade = $('#add_unidadeField').val();

            if (c_descricao != '') {

                $.ajax({
                    url: "parametros_novo.php",
                    type: "post",
                    data: {
                        c_descricao: c_descricao,
                        c_unidade: c_unidade

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
                $('#up_unidadeField').val(data[2]);

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
            var c_unidade = $('#up_unidadeField').val();
           
            if (c_descricao != '') {

                $.ajax({
                    url: "parametros_editar.php",
                    type: "post",
                    data: {
                        c_id: c_id,
                        c_descricao: c_descricao,
                        c_unidade: c_unidade
                     
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
            <h5>Lista de Parametros do Contrato<h5>
        </div>
    </div>


    <div class="container-fluid">
        <br>
        <button type="button" title="Inclusão de Nova Marca" class="btn btn-success btn-sm" data-toggle="modal" data-target="#novoModal"><span class="glyphicon glyphicon-plus"></span>
            Incluir
        </button>

        <a class="btn btn-secondary btn-sm" href="/gop/cadastros/contratos/contratos_lista.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
        <hr>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Parâmetros do Contrato : <?php echo $registro_contrato['empresa'] . '  -  ' . 'Contrato Número :' . ' ' . $registro_contrato['numero_contrato'] ?></h5>
        </div>
        <hr>
        <table class="table display table-bordered tabcontratos">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Unidade</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT contratos_parametros.id, contratos_parametros.descricao, contratos_parametros.unidade FROM contratos_parametros
                WHERE contratos_parametros.id_contrato=$c_id
                ORDER BY contratos_parametros.descricao";
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
                    <td>$c_linha[unidade]</td>
                    <td>
                    <a class='btn btn-primary btn-sm' href='/gop/cadastros/contratos/parametros.php?id=$c_linha[id]'><span class='glyphicon glyphicon-list-alt'></span> Lançamentos</a>
                    <button type='button' class='btn btn-secondary btn-sm editbtn' data-toggle='modal' title='Editar Parâmetro'><span class='glyphicon glyphicon-pencil'></span> Editar</button>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>

                    </tr>
                    ";
                }
                ?>
            </tbody>
        </table>
    </div>

    <!--  Formulários para janela modal de inclusão e edição -->
    <!-- janela Modal para inclusão de registro -->
    <div class="modal fade" class="modal-dialog modal-lg" id="novoModal" name="novoModal" tabindex="-1" role="dialog" aria-labelledby="novoModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">Inclusão de novo Parâmetro</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmadd" action="">
                        <div class="mb-3 row">
                            <label for="add_descricaoField" class="col-md-3 form-label">Descrição (*)</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="add_descricaoField" name="add_descricaoField" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Unidade</label>
                            <div class="col-sm-6">
                                <select class="form-select form-select-lg mb-3" id="up_unidadeField" name="up_unidadeField">
                                    <?php
                                    // select da tabela de unidades
                                    $c_sql_unidades = "SELECT unidades.id, unidades.descricao FROM unidades ORDER BY unidades.descricao";
                                    $result_unidades = $conection->query($c_sql_unidades);
                                    while ($c_linha = $result_unidades->fetch_assoc()) {
                                        echo "  
                          <option>$c_linha[descricao]</option>
                        ";
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
                    <h4 class="modal-title" id="exampleModalLabel">Editar Parâmetro de Contrato</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmup" method="POST" action="">
                        <input type="hidden" id="up_idField" name="up_idField">
                        <div class="mb-3 row">
                            <label for="up_descricaoField" class="col-md-3 form-label">Descrição (*)</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="up_descricaoField" name="up_dscricaoField" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Unidade</label>
                            <div class="col-sm-6">
                                <select class="form-select form-select-lg mb-3" id="add_unidadeField" name="add_unidadeField">
                                    <?php
                                    // select da tabela de unidades
                                    $c_sql_unidades = "SELECT unidades.id, unidades.descricao FROM unidades ORDER BY unidades.descricao";
                                    $result_unidades = $conection->query($c_sql_unidades);
                                    while ($c_linha2 = $result_unidades->fetch_assoc()) {
                                        $op ='';
                                        if ($c_linha2['unidade']=$c_linha[''])
                                          $op='selected';
                                        echo "  
                          <option $op>$c_linha2[descricao]</option>
                        ";
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


</body>

</html>