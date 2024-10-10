<?php // controle de acesso ao formulário

//////////////////////////////////////////////////////////////////////////
// Lista de Planejamentos X Estratégias para Planos de Ação X diretrizes
/////////////////////////////////////////////////////////////////////////


session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
if (isset($_GET['id'])) {
    $i_id = $_GET['id'];
    $_SESSION['id_planejamento'] = $i_id;
} else {
    $i_id = $_SESSION['id_planejamento'];
}
$_SESSION['volta_estrategia'] = 'S';
$c_sql = "Select * from planejamento where id='$i_id'";
$result = $conection->query($c_sql);
$c_nome = $result->fetch_assoc();
$c_planejamento = $c_nome['descritivo'];

// rotina para incluir diretrizes da estratégia selecionada ao palenjamento
if ((isset($_POST["btnincluir"])) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {
    $c_info_estrategia = $_POST['estr'];
    // sql para selecioanr estrategia selecionada
    $c_sql_estr = "select estrategias.id from estrategias where estrategias.descricao='$c_info_estrategia'";
    $result = $conection->query($c_sql_estr);
    $c_estr = $result->fetch_assoc();
    $i_estrategia = $c_estr['id'];
    // pego diretrizes anexos a estrategia selecionada
    $c_sql_anexos = "select diretriz_estrategia.id, diretriz_estrategia.id_diretriz, diretriz_estrategia.id_estrategia from diretriz_estrategia where diretriz_estrategia.id_estrategia='$i_estrategia'";
    //echo $c_sql_anexos;
    $result = $conection->query($c_sql_anexos);
    while ($c_linha = $result->fetch_assoc()) {
        // insiro os anexos e estartegia selecionada
        $id_dir= $c_linha['id_diretriz'];
        $id_estr = $c_linha['id_estrategia'];
        $c_sql_ins = "insert into planejamento_diretrizes (id_planejamento, id_diretriz, id_estrategia) value ('$i_id', '$id_dir', '$id_estr')";
        $result_ins = $conection->query($c_sql_ins);
    }
}

// faço a Leitura da tabela com sql

?>
<!doctype html>
<html lang="en">

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/plano_acao/planejamento_estrategia_excluir.php?id=" + id;
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
                    'aTargets': [8]
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
            <h4>Diretrizes para - <?php echo $c_planejamento ?></h4>
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
                            <label class="col-sm-2 col-form-label">Selecionar Estratégia para o planejamento</label>
                            <div class="col-sm-5">
                                <select class="form-select form-select-lg mb-3" id="estr" name="estr">
                                    <?php
                                    // select da tabela de estratégias
                                    $c_sql_estrategia = "SELECT estrategias.id, estrategias.descricao FROM estrategias ORDER BY estrategias.descricao";
                                    $result_estrategia = $conection->query($c_sql_estrategia);
                                    while ($c_linha = $result_estrategia->fetch_assoc()) {
                                        echo "<option>$c_linha[descricao]</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>
                        <button type="submit" name="btnincluir" id="btnincluir" title="Inclusão de nova Estratégia para Planejamento" class="btn btn-success btn-sm"
                            data-toggle="modal" data-target="#novoModal">
                            <span class="glyphicon glyphicon-plus"></span>
                            Incluir
                        </button>
                        <a class="btn btn-info btn-sm" href="/gop/plano_acao/estrategias_lista.php"><img src='\gop\images\iconeestrategia.png' alt='16' width='16' height='16'> Estratégias</a>
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
                    <th scope="col">Estratégia</th>
                    <th scope="col">Diretriz</th>
                    <th scope="col">Prazo</th>
                    <th scope="col">Local</th>
                    <th scope="col">Responsável</th>
                    <th scope="col">Custo</th>
                    <th scope="col">Situação</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // faço a Leitura da tabela com sql
                $c_sql = "SELECT planejamento_diretrizes.id, estrategias.descricao AS estrategia ,diretrizes.descricao AS diretriz, 
                        planejamento_diretrizes.prazo, planejamento_diretrizes.`local`, planejamento_diretrizes.responsavel, planejamento_diretrizes.custo,
                        planejamento_diretrizes.situacao FROM planejamento_diretrizes
                        JOIN estrategias ON planejamento_diretrizes.id_estrategia = estrategias.id
                        JOIN diretrizes ON planejamento_diretrizes.id_diretriz = diretrizes.id
                        where id_planejamento='$i_id'
                        ORDER BY estrategias.descricao";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }
                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {
                    if ($c_linha['situacao'] == 'C')
                        $c_situacao = "Concluido";
                    else
                        $c_situacao = "Aberto";
                    echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[estrategia]</td>
                    <td>$c_linha[diretriz]</td>
                    <td>$c_linha[prazo]</td>
                    <td>$c_linha[local]</td>
                    <td>$c_linha[responsavel]</td>
                    <td>$c_linha[custo]</td>
                    <td>$c_situacao</td>
                   
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