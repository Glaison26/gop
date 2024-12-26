<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
// verifico se usuário e operador de tem autorização de acesso
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.almoxarifado_pedidodecompra FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";
$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['almoxarifado_pedidodecompra'] == 'N') {
    header('location: /gop/acesso.php');
}

?>

<!DOCTYPE html>
<html lang="en">

<body>

    <script>
        $(document).ready(function() {
            $('.tabcompras').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [9]
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

    <div class="container-fluid">

        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Lista de Pedidos de Compras</h5>
            </div>
        </div>
        <a class="btn btn-secondary btn-sm" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
        <hr>
        <table class="table table display table-bordered table-striped table-active tabcompras">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Fornecedor</th>
                    <th scope="col">Descritivo</th>
                    <th scope="col">Data</th>
                    <th scope="col">Tipo da ordem</th>
                    <th scope="col">Tipo</th>

                    <th scope="col">Frete</th>
                    <th scope="col">Valor Total</th>
                    <th scope="col">Status</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT compras.id, fornecedores.descricao as fornecedor, compras.`data`, compras.tipo, compras.descritivo,
                case
                when compras.tipo_compra = 'M' then 'Material'
                when compras.tipo_compra = 'S' then 'Serviço'
                END AS compras_tipo,
                case
                when compras.status='A' then 'Aberta'
                when compras.status='C' then 'Concluída'
                END AS compras_status,
                compras.nota, compras.condicoes_pag, compras.vencimento, compras.comprador, compras.prazo,
                compras.valor, compras.valor_frete
                FROM compras
                JOIN fornecedores ON compras.id_fornecedor=fornecedores.id
                ORDER BY compras.`data` desc";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                $formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
                while ($c_linha = $result->fetch_assoc()) {
                    // formatação de variáveis
                    $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data'])));
                    if (!empty($c_linha['vencimento']))
                        $c_vencimento = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['vencimento'])));
                    else
                        $c_vencimento = "";
                    if ($c_linha['valor'] > 0)
                        $c_valor = $formatter->formatCurrency($c_linha['valor'], 'BRL');
                    else
                        $c_valor = 'R$ 0,00';
                    if ($c_linha['valor_frete'] > 0)
                        $c_frete = $formatter->formatCurrency($c_linha['valor_frete'], 'BRL');
                    else
                        $c_frete = 'R$ 0,00';
                    $c_prazo = $c_linha['prazo'] . ' dias';
                    // montagem da tabela
                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[fornecedor]</td>
                    <td>$c_linha[descritivo]</td>
                    <td>$c_data</td>
                    <td>$c_linha[tipo]</td>
                    <td>$c_linha[compras_tipo]</td>
                  
                    <td>$c_frete</td>  
                    <td>$c_valor</td>
                    <td>$c_linha[compras_status]</td>
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/almoxarifado/compras_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>&nbsp;";
                    echo "<a class='btn btn-primary btn-sm' href='/gop/almoxarifado/compras_emissao.php?id=$c_linha[id]' target='_blank'><span class='glyphicon glyphicon-print'></span> Emitir Pedido</a>&nbsp;";
                    if ($c_linha['compras_status'] == 'Aberta')
                        echo "<a class='btn btn-success btn-sm' href='/gop/almoxarifado/compras_fechamento.php?id=$c_linha[id]'><span class='glyphicon glyphicon-check'></span> Fechamento</a>&nbsp;";

                    if ($c_linha['compras_tipo'] == 'Material') {
                        echo "<a class='btn btn-info btn-sm' href='/gop/almoxarifado/compras_materiais_lista.php?id=$c_linha[id]'><span><img src='\gop\images\servicotecnico.png' alt='16' width='20' height='16'></span> Itens</a>
                        <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>";
                    } else {
                        echo "<a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>";
                    }
                    "</td>

                    </tr>
                    ";
                }
                ?>
            </tbody>
        </table>

    </div>
</body>

</html>