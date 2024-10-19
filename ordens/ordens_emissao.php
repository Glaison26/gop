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
    ordens.tipo, ocorrencias.descricao as ocorrencia,";
    
    if ($c_linha['tipo'] == 'R')
        $c_sql = $c_sql. "recursos.descricao as recurso,";
    else
        $c_sql = $c_sql. "espacos.descricao as espaco,";
    $c_sql = $c_sql . "  case
        when tipo_ordem='C' then 'Corretiva'
        when tipo_ordem='P' then 'Preventiva'
        END AS ordens_tipo_texto,
        setores.descricao AS setor, usuarios.nome AS solicitante  
    FROM ordens";
    if ($c_linha['tipo'] == 'R')
        $c_sql = $c_sql . " JOIN recursos ON ordens.id_recurso=recursos.id";
    else
        $c_sql = $c_sql . "JOIN espacos ON ordens.id_espaco=espacos.id";
    $c_sql = $c_sql . " JOIN ocorrencias ON ordens.id_ocorrencia=ocorrencias.id  
        JOIN setores ON ordens.id_setor=setores.id
        JOIN usuarios ON ordens.id_solicitante=usuarios.id
        where ordens.id='$c_id'";
     $result = $conection->query($c_sql);
    $c_linha = $result->fetch_assoc();
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
    <div class="container">
        <h2>Ordem de Serviço no. <?php echo $c_id ?></h2>
        <div class="panel panel-default">
            <div class="panel-heading"></div>
            <div class="panel-body">

                <?php echo '<strong>Data da Geração :</strong> ' .  date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data_geracao']))) .
                    '<strong>  Hora da Geração :</strong> ' . $c_linha['hora_geracao'] . '<br><br>';
                echo '<strong>Ocorrência :</strong> ' . $c_linha['ocorrencia'] . '<br><br>';
                echo '<strong>Tipo da Ordem :</strong> ' . $c_linha['ordens_tipo_texto'] .
                    '<strong>   Setor :</strong> ' . $c_linha['setor'] . '<br><br>'.'<strong> Solicitante: </strong> '
                    . $c_linha['solicitante'] . '<br><br>';
                if ($c_linha['tipo'] == 'R')
                    echo '<strong>Recursos Físico : </strong> ' . $c_linha['recurso'] . '<br><br>';
                else
                    echo '<strong>Espaço Físico : </strong> ' . $c_linha['espaco'] . '<br><br>';
                echo '<strong>Descrição do Serviço :</strong><br><br>';
                echo $c_linha['descricao'];
                ?>
            </div>
            <div class="panel-footer"><?php echo "Emissão :" . date('d/m/Y H:i'); ?></div><br>

        </div>
    </div>


</body>

</html>