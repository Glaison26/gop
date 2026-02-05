<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
include("../links2.php");
$c_id = $_GET["id"];

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/ordens/ordens_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    $c_sql = "select ordens.tipo from ordens where ordens.id='$c_id'";
    $result = $conection->query($c_sql);
    $c_linha = $result->fetch_assoc();

    // leitura da ordem de serviço
    $c_sql = "SELECT ordens.id, ordens.data_geracao, hora_geracao, ordens.descricao,
    ordens.tipo, ocorrencias.descricao as ocorrencia, executores.nome as executor_responsavel,";

    if ($c_linha['tipo'] == 'R')
        $c_sql = $c_sql . "recursos.descricao as recurso,";
    if ($c_linha['tipo'] == 'E')
        $c_sql = $c_sql . "espacos.descricao as espaco,";
    $c_sql = $c_sql . "  case
        when tipo_ordem='C' then 'Corretiva'
        when tipo_ordem='P' then 'Preventiva'
        END AS ordens_tipo_texto,
        setores.descricao AS setor, usuarios.nome AS solicitante  
    FROM ordens";
    if ($c_linha['tipo'] == 'R')
        $c_sql = $c_sql . " JOIN recursos ON ordens.id_recurso=recursos.id";
    if ($c_linha['tipo'] == 'E')
        $c_sql = $c_sql . " JOIN espacos ON ordens.id_espaco=espacos.id";
    $c_sql = $c_sql . " JOIN ocorrencias ON ordens.id_ocorrencia=ocorrencias.id  
        JOIN setores ON ordens.id_setor=setores.id
        JOIN usuarios ON ordens.id_solicitante=usuarios.id
        join executores on ordens.id_executor_responsavel=executores.id
        where ordens.id='$c_id'";
    // echo $c_sql;
    $result = $conection->query($c_sql);
    $c_linha = $result->fetch_assoc();
    // gero arquivo texto com os dados da ordem de serviço para ser impresso
    $c_arquivo = "impressao\ordem_servico_" . $c_linha['id'] . ".txt";
    $c_conteudo = "Ordem de Serviço Nº: " . $c_linha['id'] . "\n";
    $c_conteudo = $c_conteudo . "Data de Geração: " . date('d/m/Y', strtotime($c_linha['data_geracao'])) . " Hora: " . $c_linha['hora_geracao'] . "\n";
    $c_conteudo = $c_conteudo . "Solicitante: " . $c_linha['solicitante'] . "\n";
    $c_conteudo = $c_conteudo . "Setor: " . $c_linha['setor'] . "\n";
    if ($c_linha['tipo'] == 'R')
        $c_conteudo = $c_conteudo . "Recurso: " . $c_linha['recurso'] . "\n";
    if ($c_linha['tipo'] == 'E')
        $c_conteudo = $c_conteudo . "Espaço: " . $c_linha['espaco'] . "\n";
    $c_conteudo = $c_conteudo . "Tipo de Ordem: " . $c_linha['ordens_tipo_texto'] . "\n";
    $c_conteudo = $c_conteudo . "Ocorrência: " . $c_linha['ocorrencia'] . "\n";
    $c_conteudo = $c_conteudo . "Executor Responsável: " . $c_linha['executor_responsavel'] . "\n";
    $c_conteudo = $c_conteudo . "Descrição: " . $c_linha['descricao'] . "\n";
    file_put_contents($c_arquivo, $c_conteudo);

}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
   <!-- Gera a ordem de serviço -->
    <div class="container mt-3">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h4>Ordem de Serviço - Emissão</h4>
            </div>
            <div class="card-body">
                <h5 class="card-title">Ordem de Serviço Nº: <?php echo $c_linha['id']; ?></h5>
                <p class="card-text"><strong>Data de Geração:</strong> <?php echo date('d/m/Y', strtotime($c_linha['data_geracao'])); ?>
                    &nbsp;&nbsp;&nbsp;<strong>Hora:</strong> <?php echo $c_linha['hora_geracao']; ?></p>
                <p class="card-text"><strong>Solicitante:</strong> <?php echo $c_linha['solicitante']; ?></p>
                <p class="card-text"><strong>Setor:</strong> <?php echo $c_linha['setor']; ?></p>
                <?php
                if ($c_linha['tipo'] == 'R') {
                    echo '<p class="card-text"><strong>Recurso:</strong> ' . $c_linha['recurso'] . '</p>';
                }
                if ($c_linha['tipo'] == 'E') {
                    echo '<p class="card-text"><strong>Espaço:</strong> ' . $c_linha['espaco'] . '</p>';
                }
                ?>
                <p class="card-text"><strong>Tipo de Ordem:</strong> <?php echo $c_linha['ordens_tipo_texto']; ?></p>
                <p class="card-text"><strong>Ocorrência:</strong> <?php echo $c_linha['ocorrencia']; ?></p>
                <p class="card-text"><strong>Executor Responsável:</strong> <?php echo $c_linha['executor_responsavel']; ?></p>
                <p class="card-text"><strong>Descrição da Solicitação:</strong><br><?php echo nl2br($c_linha['descricao']); ?></p>
               
            </div>
        </div>
    </div>
    <!-- rotina para enviar a ordem de serviço por email -->
    <div class="container mt-3">
        <form action="ordens_emissao_email.php?id=<?php echo $c_id; ?>" method="post">
            <button type="submit" class="btn btn-primary">Enviar Ordem de Serviço por Email</button>
           <!-- botão para fechar a aba aberta -->
            <button type="button" class="btn btn-secondary" onclick="window.close();">Fechar</button>
        </form>
    </div>

</body>

</html>