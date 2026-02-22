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

include("../conexao.php");
include("../links2.php");
// montegem do sql para apuração dos indicadores
date_default_timezone_set('America/Sao_Paulo');
$c_query = "";
if ((isset($_POST["btnpesquisa"])) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {
    // rotina para montagem do sql com as opções selecionadas

    // formatação de datas para o sql
    $_SESSION['periodo'] = ' de ' . date("d-m-Y", strtotime(str_replace('/', '-', $_POST['data1']))) . ' a ' . date("d-m-Y", strtotime(str_replace('/', '-', $_POST['data2'])));
    $d_data1 = $_POST['data1'];
    $d_data1 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data1)));
    $d_data2 = $_POST['data2'];
    $d_data2 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data2)));
    // data de abertura
    $c_where = "(data_inicio>='$d_data1' and data_inicio<='$d_data2') and ";
    $c_where = $c_where = substr($c_where, 0, -5); // tirar o and no final
    // Índice de Cumprimento de Prazo (SLA) com data de conclusão menor ou   igual a data de prazo e hora de conclusão menor ou igual a hora de prazo
    $c_sql_sla = "SELECT count(*) as total_sla FROM ordens where ordens.`status`='C' and ordens.data_conclusao<=ordens.data_previsao  and $c_where";
    // executo o sql para apurar o total de ordens que cumpriram o prazo
    $result_sla = $conection->query($c_sql_sla);
    $registro_sla = $result_sla->fetch_assoc();
    // total de ordens concluídas no período
    $c_sql_total = "SELECT count(*) as total FROM ordens where ordens.`status`='C' and $c_where";
    $result_total = $conection->query($c_sql_total);
    $registro_total = $result_total->fetch_assoc();
    // total de ordens no periodo
    $c_sql_total_ordens = "select count(*) as total_ordens from ordens where ordens.`status`='C' and $c_where";
    $result_total_ordens = $conection->query($c_sql_total_ordens);
    $registro_total_ordens = $result_total_ordens->fetch_assoc();
    // total de ordens no periodo fora de sla
    $c_sql_total_fora_sla = "select count(*) as total_fora_sla from ordens where ordens.`status`='C' and ordens.data_conclusao>ordens.data_previsao
      and $c_where";
    $result_total_fora_sla = $conection->query($c_sql_total_fora_sla);
    $registro_total_fora_sla = $result_total_fora_sla->fetch_assoc();
    // calculo do índice de cumprimento de prazo
    if ($registro_total['total'] > 0) {
        $indice_sla = ($registro_sla['total_sla'] / $registro_total['total']) * 100;
    } else {
        $indice_sla = 0;
    }
    // Tempo Médio de Atendimento (TMA)
    $c_sql_tma = "SELECT avg(TIMESTAMPDIFF(MINUTE, CONCAT(data_inicio, ' ', hora_geracao), CONCAT(data_conclusao, ' ', hora_conclusao))) as tma FROM ordens 
