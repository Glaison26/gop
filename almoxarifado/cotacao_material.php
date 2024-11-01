<?php
////////////////////////////////////////////////////////////
// rotina verifica se os itens foram anexados ao fornecedor.
// se não inclui os itens já inclui a cotação por fornecedor
////////////////////////////////////////////////////////////
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");

if (isset($_GET['id'])) {
    $i_id = $_GET['id'];
    $_SESSION['id_material_fornecedor'] = $i_id;
} else {
    $i_id = $_SESSION['id_material_fornecedor'];
}
// sql para captura id do fornecedor
$c_sql_fornec = "select id_fornecedor from cotacao_fornecedor where id='$i_id '";
$result_fornec = $conection->query($c_sql_fornec);
$c_linha_fornec = $result_fornec->fetch_assoc();
$i_id_fornecedor = $c_linha_fornec['id_fornecedor'];
$_SESSION['id_fornecedor'] = $i_id_fornecedor;
// verifico se já existem dados para o fornecedor 
$c_sql_conta = "SELECT COUNT(*) AS registros FROM cotacao_materiais_fornecedor where id_cotacao_fornecedor=' $i_id' and id_fornecedor='$i_id_fornecedor'";
$result_conta = $conection->query($c_sql_conta);
$c_linha = $result_conta->fetch_assoc();
//
$i_id_cotacao = $_SESSION['id_cotacao'];
// pego fornecedor
$c_sql_fornecdor = "select fornecedores.id, fornecedores.descricao from fornecedores where id = '$i_id_fornecedor'";
$result_fornec = $conection->query($c_sql_fornecdor);
$c_linha_fornec = $result_fornec->fetch_assoc();
$c_fornecedor = $c_linha_fornec['descricao'];

