<?php // controle de acesso ao formulário

/////////////////////////////////////////////
// Lista de Diretrizes X Estratégias para Planos de Ação
/////////////////////////////////////////////


session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
if (isset($_GET['id'])) {
    $i_id = $_GET['id'];
    $_SESSION['id_estartegia'] = $i_id;
} else {
    $i_id = $_SESSION['id_estartegia'];
}
$_SESSION['voltadiretriz'] = 'S';
$msg_erro = "";
$c_sql = "Select * from estrategias where id='$i_id'";
$result = $conection->query($c_sql);
$c_nome = $result->fetch_assoc();
$c_estrategia = $c_nome['descricao'];

// faço a Leitura da tabela com sql
$c_sql = "SELECT diretriz_estrategia.id, estrategias.descricao as estrategia, diretrizes.descricao as diretriz FROM diretriz_estrategia
          JOIN estrategias ON diretriz_estrategia.id_estrategia=estrategias.id
          JOIN diretrizes ON diretriz_estrategia.id_diretriz=diretrizes.id
          where id_estrategia='$i_id'
          ORDER BY diretrizes.descricao";
$result = $conection->query($c_sql);
// verifico se a query foi correto
if (!$result) {
    die("Erro ao Executar Sql!!" . $conection->connect_error);
}
// botão incluir selecionado para incluir diretriz
if ((isset($_POST["btnincluir"])) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {

    // sql para pegar a id da diretrix selecionada
    $c_diretriz = $_POST['dir'];
    $c_sql_diretriz = "select diretrizes.id from diretrizes where diretrizes.descricao='$c_diretriz'";
    $result = $conection->query($c_sql_diretriz);
    $c_dir = $result->fetch_assoc();
    $i_diretriz = $c_dir['id'];
    // verifico se não há duplicitade de diretrizes na mesma estratégia
    $c_sql_conta = "select count(*) as total from diretriz_estrategia where id_estrategia='$i_id' and id_diretriz=$i_diretriz ";
    $result = $conection->query($c_sql_conta);
    $c_conta = $result->fetch_assoc();
    if ($c_conta['total'] == 0) {
        // insere registro
        $c_sql_ins = "insert into diretriz_estrategia (id_estrategia, id_diretriz) value ('$i_id', '$i_diretriz')";
        $result = $conection->query($c_sql_ins);
    } else
        $msg_erro = "Diretriz já foi incluida para essa estratégia !!!";
}

?>
<!doctype html>
<html lang="en">

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/plano_acao/estrategia_diretriz_excluir.php?id=" + id;
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
            $('.tabdiretriz_estrategia').DataTable({
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


    <!-- montagem da página -->
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Lista de Diretrizes da Estratégia<h5>
        </div>
    </div>
    <div style="padding-left:7px;padding-right:7px;">
        <div class='alert alert-info' role='alert'>

            <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            <h4>Diretrizes para - <?php echo $c_estrategia ?></h4>
        </div>
    </div>
    <?php
    if (!empty($msg_erro)) {
        echo "
            <div class='alert alert-warning' role='alert'>
                <div style='padding-left:15px;'>
                    <h4><img Align='left' src='\gop\images\aviso.png' alt='30' height='35'> $msg_erro</h4>
                </div>
                
            </div>
            ";
    }
    ?>
    <br>
    <div class="container-fluid">
        <form method="post">
            <div style="padding-left:7px;">
                <div class="panel panel-info class">
                    <div class="panel-heading">

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Selecionar Diretriz para Estratégia</label>
                            <div class="col-sm-5">
                                <select class="form-select form-select-lg mb-3" id="dir" name="dir">
                                    <?php
                                    // select da tabela de diretrizez
                                    $c_sql_diretriz = "SELECT diretrizes.id, diretrizes.descricao FROM diretrizes ORDER BY diretrizes.descricao";
                                    $result_diretriz = $conection->query($c_sql_diretriz);
                                    while ($c_linha = $result_diretriz->fetch_assoc()) {
                                        echo "<option>$c_linha[descricao]</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>
                        <button type="submit" name="btnincluir" id="btnincluir" title="Inclusão de nova diretriz a Estratégia" class="btn btn-success btn-sm">
                            <span class="glyphicon glyphicon-plus"></span>
                            Incluir
                        </button>
                        <a class="btn btn-info btn-sm" href="/gop/plano_acao/diretriz_lista.php"><img src='\gop\images\diretrizes.png' alt='16' width='16' height='16'> Diretrizes</a>
                        <a class="btn btn-secondary btn-sm" href="/gop/plano_acao/estrategias_lista.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>
                    </div>
                </div>
            </div>
        </form>

        <hr>
        <table class="table table display table-bordered tabdiretriz_estrategia">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Diretriz</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT diretriz_estrategia.id, estrategias.descricao as estrategia, diretrizes.descricao as diretriz FROM diretriz_estrategia
                        JOIN estrategias ON diretriz_estrategia.id_estrategia=estrategias.id
                        JOIN diretrizes ON diretriz_estrategia.id_diretriz=diretrizes.id
                        where id_estrategia='$i_id'
                        ORDER BY diretrizes.descricao";
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
                    <td>$c_linha[diretriz]</td>
                   
                    <td>
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