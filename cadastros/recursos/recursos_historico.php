<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
include("../../links.php");
// sql para pegar recurso
$c_id = $_GET["id"];
$c_sql_Recurso = "select * from recursos where id='$c_id'";
$result_recurso = $conection->query($c_sql_Recurso);
$c_linha_recurso = $result_recurso->fetch_assoc();
// pego as ordens de serviço do recurso fisico
$c_sql = "SELECT ordens.id, ordens.data_geracao, ordens.hora_geracao, ordens.data_conclusao, ordens.hora_conclusao, 
ordens.descritivo,  ordens.valor_material, ordens.valor_servico
, oficinas.descricao AS oficina,
 case
                    when ordens.status='A' then 'Aberta'
                    when ordens.status='E' then 'Em Andamento'
                    when ordens.status='C' then 'Concluída'
                    when ordens.status='S' then 'Suspensa'
                    when ordens.status='X' then 'Cancelada'
                    END AS ordens_status
 FROM ordens
JOIN oficinas ON ordens.id_oficina=oficinas.id
where id_recurso = '$c_id'
 ORDER BY ordens.data_geracao desc";
//echo $c_sql;
$result = $conection->query($c_sql);

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
            $('.tabhistorico').DataTable({
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

    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Histórico de Serviços<h5>
        </div>
    </div>
    <div class='alert alert-info' role='alert'>
        <div style="padding-left:15px;">
            <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

        </div>
        <h5>Histório de Serviços do Recurso Físico : <?php echo $c_linha_recurso['descricao'] ?></h5>
    </div>

    <div class="container-fluid">
        <table class="table table display table-bordered tabhistorico">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Data Geração</th>
                    <th scope="col">Hora Geração</th>
                    <th scope="col">Status</th>
                    <th scope="col">Data Conclusão</th>
                    <th scope="col">Hora Conclusão</th>
                    <th scope="col">Descritivo</th>
                    <th scope="col">Oficina</th>
                    <th scope="col">Valor Serviço</th>
                    <th scope="col">Valor Material</th>

                </tr>
            </thead>
            <tbody>
                <?php
                $formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    // formatacao de datas
                    $c_dta_gerada = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_geracao'])));
                    if (!empty($c_linha['data_conclusao']))
                        $c_dta_conclusao = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_conclusao'])));
                    else
                        $c_dta_conclusao = "";
                    // formatação financeira
                    if ($c_linha['valor_material'] > 0)
                        $c_material = $formatter->formatCurrency($c_linha['valor_material'], 'BRL');
                    else
                        $c_material = 0.00;
                    if ($c_linha['valor_servico'] > 0)
                        $c_servico = $formatter->formatCurrency($c_linha['valor_servico'], 'BRL');
                    else
                        $c_servico = 0.00;

                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_dta_gerada</td>
                    <td>$c_linha[hora_geracao]</td>
                    <td>$c_linha[ordens_status]</td>
                    <td>$c_dta_conclusao</td>
                    <td>$c_linha[hora_conclusao]</td>
                    <td>$c_linha[descritivo]</td>
                    <td>$c_linha[oficina]</td>
                    <td>$c_servico</td>
                    <td>$c_material</td>
                   

                    </tr>
                    ";
                }
                ?>


            </tbody>
        </table>
        <a class="btn btn-secondary btn-sm" href="/gop/cadastros/recursos/recursos_lista.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
    </div>


</body>

</html>