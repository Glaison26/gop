<?php
include("../conexao.php");
include("../links2.php");
if (!isset($_GET["id"])) {
    header('location: /gop/obras/obras_lista.php');
    exit;
}
// captura id do registro de obra
$c_id = $_GET["id"];
// pego descrição da obra via sql
$c_sql = "select * from obra where id = '$c_id'";
$result = $conection->query($c_sql);
$c_linha = $result->fetch_assoc();
$c_descricao_obra = $c_linha['descricao'];
?>

<!--
parte de frontend
-->


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<script language="Javascript">
    function confirmacao(id) {
        var resposta = confirm("Deseja remover esse registro?");
        if (resposta == true) {
            window.location.href = "/gop/obras/obras_grupos_excluir.php?id=" + id;
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
        $('.tabgrupos').DataTable({
            // 
            "iDisplayLength": -1,
            "order": [1, 'asc'],
            "aoColumnDefs": [{
                'bSortable': false,
                'aTargets': [2]
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


<body>
    <div class="container-fluid">
        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Lista de Insumos de Obras<h5>
            </div>
        </div>

        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Insumos da Obra : <?php echo $c_descricao_obra ?></h5>
        </div>
        <a class="btn btn-success btn-sm" href="/gop/cadastros/usuarios/Usuarios_novo.php"><span class="glyphicon glyphicon-plus"></span> Incluir</a>
        <a class="btn btn-secondary btn-sm" href="/gop/obras/obras_menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
    </div>
</body>

</html>