<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>

    <script>
        $(document).ready(function() {
            $('.tabcompras').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [12]
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

    <div class="container-fluid">

        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Lista de Pedidos de Compras<h5>
            </div>
        </div>
        <a class="btn btn-secondary btn-sm" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
        <br>
        <hr>
        <table class="table table display table-bordered table-striped table-active tabcompras">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Fornecedor</th>
                    <th scope="col">Data</th>
                    <th scope="col">Tipo da ordem</th>
                    <th scope="col">Tipo</th>
                    <th scope="col">Nota</th>
                    <th scope="col">Cond. de Pag</th>
                    <th scope="col">Vencimento</th>
                    <th scope="col">Comprador</th>
                    <th scope="col">Prazo</th>
                    <th scope="col">Valor Total</th>
                    <th scope="col">Status</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT compras.id, fornecedores.descricao as fornecedor, compras.`data`, compras.tipo,
                case
                when compras.tipo_compra = 'M' then 'Material'
                when compras.tipo_compra = 'S' then 'Serviço'
                END AS compras_tipo,
                case
                when compras.status='A' then 'Aberta'
                when compras.status='C' then 'Concluída'
                END AS compras_status,
                compras.nota, compras.condicoes_pag, compras.vencimento, compras.comprador, compras.prazo,
                compras.valor
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
                    $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data'])));
                    if (!empty($c_linha['vencimento']))
                        $c_vencimento = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['vencimento'])));
                    else
                       $c_vencimento="";
                    if ($c_linha['valor'] > 0)
                        $c_valor = $formatter->formatCurrency($c_linha['valor'], 'BRL');
                    else
                        $c_valor = 'R$ 0,00';
                    $c_prazo = $c_linha['prazo'] . ' dias';
                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[fornecedor]</td>
                    <td>$c_data</td>
                    <td>$c_linha[tipo]</td>
                    <td>$c_linha[compras_tipo]</td>
                    <td>$c_linha[nota]</td>
                    <td>$c_linha[condicoes_pag]</td>
                    <td>$c_vencimento</td>
                    <td>$c_linha[comprador]</td>
                    <td>$c_prazo</td>
                    <td>$c_valor</td>
                    <td>$c_linha[compras_status]</td>
                    <td>
                    <button type='button' class='btn btn-secondary btn-sm editbtn' data-toggle='modal' title='Editar Cotação'><span class='glyphicon glyphicon-pencil'></span> Editar</button>&nbsp;";
                    if ($c_linha['tipo'] == 'M') {
                        echo "<a class='btn btn-info btn-sm' href='/gop/almoxarifado/cotacao_materiais_lista.php?id=$c_linha[id]'><span><img src='\gop\images\servicotecnico.png' alt='16' width='20' height='16'></span> Itens</a>
                        <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>";
                    } else {
                        echo "<a class='btn btn-info btn-sm' href='cotacao_servicos_lista.php?id=$c_linha[id]'><img src='\gop\images\servicotecnico.png' alt='16' width='20' height='16'> Itens</a>
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
</body>

</html>