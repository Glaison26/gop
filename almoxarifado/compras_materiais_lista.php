<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");


if (isset($_GET['id'])) {
    $i_id = $_GET['id'];
    $_SESSION['id_compra'] = $i_id;
} else {
    $i_id = $_SESSION['id_compra'];
}
// dados da compra
$c_sql_compra = "select * from compras where compras.id = $i_id";
$result_compra = $conection->query("$c_sql_compra");
$c_linha_compra = $result_compra->fetch_assoc();


?>
<!doctype html>
<html lang="en">

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/almoxarifado/cotacao_material_excluir.php?id=" + id;
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
                $('#up_fator').val(data[4]);

            });
        });
    </script>

    <script type="text/javascript">
        // Função javascript e ajax para Alteração dos dados
        $(document).on('submit', '#frmup', function(e) {
            e.preventDefault();
            var c_id = $('#up_idField').val();
            var c_fator = $('#up_fator').val();
           
            if (c_fator != '') {

                $.ajax({
                    url: "compras_material_editar.php",
                    type: "post",
                    data: {
                        c_id: c_id,
                        c_fator: c_fator
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

    <div class="panel panel-primary class ">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Lista de Materiais para Pedido de Compra<h5>
        </div>
    </div>
    <br>
    <div class="container-fluid">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>

            <h5>Materiais para a Compra No. <?php echo $c_linha_compra['id']  ?> </h5>
        </div>

        <a class="btn btn-secondary btn-sm" href="/gop/almoxarifado/compras_lista.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>

        <hr>
        <table class="table table display table-bordered tabmateriais">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Material</th>
                    <th scope="col">Quantidade</th>
                    <th scope="col">Unidade</th>
                    <th scope="col">Fator</th>
                    <th scope="col">Valor Unitário</th>
                    <th scope="col">Valor Total</th>
                    <th scope="col">Opções</th>

                </tr>
            </thead>
            <tbody>
                <?php
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT compras_materiais.id, materiais.descricao AS material, unidades.descricao AS unidade,
                compras_materiais.quantidade, compras_materiais.valor_unitario, compras_materiais.valor_total, compras_materiais.fator_conversao
                FROM compras_materiais
                JOIN materiais ON compras_materiais.id_material=materiais.id
                JOIN unidades ON compras_materiais.id_unidade=unidades.id
                WHERE compras_materiais.id_compra='$i_id'
                ORDER BY materiais.descricao";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }
                // insiro os registro do banco de dados na tabela 
                $formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
                while ($c_linha = $result->fetch_assoc()) {

                    if ($c_linha['valor_unitario'] > 0)
                        $c_valor_unitario = $formatter->formatCurrency($c_linha['valor_unitario'], 'BRL');
                    else
                        $c_valor_unitario = 'R$ 0,00';
                    if ($c_linha['valor_total'] > 0)
                        $c_valor_total = $formatter->formatCurrency($c_linha['valor_total'], 'BRL');
                    else
                        $c_valor_total = 'R$ 0,00';

                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[material]</td>
                    <td>$c_linha[quantidade]</td>
                    <td>$c_linha[unidade]</td>
                     <td>$c_linha[fator_conversao]</td>
                    <td>$c_valor_unitario</td>
                    <td>$c_valor_total</td>
                   
                    <td><button type='button' class='btn btn-secondary btn-sm editbtn' data-toggle='modal' title='Editar Fator'>
                    <span class='glyphicon glyphicon-pencil'></span> Editar Fator</button></td></tr>";
                }
                ?>


            </tbody>
        </table>
    </div>
    
    <!-- Modal para edição dos dados -->
    <div class="modal fade" id="editmodal" tabindex="-1" role="dialog" aria-labelledby="editmodal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">Editar Fator de Conversão do Material</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Altere o valor do fator para conversão de entrada do Item</h5>
                    </div>
                    <form id="frmup" method="POST" action="">
                        <input type="hidden" id="up_idField" name="up_idField">

                        <div class="mb-4 row">
                            <label for="up_fator" class="col-md-5 form-label">Fator de Conversao</label>
                            <div class="col-md-3">
                                <input type="number" class="form-control" id="up_fator" name="up_fator" required>
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
    <

        </body>

</html>