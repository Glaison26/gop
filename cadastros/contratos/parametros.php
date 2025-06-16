<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
include("../../conexao.php");
include("../../links.php");
// verifico se usuário e operador de tem autorização de acesso
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.cadastros_executores FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";
// id do contrato
$c_id = $_GET["id"];

$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
// pego o contrato selecionado via sql
$c_sql_contrato = "SELECT contratos.id, contratos.empresa, contratos.numero_contrato FROM contratos where id=$c_id";
$resul_contrato = $conection->query($c_sql_contrato);
$registro_contrato = $resul_contrato->fetch_assoc();
//if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['cadastros_executores'] == 'N') {

//    header('location: /gop/acesso.php');
//}
?>
<!doctype html>
<html lang="en">

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/cadastros/contratos/parametros_excluir.php?id=" + id;
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
            $('.tabcontratos').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [3]
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

    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Lista de Parametros do Contrato<h5>
        </div>
    </div>


    <div class="container-fluid">
        <br>
        <a class="btn btn-success btn-sm" href="/gop/cadastros/contratos/contratos_novo.php"><span class="glyphicon glyphicon-plus"></span> Incluir</a>
        <a class="btn btn-secondary btn-sm" href="/gop/cadastros/contratos/contratos_lista.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
        <hr>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Parâmetros do Contrato : <?php echo $registro_contrato['empresa'].'-'.'Número :'.' '.$registro_contrato['numero_contrato'] ?></h5>
        </div>
        <hr>
        <table class="table display table-bordered tabcontratos">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Unidade</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT contratos_parametros.id, contratos_parametros.descricao, unidades.descricao AS unidade FROM contratos_parametros
                JOIN unidades ON contratos_parametros.id_unidade=unidades.id WHERE contratos_parametros.id_contrato=$c_id
                ORDER BY contratos_parametros.descricao";
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
                    <td>$c_linha[unidade]</td>
                    <td>
                    <a class='btn btn-primary btn-sm' href='/gop/cadastros/contratos/parametros.php?id=$c_linha[id]'><span class='glyphicon glyphicon-list-alt'></span> Lançamentos</a>
                    <a class='btn btn-secondary btn-sm' href='/gop/cadastros/contratos/contratos_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
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