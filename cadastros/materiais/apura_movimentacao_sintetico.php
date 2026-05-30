<?php
// montagem de query para apurar as entradas atarvés da tabela de compras_materiais e compras, com filtro de data e tipo de material
// se o tipo de consulta for sintético, trago apenas o total de entradas e saídas por material, se for analítico, trago o detalhamento das entradas e saídas por material, com data e quantidade    
include("../../conexao.php");
include("../../links2.php");
include_once "../../lib_gop.php";

session_start();
$data_inicio = $_SESSION['data_inicio'];
$data_fim = $_SESSION['data_fim'];
$grupo_material = $_SESSION['grupo_material'];



$sql_movimentacao = "SELECT m.descricao AS material, g.descricao AS grupo, SUM(cm.quantidade) AS total_entrada
                         FROM compras_materiais cm
                         JOIN materiais m ON cm.id_material = m.id
                         JOIN grupos g ON m.id_grupo = g.id
                         JOIN compras c ON cm.id_compra = c.id
                         WHERE c.data BETWEEN '$data_inicio' AND '$data_fim'";

if ($grupo_material != 'Todos') {
    $sql_movimentacao .= " AND g.id = $grupo_material";
}

$sql_movimentacao .= " GROUP BY m.descricao, g.descricao ORDER BY total_entrada DESC";

//monto query para apurar as saídas através da tabela de ordens_servico_materiais e ordens_servico, com filtro de data e tipo de material
$sql_saida = "SELECT m.descricao AS material, g.descricao AS grupo, SUM(osm.quantidade) AS total_saida
              FROM ordens_materiais osm
              JOIN materiais m ON osm.id_material = m.id
              JOIN grupos g ON m.id_grupo = g.id
              JOIN ordens os ON osm.id_ordem = os.id
              WHERE os.data_inicio BETWEEN '$data_inicio' AND '$data_fim'";
if ($grupo_material != 'Todos') {
    $sql_saida .= " AND g.id = $grupo_material";
}
$sql_saida .= " GROUP BY m.descricao, g.descricao ORDER BY total_saida DESC";
// executo as queries
$result_movimentacao = $conection->query($sql_movimentacao);
$result_saida = $conection->query($sql_saida);
// verifico se as queries foram executadas corretamente
if (!$result_movimentacao) {
    die("Erro ao Executar Sql de Movimentação!!" . $conection->connect_error);
}
if (!$result_saida) {
    die("Erro ao Executar Sql de Saída!!" . $conection->connect_error);
}
?>
<!-- front end para exibir os resultados da movimentação de materiais por periodo e tipo de material
-->
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movimentação de Materiais</title>

    <link rel="shortcut icon" type="imagex/png" href="/gop/imagens/img_gop.ico">
</head>

<body>
    <div class="container-fluid">
        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Movimentação de Materiais</h5>
            </div>
        </div>
    </div>
    <div class="container mt-5">
        <h3>Resultados da Movimentação de Materiais</h3>
        <table class="table table-bordered mt-4">
            <thead>
                <tr>
                    <th>Material</th>
                    <th>Grupo</th>
                    <th>Total Entrada</th>
                    <th>Total Saída</th>
                    <th>Estoque Atual</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // crio um array para armazenar os resultados da movimentação
                $movimentacao = [];
                while ($row_movimentacao = $result_movimentacao->fetch_assoc()) {
                    $movimentacao[$row_movimentacao['material']] = [
                        'grupo' => $row_movimentacao['grupo'],
                        'entrada' => $row_movimentacao['total_entrada'],
                        'saida' => 0
                    ];
                }
                while ($row_saida = $result_saida->fetch_assoc()) {
                    if (isset($movimentacao[$row_saida['material']])) {
                        $movimentacao[$row_saida['material']]['saida'] = $row_saida['total_saida'];
                    } else {
                        $movimentacao[$row_saida['material']] = [
                            'grupo' => $row_saida['grupo'],
                            'entrada' => 0,
                            'saida' => $row_saida['total_saida']
                        ];
                    }
                }
                // exibo os resultados em uma tabela
                foreach ($movimentacao as $material => $dados) {
                    // capturo o quantidade atual em estoque na tabela de materiais atrvés de sql.
                    $sql_estoque = "SELECT quantidadeatual FROM materiais WHERE descricao = '$material'";
                    $result_estoque = $conection->query($sql_estoque);
                    if (!$result_estoque) {
                        die("Erro ao Executar Sql de Estoque!!" . $conection->connect_error);
                    }
                    $row_estoque = $result_estoque->fetch_assoc();
                    echo "<tr>";
                    echo "<td>{$material}</td>";
                    echo "<td>{$dados['grupo']}</td>";
                    echo "<td>{$dados['entrada']}</td>";
                    echo "<td>{$dados['saida']}</td>";
                    echo "<td>{$row_estoque['quantidadeatual']}</td>";
                    echo "</tr>";
                }
                ?>
            </tbody>
        </table>
        <!-- apuro total de entradas e saídas -->
        <?php
        $total_entrada = 0;
        $total_saida = 0;
        foreach ($movimentacao as $dados) {
            $total_entrada += $dados['entrada'];
            $total_saida += $dados['saida'];
        }
        ?>
        <hr>
        <div class="row">
            <div class="col-md-12">
                <h4>Resumo da Movimentação de Materiais</h4>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-md-6">
                <h5>Total de Entradas: <?php echo $total_entrada; ?></h5>
            </div>
            <div class="col-md-6">
                <h5>Total de Saídas: <?php echo $total_saida; ?></h5>
            </div>
        </div>
        <!-- botão para voltar ao menu -->
        <a href="/gop/menu.php" class="btn btn-secondary">Voltar ao Menu</a>
    </div>
</body>

</html>
<?php
// fecho a conexão com o banco de dados
$conection->close();
