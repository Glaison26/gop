<?php
include("../../conexao.php");
include("../../links2.php");
include_once "../../lib_gop.php";

session_start();
$data_inicio = $_SESSION['data_inicio'];
$data_fim = $_SESSION['data_fim'];
$grupo_material = $_SESSION['grupo_material'];
// monto query para apurar as entradas através da tabela de compras_materiais e compras, com filtro de data e tipo de material
// sql irá conter material,grupo, fornecedor, quantidade total, valor total, data da compra
$sql_movimentacao = "SELECT m.descricao AS material, g.descricao AS grupo, f.descricao AS fornecedor,
                         SUM(cm.quantidade) AS total_entrada, c.id AS id_compra, SUM(cm.valor_total) AS valor_total, c.data AS data_compra
                         FROM compras_materiais cm
                         JOIN compras c ON cm.id_compra = c.id
                         JOIN materiais m ON cm.id_material = m.id
                         JOIN grupos g ON m.id_grupo = g.id
                         JOIN fornecedores f ON c.id_fornecedor = f.id
                         WHERE c.data BETWEEN '$data_inicio' AND '$data_fim'";
if ($grupo_material != 'Todos') {
    $sql_movimentacao .= " AND g.id = $grupo_material";
}
$sql_movimentacao .= " GROUP BY m.descricao, g.descricao, c.id, f.descricao, c.data ORDER BY c.data DESC";
// monto query para apurar as saídas através da tabela de ordens_servico_materiais e ordens_servico, com filtro de data e tipo de material
$sql_saida = "SELECT m.descricao AS material, g.descricao AS grupo, s.descricao AS setor, os.id AS ordem_servico, SUM(osm.quantidade) AS total_saida, os.data_inicio AS data_saida
              FROM ordens_materiais osm
              JOIN materiais m ON osm.id_material = m.id
              JOIN grupos g ON m.id_grupo = g.id
              JOIN ordens os ON osm.id_ordem = os.id
              JOIN setores s ON os.id_setor = s.id
              WHERE os.data_inicio BETWEEN '$data_inicio' AND '$data_fim'";
if ($grupo_material != 'Todos') {
    $sql_saida .= " AND g.id = $grupo_material";
}
$sql_saida .= " GROUP BY m.descricao, g.descricao, s.descricao, os.id,  os.data_inicio ORDER BY os.data_inicio DESC";
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

<!-- front end para exibir os resultados da movimentação de materiais por periodo e tipo de material sendo primeiro as entradas e depois as saídas, com possibilidade de exportar para excel -->
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Movimentação de Materiais - Analítico</title>
        <link rel="shortcut icon" type="imagex/png" href="/gop/imagens/img_gop.ico">
    </head>
    <body>
        <div class="container-fluid">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Movimentação de Materiais - Analítico</h5>
                </div>
            </div>
        </div>
        <div class="container content-box">
            <h3>Entradas</h3>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Material</th>
                        <th>Grupo</th>
                        <th>Fornecedor</th>
                        <th>Número da Compra</th>
                        <th>Quantidade Total</th>
                        <th>Valor Total</th>
                        <th>Data da Compra</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row_movimentacao = $result_movimentacao->fetch_assoc()) { ?>
                        <tr>
                            <td><?php echo $row_movimentacao['material']; ?></td>
                            <td><?php echo $row_movimentacao['grupo']; ?></td>
                            <td><?php echo $row_movimentacao['fornecedor']; ?></td>
                            <td><?php echo $row_movimentacao['id_compra']; ?></td>
                            <td><?php echo $row_movimentacao['total_entrada']; ?></td>
                            <td><?php echo number_format($row_movimentacao['valor_total'], 2, ',', '.'); ?></td>
                            <td><?php echo date('d/m/Y', strtotime($row_movimentacao['data_compra'])); ?></td>
                        </tr>
                    <?php } ?>
                </tbody>
            </table>

            <h3>Saídas</h3>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Material</th>
                        <th>Grupo</th>
                        <th>Setor</th>
                        <th>Ordem de Serviço</th>
                        <th>Quantidade Total</th>
                        <th>Data da Saída</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row_saida = $result_saida->fetch_assoc()) { ?>
                        <tr>
                            <td><?php echo $row_saida['material']; ?></td>
                            <td><?php echo $row_saida['grupo']; ?></td>
                            <td><?php echo $row_saida['setor']; ?></td>
                            <td><?php echo $row_saida['ordem_servico']; ?></td>
                            <td><?php echo $row_saida['total_saida']; ?></td>
                            <td><?php echo date('d/m/Y', strtotime($row_saida['data_saida'])); ?></td>
                        </tr>
                    <?php } ?>
                </tbody>
            </table>
            <!-- botão para voltar ao menu -->
            <a href="/gop/movimentacao_periodo.php" class="btn btn-secondary">Voltar</a>
            <!-- botão para imprimir a página -->
            <button class="btn btn-primary" onclick="window.print()">Imprimir</button>
        </div>
    </body>
</html>
