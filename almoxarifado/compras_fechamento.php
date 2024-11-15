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

$hoje = date('Y-m-d');

if (isset($_GET['id'])) {
    $c_id = $_GET['id'];
    $_SESSION['id_compra'] = $c_id;
} else {
    $c_id = $_SESSION['id_compra'];
}
// sql para pegar dados da nota e vencimento
$c_sql2 = "select nota,vencimento from compras where id='$c_id'";
$result = $conection->query($c_sql2);
$registro = $result->fetch_assoc();
$d_vencimento = $registro['vencimento'];
$c_nota = $registro['nota'];

//////////////////////////////////////////////////////////////////////////
// Rotina para fechamento de compra
/////////////////////////////////////////////////////////////////////////

if (isset($_POST['btn_fechar']) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {
    // pega itens a serem gerados
    $c_sql_fechamento = "SELECT compras_materiais.id, materiais.descricao AS material, unidades.descricao AS unidade,
    compras_materiais.quantidade, compras_materiais.valor_unitario, compras_materiais.valor_total,
    compras_materiais.fator_conversao, compras_materiais.receber, compras_materiais.recebido, compras_materiais.id_material
    FROM compras_materiais
    JOIN materiais ON compras_materiais.id_material=materiais.id
    JOIN unidades ON compras_materiais.id_unidade=unidades.id
    WHERE compras_materiais.id_compra='$c_id'
    ORDER BY materiais.descricao";
    $result_lista = $conection->query($c_sql_fechamento);
    //echo $c_sql;
    // loop com itens
    while ($registro = $result_lista->fetch_assoc()) {

        // verifica se está marcado como receber
        if ($registro['receber'] == 'S' && $registro['recebido'] == 'N') {
            // atualizo o saldo do material no cadastro
            $c_sql_up = "UPDATE materiais SET 
                        materiais.quantidadeatual=materiais.quantidadeatual+
                        ($registro[quantidade]*$registro[fator_conversao]), ultimaentrada = '$hoje'
                        WHERE id='$registro[id_material]'";
            $result_up = $conection->query($c_sql_up);
            // atualizo o recebido
            $c_sql_up = "update compras_materiais set recebido='S' where id='$registro[id]'";
            $result_up = $conection->query($c_sql_up);
        }
    }
    // verifico se todos os materiais foram atualizados
   
    $c_sql_conta = "select count(*) as total from compras_materiais 
    where compras_materiais.id_compra='$c_id' and recebido='N'";
    $result_conta = $conection->query($c_sql_conta);
    $registro_conta = $result_conta->fetch_assoc();
    if ($registro_conta['total'] == 0) {  // nenum item sem receber fecho a compra
        $c_sql_fechar = "update compras set status='C' where compras.id='$c_id'";
       
        $result_fechar = $conection->query($c_sql_fechar);
        echo "<script>alert('Operação realizada com sucesso. Pedido Fechado!!')";
    } else
        echo "<script>alert('Operação realizada com sucesso. Pedido NÃO foi fechado pois existem itens a receber!!')</script>";
    
       header('location: /gop/almoxarifado/compras_lista.php');
       
}
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
        <form method="POST" onsubmit="return confirm('Confirma Fechamento da Compra?')">
            <div class="row mb-3">

                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" name="btn_fechar" class="btn btn-primary btn-sm"><span class='glyphicon glyphicon-ok-circle'></span> Finalizar</button>
                    <a class="btn btn-secondary btn-sm" href="/gop/almoxarifado/compras_lista.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
                </div>
            </div>
            <hr>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">No. da Nota</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="nota" value="<?php echo $c_nota; ?>" required>
                </div>
                <label class="col-sm-2 col-form-label">Vencimento</label>
                <div class="col-sm-2">
                    <input type="date" class="form-control" name="vencimento" value="<?php echo $d_vencimento; ?>" required>
                </div>
                <hr>
                <div class="panel panel text-center">
                    <strong>Tabela de Materiais para Entrada</strong>
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
                        <th scope="col">Recebido</th>

                        <th scope="col">Opções</th>

                    </tr>
                </thead>
                <tbody>
                    <?php
                    // faço a Leitura da tabela com sql
                    $c_sql = "SELECT compras_materiais.id, materiais.descricao AS material, unidades.descricao AS unidade,
                compras_materiais.quantidade, compras_materiais.valor_unitario, compras_materiais.valor_total,
                compras_materiais.fator_conversao, compras_materiais.receber, compras_materiais.recebido, compras_materiais.id_material
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
                        if ($c_linha['recebido'] == 'S')
                            $c_recebido = "Sim";
                        else
                            $c_recebido = "Não";

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
                    <td>$c_recebido</td>
                   
                    <td><a class='btn btn-success btn-sm' href='/gop/almoxarifado/compras_selecionar.php?id=$c_linha[id]'><img src='\gop\images\selecionar.png' alt='' width='25' height='25'> Marcar/Desmarcar</a></td></tr>";
                    }
                    ?>


                </tbody>
            </table>

        </form>
    </div>

</body>

</html>