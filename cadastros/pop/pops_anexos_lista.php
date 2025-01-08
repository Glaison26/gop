<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
include("../../links.php");
// verifico se usuário e operador de tem autorização de acesso
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.cadastros_pop FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";
$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['cadastros_pop'] == 'N') { // acesso não permitido
    header('location: /gop/acesso.php');
}
// captura a id do pop selecionado na página anterior

if (isset($_GET['id'])) {
    $id_pop = $_GET['id'];
    $_SESSION['id_pop_s'] = $id_pop;
} else {
    $id_pop = $_SESSION['id_pop_s'];
}
// sql para buscar descrição do POP
$c_sql_pop = "Select id, descricao from pops where id='$id_pop'";
$result_pop = $conection->query($c_sql_pop);
$registro_pop = $result_pop->fetch_assoc();

date_default_timezone_set('America/Sao_Paulo');

if ((isset($_POST["btnarquivo"])) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {  // botão para incluir imagem
    $dir = "anexos/";
    $arquivo = $_FILES['arquivo'];
    $_SESSION['c_nomearquivo'] = $_FILES['arquivo']['name'];

    $c_nomearquivo = $arquivo["name"];
    if (!empty($c_nomearquivo)) {
        move_uploaded_file($arquivo["tmp_name"], "$dir/" . $arquivo["name"]);
        //echo $c_nomefoto;
        // incluir registro da arquivo no banco de dados
        $c_pasta = $dir . $c_nomearquivo;

        $d_data = date('Y-m-d');
        $c_sql = "insert into pop_anexos (id_pop, path, data) value ('$id_pop', '$c_pasta', '$d_data')";
        $result = $conection->query($c_sql);
    }
}

?>
<!doctype html>
<html lang="en">


<body>
    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/cadastros/pop/pops_anexos_excluir.php?id=" + id;
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
            $('.tabpops').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [5]
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


    <!--  script javascript Coleta dados da tabela para edição do registro -->
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
                $('#up_resposavelField').val(data[4]);

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
            var c_responsavel = $('#up_resposavelField').val();

            if (c_descricao != '') {

                $.ajax({
                    url: "pops_anexos_editar.php",
                    type: "post",
                    data: {
                        c_id: c_id,
                        c_descricao: c_descricao,
                        c_responsavel: c_responsavel
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
                alert('Campo Descrição deve ser preenchido!!');
            }
        });
    </script>



    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Lista de Anexo(s) ao POP<h5>
        </div>
    </div>
    <br>

    <div class="container-fluid">

        <form method="post" enctype="multipart/form-data">
        <a class="btn btn-secondary btn-sm" href="/gop/cadastros/pop/pops_lista.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
        <hr>
            <div class='panel panel-Light'>
                <div class='panel panel-info class'>
                    <div class='panel-heading'>
                        <button type='submit' name='btnarquivo' id='btnarquivo' class='btn btn-Ligth'><img src='\gop\images\pasta.png'
                                alt='' width='20' height='20'> Carregar Anexo</button>

                        <hr>
                        <input type='file' name='arquivo' class='form-control-file' id='arquivo' accept='image/*,.pdf'>
                    </div>

                </div>

            </div>
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
                </div>
                <h5><strong>Descrição do POP : <?php echo $registro_pop['descricao'] ?></strong></h5>
            </div>

            <table class="table table display table-bordered tabpops">
                <thead class="thead">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Descrição</th>
                        <th scope="col">Arquivo</th>
                        <th scope="col">Data</th>
                        <th scope="col">Responsável</th>
                        <th scope="col">Opções</th>
                    </tr>
                </thead>
                <tbody>
                    <?php

                    // faço a Leitura da tabela com sql
                    $c_sql = "SELECT * from pop_anexos where id_pop='$id_pop'";
                    $result = $conection->query($c_sql);
                    // verifico se a query foi correto
                    if (!$result) {
                        die("Erro ao Executar Sql!!" . $conection->connect_error);
                    }

                    // insiro os registro do banco de dados na tabela 
                    while ($c_linha = $result->fetch_assoc()) {
                        $c_data =  new DateTime($c_linha['data']);
                        $c_data = $c_data->format('d-m-Y');
                        echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[descricao]</td>
                    <td>$c_linha[path]</td>
                    <td>$c_data</td>
                    <td>$c_linha[responsavel]</td>
                    
                   
                    <td>
                    <button type='button' class='btn btn-secondary btn-sm editbtn' data-toggle='modal' title='Editar Marcas'><span class='glyphicon glyphicon-pencil'></span> Editar</button>
                    <a class='btn btn-primary btn-sm' href='/gop/cadastros/pop/pops_baixar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-download-alt'></span> download</a>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>

                    </tr>
                    ";
                    }
                    ?>
                </tbody>
            </table>
        </form>
    </div>


    <!-- Modal para edição dos dados -->
    <div class="modal fade" id="editmodal" tabindex="-1" role="dialog" aria-labelledby="editmodal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">Editar Dados do Anexo ao POP</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Preeencha os campos abaixo</h5>
                    </div>
                    <form id="frmup" method="POST" action="">
                        <input type="hidden" id="up_idField" name="up_idField">
                        <div class="mb-3 row">
                            <label for="up_descricaoField" class="col-md-3 form-label">Descrição</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="up_descricaoField" name="up_descricaoField">
                            </div>
                        </div>
                        <div class="mb-3 row">
                        <label for="up_responsavelField" class="col-md-3 form-label">Responsável</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="up_resposavelField" name="up_responsavelField">
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