<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links.php");
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
?>
<!doctype html>
<html lang="en">

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/obras_itens_excluir.php?id=" + id;
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
            $('.tabitens').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [6]
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
            <h5>Lista de Itens de Obras<h5>
        </div>
    </div>

    <br>
    <div class="container-fluid">

        <a class="btn btn-success btn-sm" href="/gop/obras/obras_itens_novo.php"><span class="glyphicon glyphicon-plus"></span> Incluir</a>
        <a class="btn btn-secondary btn-sm" href="/gop/obras/obras_menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>

        <hr>
        <table class="table table display table-bordered tabitens">
            <thead class="thead">
                <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Grupo</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Unidade</th>
                    <th scope="col">Valor Mão de Obra</th>
                    <th scope="col">Valor de Material</th>
                    <th scope="col">Opções</th>

                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT obras_itens.id, obras_itens.id_grupo, obras_grupo.descricao AS grupo, 
                unidades.descricao AS unidade, obras_itens.id_unidade, 
                obras_itens.descricao, obras_itens.valor_maodeobra, obras_itens.valor_material FROM obras_itens
                JOIN obras_grupo ON obras_itens.id_grupo=obras_grupo.id
                JOIN unidades ON obras_itens.id_unidade=unidades.id
                ORDER BY obras_grupo.descricao, obras_itens.descricao";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    // variaveis com formatação
                    $c_maodeobra = $formatter->formatCurrency($c_linha['valor_maodeobra'], 'BRL');
                    $c_material = $formatter->formatCurrency($c_linha['valor_material'], 'BRL');
                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[grupo]</td>
                    <td>$c_linha[descricao]</td>
                    <td>$c_linha[unidade]</td>
                    <td style='text-align: right;'>$c_maodeobra</td>
                    <td style='text-align: right;'>$c_material</td>
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/obras/obras_itens_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
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