where ordens.`status`='C' and $c_where";
    $result_tma = $conection->query($c_sql_tma);
    $registro_tma = $result_tma->fetch_assoc();
    // calculo do TMA em horas e minutos
    $tma_total_minutos = round($registro_tma['tma']);
    $horas = floor($tma_total_minutos / 60);
    $minutos = $tma_total_minutos % 60;
    // verifico se houve suspensão da ordem de serviço para descontar do tma total
    $c_sql_suspensao = "SELECT sum(TIMESTAMPDIFF(MINUTE, CONCAT(data_suspensao, ' ', hora_suspensao), 
    CONCAT(data_retirada, ' ', hora_retirada))) as tma_suspensao FROM ordens_suspensao 
    where ordens_suspensao.id_ordem in (select id from ordens where ordens.`status`='C' and $c_where)";

    $result_suspensao = $conection->query($c_sql_suspensao);
    $registro_suspensao = $result_suspensao->fetch_assoc();
    // calculo do tma total de horas trabalhadas divido pelo total de ordens para apurar o tma médio por ordem
    if ($registro_total['total'] > 0) {
        $tma_medio = ($tma_total_minutos - $registro_suspensao['tma_suspensao']) / $registro_total['total'];
    } else {
        $tma_medio = 0;
    }
    // calculo do TMA médio em horas e minutos
    $tma_medio_horas = floor($tma_medio / 60);
    if ($tma_medio > 0) {
        $tma_medio_minutos = round($tma_medio) % 60;
    }
    //  Índice de Produtividade da Manutenção (IPM) - não implementado ainda
    //  O indice é calcula usando total de ordens concluidas dividido pelo total de técnicos executores disniveis no período
    // sql para apurar o total de técnicos executores disponíveis no período
    $c_sql_tecnicos = "select count(*) as total_tecnicos from executores where executores.ativo = 'Sim'";
    $result_tecnicos = $conection->query($c_sql_tecnicos);
    $registro_tecnicos = $result_tecnicos->fetch_assoc();
    if ($registro_tecnicos['total_tecnicos'] > 0) {
        $ipm = $registro_total_ordens['total_ordens'] / $registro_tecnicos['total_tecnicos'];
    } else {
        $ipm = 0;
    }
    // calculo de ipm por horas usando total de ordens concluidas dividido pelo total de horas trabalhadas das ordens concluidas no período
    $c_sql_horas_trabalhadas = "SELECT sum(TIMESTAMPDIFF(MINUTE, CONCAT(data_inicio, ' ', hora_geracao), CONCAT(data_conclusao, ' ', hora_conclusao))) 
    as horas_trabalhadas FROM ordens where ordens.`status`='C' and $c_where";
    $result_horas_trabalhadas = $conection->query($c_sql_horas_trabalhadas);
    $registro_horas_trabalhadas = $result_horas_trabalhadas->fetch_assoc();
    if ($registro_horas_trabalhadas['horas_trabalhadas'] > 0) {
        $ipm_horas = $registro_total_ordens['total_ordens'] / ($registro_horas_trabalhadas['horas_trabalhadas'] / 60);
    } else {
        $ipm_horas = 0;
    }
    // calculo de ipm por numero de dias usando total de ordens concluidas dividido pelo total de dias do período
    $data_inicio = new DateTime($d_data1);
    $data_fim = new DateTime($d_data2);
    $intervalo = $data_inicio->diff($data_fim);
    $total_dias = $intervalo->days + 1; // adiciona 1 para incluir o dia final
    if ($total_dias > 0) {
        $ipm_dias = $registro_total_ordens['total_ordens'] / $total_dias;
    } else {
        $ipm_dias = 0;
    }

    // sql para apurar total de horas reais realizadas = somatorio de data e hora da conclusão - data e hora inicial das ordens no periodo
    $c_sql_horas_reais = "SELECT sum(TIMESTAMPDIFF(MINUTE, CONCAT(data_inicio, ' ', hora_geracao), CONCAT(data_conclusao, ' ', hora_conclusao))) 
    as horas_reais FROM ordens where ordens.`status`='C' and $c_where";
    $result_horas_reais = $conection->query($c_sql_horas_reais);
    $registro_horas_reais = $result_horas_reais->fetch_assoc();
    // sql para apurar total de horas previstas = somatorio de data e hora da conclusão - data e hora prevista das ordens no periodo
    $c_sql_horas_previstas = "SELECT sum(TIMESTAMPDIFF(MINUTE, CONCAT(data_previsao, ' ', hora_previsao), CONCAT(data_conclusao, ' ', hora_conclusao))) 
    as horas_previstas FROM ordens where ordens.`status`='C' and $c_where";
    $result_horas_previstas = $conection->query($c_sql_horas_previstas);
    $registro_horas_previstas = $result_horas_previstas->fetch_assoc();
    // calculo do índice de eficiência operacional usando a fórmula: (total de horas previstas - total de horas reais) / total de horas previstas * 100
    if ($registro_horas_previstas['horas_previstas'] > 0) {
        $indice_eficiencia_operacional = ($registro_horas_previstas['horas_previstas'] / $registro_horas_reais['horas_reais']) * 100;
    } else {
        $indice_eficiencia_operacional = 0;
    }

    // monto o detalhamento dos indicadores para exibir no relatório
    $c_query = "Período de: " . date("d-m-Y", strtotime(str_replace('/', '-', $_POST['data1']))) . " até "
        . date("d-m-Y", strtotime(str_replace('/', '-', $_POST['data2']))) . '<br><br>';
    $c_query = $c_query . " - Índice de Cumprimento de Prazo (SLA): " . number_format($indice_sla, 2) . '%<br>';
    $c_query = $c_query . " - Tempo Médio de Atendimento (TMA): " . $tma_medio_horas . " horas e " . $tma_medio_minutos . " minutos<br>";
    $c_query = $c_query . " - Total de Ordens Concluídas no Período: " . $registro_total['total'] . '<br>';
    $c_query = $c_query . " - Total de Ordens Fora do SLA: " . $registro_total_fora_sla['total_fora_sla'] . '<br>';
    $c_query = $c_query . " - Índice de Produtividade da Manutenção (IPM) por Número de Técnicos: " . number_format($ipm, 2) . '<br>';
    $c_query = $c_query . " - Índice de Produtividade da Manutenção (IPM) por Horas Trabalhadas: " . number_format($ipm_horas, 2) . '<br>';
    $c_query = $c_query . " - Índice de Produtividade da Manutenção (IPM) por Número de Dias: " . number_format($ipm_dias, 2) . '<br>';
    $c_query = $c_query . " - Índice de Eficiência Operacional: " . number_format($indice_eficiencia_operacional, 2) . '%<br>';

    // salvo a query para exibir no relatório
    if (empty($c_query))
        $_SESSION['query_indicadores'] = "Nenhum";
    else
        $_SESSION['query_indicadores'] = $c_query;
    //echo $c_sql;
    //die();
    echo "<script> window.open('/gop/indicadores_mensais/indicadores_manutencao_relatorio.php?id=', '_blank');</script>";
}


?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>


<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Opções para Relatório de Indices de Qualidade da Manutenção<h5>
        </div>
    </div>

    <div class="container  -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Informe o período para emissão do relatório</h5>
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