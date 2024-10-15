<?php
include_once "../lib_gop.php";
include("../conexao.php"); // conexão de banco de dados
include("../links.php");
date_default_timezone_set('America/Sao_Paulo');

if ((isset($_POST["btnfoto"])) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {  // botão para incluir imagem
    $dir = "img/";
    $arquivo = $_FILES['arquivo'];
    $_SESSION['c_nomefoto'] = $_FILES['arquivo']['name'];

    $c_nomefoto = $arquivo["name"];
    if (!empty($c_nomefoto)) {
        move_uploaded_file($arquivo["tmp_name"], "$dir/" . $arquivo["name"]);
        //echo $c_nomefoto;
        // incluir registro da imagem no banco de dados
        $c_pasta = $dir . $c_nomefoto;

        $d_data = date('Y-m-d');
        $c_sql = "insert into ordens_imagens (id_ordem, caminho, data) value ('$i_id', '$c_pasta', '$d_data')";
        $result = $conection->query($c_sql);
    }
}
$c_caminho = '/gop/ordens/imagens_lista.php?id=' . $i_id;
//
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
            $('.tabimagens').DataTable({
                // 
                "iDisplayLength": 6,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [4]
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

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/ordens/imagens_excluir.php?id=" + id;
            }
        }
    </script>

    <div class="container-fluid">
        <form method="post" enctype="multipart/form-data">
            <?php
            if ($c_linha_ordem['status'] <> 'C')
                echo "<div class='panel panel-Light'>

                    <br>
                    <div style='padding-left:7px;'>
                        <div class='panel panel-info class'>
                            <div class='panel-heading'>
                                <button type='submit' name='btnfoto' id='btnfoto' class='btn btn-Ligth'><img src='\gop\images\imagem2.png'
                                 alt='' width='20' height='20'> Carregar imagem</button>
                                <a class='btn btn-Light btn-sm' title='Lista de Imagens' href=' $c_caminho; '><span class='glyphicon glyphicon-list-alt'></span> Listar Imagens</a>
                                <hr>
                                <input type='file' name='arquivo' class='form-control-file' id='arquivo' accept='image/*'>
                            </div>
                        </div>
                    </div>

                </div>";
            ?>

            <div class="panel-body">
                <div style="padding-top:5px;">
                    <table class="table display table-bordered tabimagens">
                        <thead class="thead">
                            <tr class="info">
                                <th scope="col">No.</th>
                                <th scope="col">Data</th>
                                <th scope="col">Descrição</th>
                                <th scope="col">Pasta</th>
                                <th scope="col">Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            // faço a Leitura da tabela com imagens
                            $c_sql = "SELECT * FROM ordens_imagens where ordens_imagens.id_ordem='$i_id' ORDER BY ordens_imagens.`data` desc";
                            $result = $conection->query($c_sql);
                            // verifico se a query foi correto
                            if (!$result) {
                                die("Erro ao Executar Sql!!" . $conection->connect_error);
                            }

                            // insiro os registro do banco de dados na tabela 
                            while ($c_linha = $result->fetch_assoc()) {
                                $c_data = DateTime::createFromFormat('Y-m-d', $c_linha['data']);
                                $c_data = $c_data->format('d/m/Y');
                                echo "
                                        <tr>
                                            <td>$c_linha[id]</td>
                                            <td>$c_data</td>
                                            <td>$c_linha[comentario]</td>
                                            <td>$c_linha[caminho]</td>
                                            <td>
                                            
                                            <a class='btn btn-info btn-sm' title='Visualizar ' href='/gop/ordens/imagens_visualizar.php?id=$c_linha[id]'>
                                            <img src='\gop\images\imagem2.png' alt='' width='20' height='16'> Visualizar</span></a>";
                                if ($c_linha_ordem['status'] <> 'C')
                                    echo
                                    "<a class='btn btn-danger btn-sm' title='Excluir' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>";
                                    echo "</td>
                                    </tr>";
                            }
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>

        </form>
    </div>

    </div>


</body>





</html>