// rotina para atualização de itens caso seja colocado item novo
if (isset($_POST['btnincluir'])) {

    $c_sql2 = "SELECT cotacao_materiais.id, cotacao_materiais.id_material, cotacao_materiais.id_unidade,
    cotacao_materiais.quantidade
    FROM cotacao_materiais
    WHERE cotacao_materiais.id_cotacao='$i_id_cotacao'";
    $result2 = $conection->query($c_sql2);
    // loop para verificar se exite item novo
    while ($c_linha2 = $result2->fetch_assoc()) {
        // procuro material na tabela de material por fornecedor
        $i_id_material = $c_linha2['id_material'];
        $c_sql3 = "select count(*) as registro_material from cotacao_materiais_fornecedor 
        where id_cotacao_fornecedor = '$i_id' and id_material='$i_id_material'";
        $result3 = $conection->query($c_sql3);
        $c_linha3 = $result3->fetch_assoc();

        // não achou material inclui no cadastro
        if ($c_linha3['registro_material'] == 0) {
            $i_id_material = $c_linha2['id_material'];
            $n_quantidade = $c_linha2['quantidade'];
            // insiro registro com os dados dos materiais selecionados
            $c_sql_add = "Insert into cotacao_materiais_fornecedor (id_cotacao_fornecedor,id_fornecedor, id_material, quantidade) 
        values ('$i_id', '$i_id_fornecedor', '$i_id_material', $n_quantidade)";
            $result_add = $conection->query($c_sql_add);
            // verifico se a query foi correto
            if (!$result_add) {
                die("Erro ao Executar Sql!!" . $conection->connect_error);
            }
        }
    }
}
// checo se existem registros
if ($c_linha['registros'] == 0) {

    // monto sql para pegar os materias incluido para cotação
    $c_sql = "SELECT cotacao_materiais.id, cotacao_materiais.id_material, cotacao_materiais.id_unidade,
                     cotacao_materiais.quantidade
                     FROM cotacao_materiais
                     WHERE cotacao_materiais.id_cotacao='$i_id_cotacao'";
    $result = $conection->query($c_sql);
    // echo $c_sql;
    // verifico se a query foi correto
    if (!$result) {
        die("Erro ao Executar Sql!!" . $conection->connect_error);
    }
    // loop para inclusão dos materias nata tabea de cotação X materiais
    while ($c_linha = $result->fetch_assoc()) {
        $i_id_material = $c_linha['id_material'];
        $n_quantidade = $c_linha['quantidade'];
        // insiro registro com os dados dos materiais selecionados
        $c_sql_add = "Insert into cotacao_materiais_fornecedor (id_cotacao_fornecedor,id_fornecedor, id_material, quantidade) 
        values ('$i_id', '$i_id_fornecedor', '$i_id_material', $n_quantidade)";
        $result_add = $conection->query($c_sql_add);
        // verifico se a query foi correto
        if (!$result_add) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
    }
} else {
    // faço somatorio dos valores e edito na tabela do fornecedor da cotação
    $c_sql_soma = "SELECT SUM(cotacao_materiais_fornecedor.valor_total) AS total FROM cotacao_materiais_fornecedor
    where id_cotacao_fornecedor=' $i_id' and id_fornecedor='$i_id_fornecedor'";
    //echo $c_sql_soma;
    $result_soma = $conection->query($c_sql_soma);
    $c_linha_soma = $result_soma->fetch_assoc();
    $n_soma = $c_linha_soma['total'];
    // edito valor de soma no registro do fornecedor
    if ($n_soma > 0) {
        $c_sql_up = "update cotacao_fornecedor set valor_total='$n_soma' where id_cotacao=$i_id_cotacao
                    and id_fornecedor =$i_id_fornecedor";
        //echo $c_sql_up;
        $result_up = $conection->query($c_sql_up);
    }
}
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
                window.location.href = "/gop/almoxarifado/cotacao_material_fornecedores_excluir.php?id=" + id;
            }
        }
    </script>

    <script>
        $(document).ready(function() {
            $('.tabcotacao').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [6]
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
                $('#up_qtd').val(data[3]);

                $('#up_valor_unitario').val(data[4].replace('R$', '').replace(',', '.').replace(/^\s+|\s+$/g, ''));
                $('#up_prazo').val(data[2].getFullYear() + "-" + ((data[2].getMonth() + 1)) + "-" +
                    (data[2].getDate()));
            });
        });
    </script>

    <script type="text/javascript">
        // Função javascript e ajax para Alteração dos dados
        $(document).on('submit', '#frmup', function(e) {
            e.preventDefault();
            var c_id = $('#up_idField').val();
            var c_valor_unitario = $('#up_valor_unitario').val();
            var c_prazo = $('#up_prazo').val();
            var c_qtd = $('#up_qtd').val();

            if (c_valor_unitario != '') {

                $.ajax({
                    url: "cotacao_material_editar.php",
                    type: "post",
                    data: {
                        c_id: c_id,
                        c_valor_unitario: c_valor_unitario,
                        c_prazo: c_prazo,
                        c_qtd: c_qtd
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

    <div class="container-fluid">
        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Lista de cotaçoes por Fornecedor<h5>
            </div>
        </div>
        <br>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h4>Cotação No. <?php echo $i_id_cotacao . '  Fornecedor participante: ' . $c_fornecedor ?> </h4>
        </div>

        <form method="post">
            <a class="btn btn-secondary btn-sm" href="/gop/almoxarifado/cotacao_fornecedores.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
            <button type='submit' id="btnincluir" name="btnincluir" class='btn btn-success btn-sm' title='Atualizar item na cotação'><span class='glyphicon glyphicon-refresh'></span> Atualizar Itens</button>
        </form>
        <hr>
        <table class="table table display table-bordered tabcotacao">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Material</th>
                    <th scope="col">Prazo de Entrega</th>
                    <th scope="col">Quantidade</th>
                    <th scope="col" style='text-align: right;'>Valor Unitário</th>
                    <th scope="col" style='text-align: right;'>Valor Total</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT cotacao_materiais_fornecedor.id, materiais.descricao AS material, cotacao_materiais_fornecedor.valor_unitario,
                        cotacao_materiais_fornecedor.valor_total, cotacao_materiais_fornecedor.prazo_entrega,cotacao_materiais_fornecedor.quantidade
                        FROM cotacao_materiais_fornecedor
                        JOIN materiais ON cotacao_materiais_fornecedor.id_material=materiais.id
                        where id_cotacao_fornecedor='$i_id' and id_fornecedor='$i_id_fornecedor'";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                $formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
                while ($c_linha = $result->fetch_assoc()) {
                    if (!empty($c_linha['prazo_entrega']))
                        $c_data_prazo = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['prazo_entrega'])));
                    else
                        $c_data_prazo = "-";
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
                    <td>$c_data_prazo</td>
                    <td>$c_linha[quantidade]</td>
                    <td style='text-align: right;'>$c_valor_unitario</td>
                    <td style='text-align: right;'>$c_valor_total</td>
                    <td>
                    <button type='button' class='btn btn-secondary btn-sm editbtn' data-toggle='modal' title='Editar Cotação'><span class='glyphicon glyphicon-pencil'></span> Editar</button>&nbsp;
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>";
                    "</td>
                    </tr>
                    ";
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
                    <h4 class="modal-title" id="exampleModalLabel">Editar registro de Cotação</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Entre com valor unitário e a data de entrega do material</h5>
                    </div>
                    <form id="frmup" method="POST" action="">
                        <input type="hidden" id="up_idField" name="up_idField">
                        <input type="hidden" id="up_qtd" name="up_qtd">
                        <div class="mb-3 row">
                            <label for="up_descricaoField" class="col-md-3 form-label">Valor Unitário</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="up_valor_unitario" name="up_valor_unitario">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="up_descricaoField" class="col-md-3 form-label">Prazo de Entrega</label>
                            <div class="col-md-9">
                                <input type="date" class="form-control" id="up_prazo" name="up_prazo">
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