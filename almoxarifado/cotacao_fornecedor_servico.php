<?php
////////////////////////////////////////////////////////////
// rotina verifica se os serviços foram anexados ao fornecedor.
// se não inclui os serviços já inclui a cotação por fornecedor
////////////////////////////////////////////////////////////
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");

if (isset($_GET['id'])) {
    $i_id = $_GET['id'];
    $_SESSION['id_servico_fornecedor'] = $i_id;
} else {
    $i_id = $_SESSION['id_servico_fornecedor'];
}
// sql para captura id do fornecedor
$c_sql_fornec = "select id_fornecedor from cotacao_fornecedor where id='$i_id '";
$result_fornec = $conection->query($c_sql_fornec);
$c_linha_fornec = $result_fornec->fetch_assoc();
$i_id_fornecedor = $c_linha_fornec['id_fornecedor'];
// verifico se já existem dados para o fornecedor 
$c_sql_conta = "SELECT COUNT(*) AS registros FROM cotacao_servicos_fornecedores where id_cotacao_fornecedor=' $i_id' and id_fornecedor='$i_id_fornecedor'";
$result_conta = $conection->query($c_sql_conta);
$c_linha = $result_conta->fetch_assoc();
//
$i_id_cotacao = $_SESSION['id_cotacao'];
// pego fornecedor
$c_sql_fornecdor = "select fornecedores.id, fornecedores.descricao from fornecedores where id = '$i_id_fornecedor'";
$result_fornec = $conection->query($c_sql_fornecdor);
$c_linha_fornec = $result_fornec->fetch_assoc();
$c_fornecedor = $c_linha_fornec['descricao'];
// checo se existem registros
if ($c_linha['registros'] == 0) {

    // monto sql para pegar os serviços incluido para cotação
    $c_sql = "SELECT cotacao_servicos.id, cotacao_servicos.id_cotacao
                     
                     FROM cotacao_servicos
                     WHERE cotacao_servicos.id_cotacao='$i_id_cotacao'";
    $result = $conection->query($c_sql);
    // echo $c_sql;
    // verifico se a query foi correto
    if (!$result) {
        die("Erro ao Executar Sql!!" . $conection->connect_error);
    }
    // loop para inclusão dos materias nata tabea de cotação X materiais
    while ($c_linha = $result->fetch_assoc()) {
       
        $id_servico = $c_linha['id'];
        // insiro registro com os dados dos materiais selecionados
        $c_sql_add = "Insert into cotacao_servicos_fornecedores (id_servico, id_fornecedor, id_cotacao_fornecedor) 
        values ('$id_servico', '$i_id_fornecedor', '$i_id')";
        $result_add = $conection->query($c_sql_add);
        // verifico se a query foi correto
        if (!$result_add) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
    }
} else {
    // faço somatorio dos valores e edito na tabela do fornecedor da cotação
   $c_sql_soma = "SELECT SUM(cotacao_servicos_fornecedores.valor) AS total FROM cotacao_servicos_fornecedores
    where id_cotacao_fornecedor=' $i_id' and id_fornecedor='$i_id_fornecedor'";
    //echo $c_sql_soma;
    $result_soma = $conection->query($c_sql_soma);
    $c_linha_soma = $result_soma->fetch_assoc();
    $n_soma = $c_linha_soma['total'];
    // edito valor de soma no registro do fornecedor
    if ($n_soma>0){
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

    <script>
        $(document).ready(function() {
            $('.tabcotacao').DataTable({
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
                $('#up_valor').val(data[3].replace('R$', '').replace(',', '.').replace(/^\s+|\s+$/g, ''));
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
            var c_valor = $('#up_valor').val();
            var c_prazo = $('#up_prazo').val();
            

            if (c_valor != '') {

                $.ajax({
                    url: "cotacao_servicos_fornecedor_editar.php",
                    type: "post",
                    data: {
                        c_id: c_id,
                        c_valor: c_valor,
                        c_prazo: c_prazo
                        
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
                <h5>Lista de cotaçoes de servicos<h5>
            </div>
        </div>
       
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h4>Cotação No. <?php echo $i_id_cotacao .'  Fornecedor participante: '.$c_fornecedor ?> </h4>
        </div>
        <a class="btn btn-secondary btn-sm" href="/gop/almoxarifado/cotacao_fornecedores.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
        <hr>
        <table class="table table display table-bordered tabcotacao">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Serviço</th>
                    <th scope="col">Prazo de Entrega</th>
                    <th scope="col" style='text-align: right;'>Valor Total</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT cotacao_servicos_fornecedores.id, cotacao_servicos_fornecedores.id_servico, cotacao_servicos.descricao as servico, cotacao_servicos_fornecedores.valor, 
                        cotacao_servicos_fornecedores.prazo_entrega
                        FROM cotacao_servicos_fornecedores
                        JOIN cotacao_servicos ON cotacao_servicos_fornecedores.id_servico=cotacao_servicos.id
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
                    if ($c_linha['valor'] > 0)
                        $c_valor = $formatter->formatCurrency($c_linha['valor'], 'BRL');
                    else
                        $c_valor = 'R$ 0,00';
                    
                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[servico]</td>
                    <td>$c_data_prazo</td>
                    <td style='text-align: right;'>$c_valor</td>
                   
                    <td>
                    <button type='button' class='btn btn-secondary btn-sm editbtn' data-toggle='modal' title='Editar Cotação'><span class='glyphicon glyphicon-pencil'></span> Editar</button>&nbsp;";
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
                    <h4 class="modal-title" id="exampleModalLabel">Editar registro de Cotação de Serviço</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Entre com valor Total e a data de entrega do Serviço</h5>
                    </div>
                    <form id="frmup" method="POST" action="">
                        <input type="hidden" id="up_idField" name="up_idField">
                       
                        <div class="mb-3 row">
                            <label for="up_descricaoField" class="col-md-3 form-label">Prazo de Entrega</label>
                            <div class="col-md-9">
                                <input type="date" class="form-control" id="up_prazo" name="up_prazo">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="up_descricaoField" class="col-md-3 form-label">Valor Total</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="up_valor" name="up_valor">
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