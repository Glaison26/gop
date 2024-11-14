<?php
/////////////////////////////////////////////////
// Arquivo para fechamento de um pedido de Compra
/////////////////////////////////////////////////
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");

if (isset($_GET['id'])) {
    $c_id = $_GET['id'];
    $_SESSION['id_compra'] = $c_id;
} else {
    $c_id = $_SESSION['id_compra'];
}
// sql para pegar dados da nota e vencimento
$c_sql = "select nota,vencimento from compras where id='$c_id'";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
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

<body>
    <div class="container  -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Fechamento de Pedido de Compra<h5>
                </div>
            </div>

        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Entre com as informações necessárias e clique no botão concluir. Você pode escolher os itens que serão recebido na tabela.</h5>
        </div>
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <h4>$msg_erro</h4>
            </div>
                ";
        }
        ?>
        <div class="row mb-3">
            <div class="offset-sm-0 col-sm-3">
                <a class="btn btn-secondary btn-sm" href="/gop/almoxarifado/compras_lista.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
            </div>
        </div>
        <hr>
        <form>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">No. da Nota</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="nota" value="<?php echo $registro['nota']; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Vencimento</label>
                <div class="col-sm-2">
                    <input type="date" class="form-control" name="vencimento" value="<?php echo $registro['vencimento']; ?>">
                </div>
                <hr>
                <div class="panel panel-default">
                    <div class="panel-heading text-center"><strong>Tabela de Materiais para Entrada</strong></div>
                </div>

            </div>
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
                        <th scope="col">Receber</th>
                        <th scope="col">Opções</th>

                    </tr>
                </thead>
                <tbody>
                    <?php
                    // faço a Leitura da tabela com sql
                    $c_sql = "SELECT compras_materiais.id, materiais.descricao AS material, unidades.descricao AS unidade,
                compras_materiais.quantidade, compras_materiais.valor_unitario, compras_materiais.valor_total,
                compras_materiais.fator_conversao, compras_materiais.receber
                FROM compras_materiais
                JOIN materiais ON compras_materiais.id_material=materiais.id
                JOIN unidades ON compras_materiais.id_unidade=unidades.id
                WHERE compras_materiais.id_compra='$c_id'
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
                        if ($c_linha['receber'] == 'S')
                            $c_receber = "Sim";
                        else
                            $c_receber = "Não";

                        echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[material]</td>
                    <td>$c_linha[quantidade]</td>
                    <td>$c_linha[unidade]</td>
                     <td>$c_linha[fator_conversao]</td>
                    <td>$c_valor_unitario</td>
                    <td>$c_valor_total</td>
                    <td>$c_receber</td>
                   
                    <td><a class='btn btn-success btn-sm' href='/gop/almoxarifado/compras_selecionar.php?id=$c_linha[id]'><img src='\gop\images\selecionar.png' alt='' width='25' height='25'> Marcar/Desmarcar</a></td></tr>";
                    }
                    ?>


                </tbody>
            </table>

        </form>
    </div>

</body>

</html>