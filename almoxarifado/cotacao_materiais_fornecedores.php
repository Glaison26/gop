<?php

use LDAP\Result;

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");

if (isset($_GET['id'])) {
    $i_id_cotacao = $_GET['id'];
    $_SESSION['id_cotacao'] = $i_id_cotacao;
} else {
    $i_id_cotacao = $_SESSION['id_cotacao'];
}
$c_sql = "Select * from cotacao where id='$i_id_cotacao'";
$result = $conection->query($c_sql);
$c_linha_cotacao= $result->fetch_assoc();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/almoxarifado/cotacao_material_excluir.php?id=" + id;
            }
        }
    </script>

    <script>
        $(document).ready(function() {
            $('.tabfornecedores').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [4]
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
                <h5>Lista de Fornecedores para Cotação<h5>
            </div>
        </div>

        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>

            <h4>Fornecedores participantes para a Cotação No. <?php echo $i_id_cotacao . ' - ' . $c_linha_cotacao['descritivo'];  ?> </h4>
        </div>
        <a class="btn btn-success btn-sm" href="/gop/almoxarifado/cotacao_materiais_fornecedores_novo.php"><span class="glyphicon glyphicon-plus"></span>Incluir</a>
        <a class="btn btn-secondary btn-sm" href="/gop/almoxarifado/cotacao_lista.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
        <hr>
        <table class="table table display table-bordered tabfornecedores">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Fornecedor</th>
                    <th scope="col">Vendedor</th>
                    <th scope="col">Valor Total Cotado</th>
                    <th scope="col">Valor Frete</th>
                    <th scope="col">Status</th>
                    <th scope="col">Prazo em dias</th>
                    <th scope="col">Forma de Pagamento</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT cotacao_fornecedor.id, fornecedores.descricao AS fornecedor, cotacao_fornecedor.valor_total,
                cotacao_fornecedor.frete, cotacao_fornecedor.prazo, forma_pagamento, cotacao_fornecedor.vendedor,
                case when status='P' then 'Participante' when status='V' then 'Vencedor' END AS status_texto
                FROM cotacao_fornecedor
                JOIN fornecedores ON cotacao_fornecedor.id_fornecedor=fornecedores.id
                WHERE cotacao_fornecedor.id_cotacao='$i_id_cotacao'
                ORDER BY fornecedores.descricao";

                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }
                // insiro os registro do banco de dados na tabela 
                $formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
                while ($c_linha = $result->fetch_assoc()) {
                    if ($c_linha['valor_total'] > 0)
                     $c_valor = $formatter->formatCurrency($c_linha['valor_total'], 'BRL');
                    else 
                      $c_valor = 'R$ 0,00';
                    if ($c_linha['frete'] > 0)
                     $c_frete = $formatter->formatCurrency($c_linha['frete'], 'BRL');
                    else 
                      $c_frete = 'R$ 0,00';
                    $c_prazo = $c_linha['prazo'] . ' dias';
                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[fornecedor]</td>
                    <td>$c_linha[vendedor]</td>
                    <td style='text-align: right;'>$c_valor</td>
                    <td style='text-align: right;'>$c_frete</td>
                    <td>$c_linha[status_texto]</td>
                    <td>$c_prazo</td>
                    <td>$c_linha[forma_pagamento]</td>
                  
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/almoxarifado/cotacao_materiais_fornecedores_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                    <a class='btn btn-success btn-sm' href='/gop/almoxarifado/cotacao_material.php?id=$c_linha[id]'><img src='\gop\images\omadaprecos.png' alt='17' width='25' height='17'> Cotações</a>
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