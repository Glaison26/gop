<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
include("../../links.php");
include_once "../../lib_gop.php";
// verifico se usuário e operador de tem autorização de acesso
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.almoxarifado_materiais FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";
$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
//if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['almoxarifado_materiais'] == 'N') {
//    header('location: /gop/acesso.php');
//}

// id do contrato
if (isset($_GET['id'])) {
    $c_id = $_GET['id'];
    $_SESSION['id_parametro'] = $c_id;
} else {
    $c_id = $_SESSION['id_parametro'];
}
//
$c_sql_parametro = "SELECT contratos_parametros.id, contratos_parametros.descricao FROM contratos_parametros where id=$c_id";
$resul_parametro = $conection->query($c_sql_parametro);
$registro_parametro = $resul_parametro->fetch_assoc();

?>
<!doctype html>
<html lang="en">

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/cadastros/contratos/contratos_excluir.php?id=" + id;
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
            $('.tablancamentos').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [9]
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
            <h5>Lista de Lançamentos de Contrato<h5>
        </div>
    </div>
  
    <div class="container-fluid">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5><strong>Lançamentos do Contrato : <?php echo $_SESSION['contrato'] . ' - ' . 'Parâmetro :' . $registro_parametro['descricao']  ?></strong></h5>
        </div>
        <a class="btn btn-success btn-sm" href="/gop/cadastros/contratos/lancamentos_novo.php"><span class="glyphicon glyphicon-plus"></span> Incluir</a>
        <a class="btn btn-secondary btn-sm" href="/gop/cadastros/contratos/parametros.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
        <hr>

        <hr>
        <table class="table table display table-bordered tablancamentos">
            <thead class="thead">
                <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Data</th>
                    <th scope="col">Quantidade</th>
                    <th scope="col">Unidade</th>
                    <th scope="col">Valor</th>
                    <th scope="col">No. da Nota</th>
                    <th scope="col">Emissão</th>
                    <th scope="col">Vencimento</th>
                    <th scope="col">Rateio</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT contratos_lancamentos.id, contratos_lancamentos.`data`, contratos_lancamentos.quantidade, contratos_lancamentos.valor,
                        contratos_lancamentos.nota, contratos_lancamentos.emissao, contratos_lancamentos.vencimento, contratos_lancamentos.cond_pagamento, contratos_lancamentos.rateio,
                        contratos_lancamentos.unidade
                        FROM contratos_lancamentos
                        ORDER BY contratos_lancamentos.`data` desc";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    $c_valor = mask($c_linha['valor'], 'R$#########');
                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[data]</td>
                    <td>$c_linha[quantidade]</td>
                    <td>$c_linha[unidade]</td>
                    <td>$c_valor</td>
                    <td>$c_linha[emissao]</td>
                    <td>$c_linha[vencimento]</td>
                    <td>$c_linha[rateio]</td>

                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/cadastros/materiais/materiais_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
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