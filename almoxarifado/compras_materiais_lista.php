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
                    'aTargets': [4]
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


    <div class="panel panel-primary class">
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
                    <th scope="col">Valor Unitário</th>
                    <th scope="col">Valor Total</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT compras_materiais.id, materiais.descricao AS material, unidades.descricao AS unidade,
                compras_materiais.quantidade, compras_materiais.valor_unitario, compras_materiais.valor_total
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
                    <td>$c_valor_unitario</td>
                    <td>$c_valor_total</td>

                  
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/almoxarifado/cotacao_materiais_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
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

</html>