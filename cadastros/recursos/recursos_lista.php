<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
include("../../links.php");
// 
// verifico se usuário e operador de tem autorização de acesso
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.cadastros_recursosfisicos FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";

$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['cadastros_recursosfisicos'] == 'N') {
   
    header('location: /gop/menu.php');
}

?>
<!doctype html>
<html lang="en">

<body>
    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/cadastros/recursos/recursos_excluir.php?id=" + id;
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
            $('.tabrecursos').DataTable({
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
            <h5>Lista de Recursos Físicos<h5>
        </div>
    </div>

    <div class="container-fluid">


        <br>
        <a class="btn btn-success btn-sm" href="/gop/cadastros/recursos/recursos_novo.php"><span class="glyphicon glyphicon-plus"></span> Incluir</a>
        <a class="btn btn-secondary btn-sm" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>

        <hr>
        <table class="table table display table-bordered tabrecursos">
            <thead class="thead">
                <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Patrimônio</th>
                    <th scope="col">Fabricante</th>
                    <th scope="col">Fornecedor</th>
                    <th scope="col">Marca</th>
                    <th scope="col">Setor</th>
                    <th scope="col">Tipo</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT recursos.id, recursos.descricao, recursos.patrimonio, fabricantes.descricao as fabricante, fornecedores.descricao as fornecedor," .
                    " marcas.descricao as marca, tipos.descricao as tipo, setores.descricao as setor" .
                    " FROM recursos" .
                    " JOIN fabricantes ON recursos.id_fabricante=fabricantes.id" .
                    " JOIN fornecedores ON recursos.id_fornecedor=fornecedores.id" .
                    " JOIN marcas ON recursos.id_marca=marcas.id" .
                    " JOIN tipos ON recursos.id_tipo=tipos.id" .
                    " JOIN setores ON recursos.id_setor=setores.id" .
                    " ORDER BY recursos.descricao";

                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {

                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[descricao]</td>
                    <td>$c_linha[patrimonio]</td>
                    <td>$c_linha[fabricante]</td>
                    <td>$c_linha[fornecedor]</td>
                    <td>$c_linha[marca]</td>
                    <td>$c_linha[setor]</td>
                    <td>$c_linha[tipo]</td>
                   
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/cadastros/recursos/recursos_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                    <a class='btn btn-success btn-sm' href='/gop/cadastros/recursos/recursos_historico.php?id=$c_linha[id]'><img src='\gop\images\historia.png' alt='20' width='20' height='20'> Histórico</a>
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