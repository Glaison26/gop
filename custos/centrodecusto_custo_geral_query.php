<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
// verifico se usuário e operador de tem autorização de acesso
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.custos_ocorrencias FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";
$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['custos_ocorrencias'] == 'N') {
    header('location: /gop/acesso.php');
}
date_default_timezone_set('America/Sao_Paulo');
$c_query = "";
// rotina para montagem do sql com as opções selecionadas
if ((isset($_POST["btnpesquisa"])) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {
    // formatação de datas para o sql
    $_SESSION['periodo'] = ' de ' . date("d-m-Y", strtotime(str_replace('/', '-', $_POST['data1']))) . ' a ' . date("d-m-Y", strtotime(str_replace('/', '-', $_POST['data2'])));
    $d_data1 = $_POST['data1'];
    $d_data1 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data1)));
    $d_data2 = $_POST['data2'];
    $d_data2 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data2)));
    // expressão sql inicia para recursos fisicos
    // data de abertura

    $c_where = "(data_geracao>='$d_data1' and data_geracao<='$d_data2') and ";
    $c_where = $c_where = substr($c_where, 0, -5); // tirar o and no final
    // montagem do sql para recursos físicos
    //
    $c_sql = "SELECT  sum(ordens.valor_material) AS total_material,
            SUM(ordens.valor_servico) AS total_servico FROM ordens
            where ordens.`status`='C' and $c_where";
    $_SESSION['sql'] = $c_sql;        
    $result = $conection->query($c_sql);
    // sql para apurar numero de ordens de serviços preventivas e corretivas
    $c_query = " Período de: " . date("d-m-Y", strtotime(str_replace('/', '-', $_POST['data1']))) . " até "
     . date("d-m-Y", strtotime(str_replace('/', '-', $_POST['data2']))).'<br><br>';
     $c_sql_preventiva = "select count(*) as total_preventiva from ordens where ordens.`status`='C' and ordens.tipo_ordem='P' and $c_where";
    $result_preventiva = $conection->query($c_sql_preventiva);
    $registro_preventiva = $result_preventiva->fetch_assoc();
    $c_sql_corretiva = "select count(*) as total_corretiva from ordens where ordens.`status`='C' and ordens.tipo_ordem='C' and $c_where";
    $result_corretiva = $conection->query($c_sql_corretiva);
    $registro_corretiva = $result_corretiva->fetch_assoc();
    $c_query = $c_query . " - Total de Ordens Preventivas: " . $registro_preventiva['total_preventiva'].'<br>';
    $c_query = $c_query . " - Total de Ordens Corretivas: " . $registro_corretiva['total_corretiva'].'<br>';
    // total de ordens
    $c_sql_total_ordens = "select count(*) as total_ordens from ordens where ordens.`status`='C' and $c_where";
    $result_total_ordens = $conection->query($c_sql_total_ordens);
    $registro_total_ordens = $result_total_ordens->fetch_assoc();
    $c_query = $c_query . " - Total Geral de Ordens: " . $registro_total_ordens['total_ordens'].'<br>';
    // Soma valor total de materiais e serviços
    $c_sql_valores = "SELECT  sum(ordens.valor_material) AS total_material,
            SUM(ordens.valor_servico) AS total_servico FROM ordens
            where ordens.`status`='C' and $c_where";
    $result_valores = $conection->query($c_sql_valores);
    $registro_valores = $result_valores->fetch_assoc();
    if (($registro_valores['total_material'] == '') || ($registro_valores['total_material'] == null))
        $registro_valores['total_material'] = 0;
    if (($registro_valores['total_servico'] == '') || ($registro_valores['total_servico'] == null))
        $registro_valores['total_servico'] = 0;
    // valor médio por ordem
    if ($registro_total_ordens['total_ordens'] > 0) {
        $valor_medio = ($registro_valores['total_material'] + $registro_valores['total_servico']) / $registro_total_ordens['total_ordens'];
    } else {
        $valor_medio = 0;
    }
    // valor medio por serviço
    if ($registro_valores['total_servico'] > 0) {
        $valor_medio_servico = $registro_valores['total_servico'] / $registro_total_ordens['total_ordens'];
    } else {
        $valor_medio_servico = 0;
    }
    // valor médio por material
    if ($registro_valores['total_material'] > 0) {
        $valor_medio_material = $registro_valores['total_material'] / $registro_total_ordens['total_ordens'];
    } else {
        $valor_medio_material = 0;
    }
    $c_query = $c_query . " - Valor Médio por Ordem: R$ " . number_format($valor_medio, 2, ',', '.').'<br>';
    $c_query = $c_query . " - Valor Médio por Serviço: R$ " . number_format($valor_medio_servico, 2, ',', '.').'<br>';
    $c_query = $c_query . " - Valor Médio por Material: R$ " . number_format($valor_medio_material, 2, ',', '.').'<br>';
    $c_query = $c_query . " - Valor Total Material: R$ " . number_format($registro_valores['total_material'], 2, ',', '.').'<br>';
    $c_query = $c_query . " - Valor Total Serviços: R$ " . number_format($registro_valores['total_servico'], 2, ',', '.').'<br>';
    $c_query = $c_query . " - Valor Total Geral: R$ " . number_format(($registro_valores['total_material'] + $registro_valores['total_servico']), 2, ',', '.');
            
    // salvo a query para exibir no relatório


    if (empty($c_query))
        $_SESSION['query'] = "Nenhum";
    else
        $_SESSION['query'] = $c_query;
    //echo $c_sql;
    //die();
    echo "<script> window.open('/gop/custos/geral_custo_relatorio.php?id=', '_blank');</script>";
}


?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>


<script>
    // função para verificas selct do tipo de solicitação e desebilita/ habilitar espaco fisico ou recurso
    function verifica(value) {
        var input_corretiva = document.getElementById("tipo_corretiva");
        var input_preventiva = document.getElementById("tipo_preventiva");

        if (value == 1) {
            input_corretiva.disabled = false;
            input_preventiva.disabled = true;
        } else if (value == 2) {
            input_corretiva.disabled = true;
            input_preventiva.disabled = false;
        } else if (value == 0) {
            input_corretiva.disabled = true;
            input_preventiva.disabled = true;
        }
    };
</script>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Opções para Relatório de custos Geral da Manutenção<h5>
        </div>
    </div>

    <div class="container  -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Realize uma pesquisa com as opções de pesquisa de Ordens de Serviço abaixo</h5>
        </div>
        <form method="post">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div style="padding-top:5px;padding-bottom:5px">

                        <button type="submit" name='btnpesquisa' id='btnpesquisa' class="btn btn btn-sm"><img src="\gop\images\printer.png" alt="" width="20" height="20"></span> Emitir</button>

                        <a class="btn btn btn-sm" href="\gop\menu.php"><img src="\gop\images\saida.png" alt="" width="25" height="25"> Voltar</a>
                    </div>
                </div>
            </div>

            <div class="panel panel-light class">
                <div class="panel-heading text-center">
                    <h4>Opções de Emissão<h4>
                </div>
            </div>

            <div class="row mb-3">

                <label class="col-md-2 form-label">De</label>
                <div class="col-sm-3">
                    <input type="Date" class="form-control" name="data1" id="data1" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                </div>
                <label class="col-md-1 form-label">até</label>
                <div class="col-sm-3">
                    <input type="Date" class="form-control" name="data2" id="data2" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                </div>

            </div>


        </form>
    </div>

</body>

</html>