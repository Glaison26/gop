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
if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['almoxarifado_materiais'] == 'N') {
    header('location: /gop/acesso.php');
}

?>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GOP - Lista de Materiais</title>
        <link rel="stylesheet" href="/gop/css/basico.css">
        <link rel="stylesheet" href="/gop/css/datatables.min.css">
        <script src="/gop/js/jquery-3.6.0.min.js"></script>
        <script src="/gop/js/datatables.min.js"></script>
        <link rel="shortcut icon" type="imagex/png" href="./imagens/img_gop.ico">
    </head>

<body>
    
    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/cadastros/materiais/materiais_excluir.php?id=" + id;
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
            $('.tabmateriais').DataTable({
                // 
                "iDisplayLength": 10,
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
            <h5>Lista de Materiais<h5>
        </div>
    </div>
    <br>
    <div class="container-fluid">

        <a class="btn btn-success btn-sm" href="/gop/cadastros/materiais/materiais_novo.php"><span class="glyphicon glyphicon-plus"></span> Incluir</a>
        <a class="btn btn-secondary btn-sm" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>

        <hr>
        <!-- legenda para as cores do campo quantidade atual sendo vermelho igual a zero, amarelo abaixo do minimo e verde acima do minimo  -->
        <div class="alert alert-info" role="alert">
            <div style="padding-left:10px;">
                <img Align="left" src="\gop\images\aviso.png" alt="30" height="35">
                <h4>Legenda para o campo de Saldo: Vermelho para quantidade igual a zero, Amarelo para quantidade abaixo
                     do estoque mínimo e Verde para quantidade acima do estoque mínimo</h4>
            </div>
        </div>
       
        <table class="table table-bordered table-striped tabmateriais">
            <thead class="thead">
                <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Saldo</th>
                    <th scope="col">estoq. mínimo</th>
                    <th scope="col">Unidade Saída</th>
                    <th scope="col">Grupo</th>
                    <th scope="col">Marca</th>
                    <th scope="col">Custo</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php
               
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT materiais.id, materiais.descricao, materiais.qtdmin, materiais.quantidadeatual, materiais.custo, unidades.descricao AS unidade," .
                    " marcas.descricao AS marca, grupos.descricao AS grupo" .
                    " FROM materiais" .
                    " JOIN  unidades on materiais.id_unidadeSaida=unidades.id" .
                    " JOIN  marcas on materiais.id_marca=marcas.id" .
                    " JOIN  grupos on materiais.id_grupo=grupos.id" .
                    " ORDER BY materiais.descricao";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    $c_custo = mask($c_linha['custo'], 'R$#########');
                    //  configuro cores para o campo de quantidade atual (amarelo abaixo do estoqe minimo, verde acima do estoque minimo e vermelho para quantidade igual a zero
                    $cor = '';
                    if ($c_linha['quantidadeatual'] == 0) {
                        $cor = 'style="background-color: #f8d7da;"';
                    } elseif ($c_linha['quantidadeatual'] < $c_linha['qtdmin']) {
                        $cor = 'style="background-color: #fff3cd;"';
                    } else {
                        $cor = 'style="background-color: #d4edda;"';
                    }
                    
                    echo "
                    <tr>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[descricao]</td>
                    <td $cor>$c_linha[quantidadeatual]</td>
                    <td>$c_linha[qtdmin]</td>
                    <td>$c_linha[unidade]</td>
                    <td>$c_linha[grupo]</td>
                    <td>$c_linha[marca]</td>
                    <td>$c_custo</td>
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