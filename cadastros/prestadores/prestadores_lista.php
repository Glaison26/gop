<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include('../../conexao.php');
include('../../links2.php');

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GOP - Lista de Prestadores de Serviço</title>
</head>
<body>
    <!-- html com tabela de prestadores de serviço cadastrados no sistema -->
    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/cadastros/fornecedores/fornecedores_excluir.php?id=" + id;
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
            $('.tabprestadores').DataTable({
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
            <h5>Lista de Prestadores de Serviço<h5>
        </div>
    </div>

    <div class="container-fluid">


        <br>
        <a class="btn btn-success btn-sm" href="/gop/cadastros/prestadores/prestadores_novo.php"><span class="glyphicon glyphicon-plus"></span> Incluir</a>
        <a class="btn btn-secondary btn-sm" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>

        <hr>
        <table class="table table-bordered table-striped tabprestadores">
            <thead class="thead">
                <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Prestador</th>
                    <th scope="col">Razão Social</th>
                    <th scope="col">CNPJ</th>
                    <th scope="col">Fone I</th>
                    <th scope="col">Fone II</th>
                    <th scope="col">Contato</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // faço a Leitura da tabela de prestadores com sql
                $c_sql = "SELECT prestadores.id, prestadores.nome, prestadores.razao_social, prestadores.cnpj, prestadores.telefone1,
                prestadores.telefone2, prestadores.contato FROM prestadores ORDER BY prestadores.nome";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {

                    echo "
                    <tr>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[nome]</td>
                    <td>$c_linha[razao_social]</td>
                    <td>$c_linha[cnpj]</td>
                    <td>$c_linha[telefone1]</td>
                    <td>$c_linha[telefone2]</td>
                    <td>$c_linha[contato]</td>
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/cadastros/prestadores/prestadores_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
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