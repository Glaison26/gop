<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
include("../../links2.php");
include_once "../../lib_gop.php";
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $tipo_consulta = $_POST['tipo_consulta'];
    $data_inicio = $_POST['data_inicio'];
    $data_fim = $_POST['data_fim'];
    $grupo_material = $_POST['grupo_material'];
    // salvo os filtros em session para serem usados nos arquivos de consulta analitica e sintetica
    $_SESSION['data_inicio'] = $data_inicio;
    $_SESSION['data_fim'] = $data_fim;
    $_SESSION['grupo_material'] = $grupo_material;
    if ($tipo_consulta == 'Analítico') {
        header('location: apura_movimentacao_analitico.php');
        exit();
    } else {
        header('location: apura_movimentacao_sintetico.php');
        exit();
    }
}
?>
<!-- front end com periodo para consulta da movimentação de materiais e tipo de material -->
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
        
        <form action="" method="POST" class="mt-4">
            <div class="form-row">
                <!-- checkbox para selecionar Analitico ou Sintético -->
                 <div class="form-group col-md-4">
                    <label for="tipo_consulta">Tipo de Consulta</label>
                    <select class="form-select form-select-lg mb-3" id="tipo_consulta" name="tipo_consulta" required>
                        <option value="Sintético">Sintético</option>
                        <option value="Analítico">Analítico</option>
                    </select>
                </div>
                <div class="form-group col-md-4">
                    <label for="data_inicio">Data de Início</label>
                    <input type="date" class="form-control" id="data_inicio" name="data_inicio" required>
                </div>
                <div class="form-group col-md-4">
                    <label for="data_fim">Data de Fim</label>
                    <input type="date" class="form-control" id="data_fim" name="data_fim" required>
                </div>
                <!-- select para tipo de materias da tabela grupos -->
                 <div class="form-group col-md-4">
                    <label for="grupo_material">Grupo de Material</label>
                    <select class="form-select form-select-lg mb-3" id="grupo_material" name="grupo_material" required>
                        <option value="Todos">Todos</option>
                        <?php
                        // consulta para trazer os grupos de materiais da tabela grupos
                        $sql_grupos = "SELECT id, descricao FROM grupos ORDER BY descricao ASC";
                        $result_grupos = $conection->query($sql_grupos);
                        while ($row_grupos = $result_grupos->fetch_assoc()) {
                            echo '<option value="' . $row_grupos['id'] . '">' . $row_grupos['descricao'] . '</option>';
                        }
                        ?>
                    </select>
                </div>
            </div>
            <!-- botão para enviar o formulario -->   
            <button type="submit" class="btn btn-primary">Consultar</button>
            <!-- botão para voltar ao menu -->
            <a href="/gop/menu.php" class="btn btn-secondary">Voltar ao Menu</a>
        </form>
    </div>
</body>
</html>
