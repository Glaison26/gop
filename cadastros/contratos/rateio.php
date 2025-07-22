<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
include("../../links.php");
include_once "../../lib_gop.php";
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
// verifico se usuário e operador de tem autorização de acesso
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.almoxarifado_materiais FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";
$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
// id do lançamento
$c_id = $_GET['id'];
//
?>

<!doctype html>
<html lang="en">

<body>

   <script>
        $(document).ready(function() {
            $('.tablancamentos').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [2]
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
            <h5>Rateio do Lançamento<h5>
        </div>
    </div>

    <div class="container-fluid">
        
        <a class="btn btn-success btn-sm" href="/gop/cadastros/contratos/lancamentos_novo.php"><span class="glyphicon glyphicon-duplicate"></span> Gerar Rateio</a>
       <a class="btn btn-secondary btn-sm" href="/gop/cadastros/contratos/lancamentos_lista.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
        <hr>

        <hr>
        <table class="table table display table-bordered tablancamentos">
            <thead class="thead">
                <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Centro de Custo</th>
                    <th scope="col">Valor do Rateio</th>
                   
                </tr>
            </thead>
            <tbody>
                <?php
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT contratos_rateio.id, centrodecusto.descricao, contratos_rateio.valor_rateio
                        FROM contratos_rateio
                        JOIN centrodecusto ON contratos_rateio.id_centrodecusto=centrodecusto.id
                        ORDER BY centrodecusto.descricao";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }
                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    // formatações de data e valores
                    $c_valor = $c_linha['valor_rateio'];
                    $c_valor = $formatter->formatCurrency($c_valor, 'BRL');
                    //
                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[descricao]</td>
                    <td>$c_valor</td>
                    </tr>
                    ";
                }
                ?>
            </tbody>
        </table>
    </div>
</body>

</html>