<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}


include('../links.php');
include('../conexao.php');

// pego data do dia
date_default_timezone_set('America/Sao_Paulo');
$agora = date('Y-m-d');
// sql com as preventiva com data da próxima realização igual ou inferior a data do dia em recurso fisico
$c_sql_recurso = "SELECT preventivas.id, preventivas.id_oficina, preventivas.id_setor, preventivas.tipo,
 preventivas.periodicidade_geracao, preventivas.calibracao, preventivas.id_recurso, recursos.descricao as recurso,
preventivas.data_ult_realizacao, preventivas.data_prox_realizacao, preventivas.tipo_preventiva, 
preventivas.descritivo, preventivas.gerar, preventivas.id_ocorrencia,
case
when preventivas.calibracao ='S' then 'Sim'
when preventivas.calibracao ='N' then 'Não'
END AS preventiva_calibracao
FROM preventivas 
JOIN recursos ON preventivas.id_recurso=recursos.id
where data_prox_realizacao<='$agora' and gerar = 'Sim'
ORDER BY preventivas.data_prox_realizacao desc";
echo $c_sql_recurso;
// sql com as preventiva com data da próxima realização igual ou inferior a data do dia em espaço fisico
$c_sql_espaco = "SELECT preventivas.id, preventivas.tipo, preventivas.id_oficina, preventivas.tipo_preventiva, 
preventivas.periodicidade_geracao, preventivas.descritivo, preventivas.id_setor, preventivas.calibracao, preventivas.id_espaco, 
espacos.descricao as espaco, preventivas.data_ult_realizacao, preventivas.data_prox_realizacao,
 preventivas.gerar, preventivas.id_ocorrencia,
case
when preventivas.calibracao ='S' then 'Sim'
when preventivas.calibracao ='N' then 'Não'
END AS preventiva_calibracao
FROM preventivas 
JOIN espacos ON preventivas.id_espaco=espacos.id
where data_prox_realizacao<='$agora'
ORDER BY preventivas.data_prox_realizacao desc";

////////////////////////////////////
// geração para recursos fisicos
////////////////////////////////////

$result = $conection->query($c_sql_recurso);
// verifico se a query foi correto
if (!$result) {
    die("Erro ao Executar Sql!!" . $conection->connect_error);
}
// insiro os registro do banco de dados na tabela 
// procuro solicitante
$c_responsavel = $_SESSION['c_usuario'];
$c_sql_responsavel = "Select id from usuarios where login='$c_responsavel'";
$result_responsavel = $conection->query($c_sql_responsavel);
$registro_responsavel = $result_responsavel->fetch_assoc();
$i_id_solicitante = $registro_responsavel['id'];
$d_data_geracao =  date("Y-m-d");
$d_hora_geracao = date('H:i');
// data de inicio
$d_data_inicio = date("Y-m-d");
$d_hora_inicio = date('H:i');
// loop para recursos fisicos
while ($c_linha = $result->fetch_assoc()) {

    // variaveis para fazer o insert
    $i_id_recurso = $c_linha['id_recurso'];
    $i_id_oficina = $c_linha['id_oficina'];
    $i_id_setor   = $c_linha['id_setor'];
    $i_id_ocorrencia = $c_linha['id_ocorrencia'];
    //
    $c_tipo = $c_linha['tipo']; // recurso fisico, espaço fisico ou avulsa 
    $c_tipo_ordem = 'P'; // Preventiva 
    $c_descritivo = $c_linha['descritivo'];
    $c_descricao = 'Preventiva de '.$c_linha['recurso'];
    $c_tipo_preventiva = $c_linha['tipo_preventiva'];
    $i_id_preventiva = $c_linha['id'];
    // inserir dados da preventiva na tabela de ordens de serviços
    $c_sql = "insert into ordens (id_solicitante, id_responsavel, id_recurso, id_oficina, id_setor, data_inicio, hora_inicio, tipo,
    tipo_ordem, tipo_preventiva, descricao,  data_geracao, hora_geracao, status, id_ocorrencia, descritivo)
    value ('$i_id_solicitante', '$i_id_solicitante', '$i_id_recurso', '$i_id_oficina','$i_id_setor', '$d_data_inicio', '$d_hora_inicio',
    'R', 'P', '$c_tipo_preventiva', '$c_descritivo', '$d_data_geracao', '$d_hora_geracao', 'A', '$i_id_ocorrencia', '$c_descricao')";
    $resultado = $conection->query($c_sql);
    if (!$resultado) {
        die("Erro ao Executar Sql!!" . $conection->connect_error);
    }
    // mudança de dados da prevetiva gerada
    $i_periodicidade = $c_linha['periodicidade_geracao'];
    $c_dias = '+' . $i_periodicidade . ' days';
    $d_data_anterior = $c_linha['data_prox_realizacao'];
    $d_data_proxima = date('y-m-d', strtotime($c_dias, strtotime($c_linha['data_prox_realizacao']))); // incremento 1 dia a data do loop
    //
    $c_sql = "update preventivas set data_prox_realizacao='$d_data_proxima', data_ult_realizacao='$d_data_anterior'
    where id='$i_id_preventiva' ";
    $resultado = $conection->query($c_sql);
    if (!$resultado) {
        die("Erro ao Executar Sql!!" . $conection->connect_error);
    }
}

////////////////////////////////////////////////////
// rotina para gerar preventivas de espaços fisicos
////////////////////////////////////////////////////

$result = $conection->query($c_sql_espaco);
// verifico se a query foi correto
if (!$result) {
    die("Erro ao Executar Sql!!" . $conection->connect_error);
}
// loop para espaços fisicos
while ($c_linha = $result->fetch_assoc()) {
    // variaveis para fazer o insert
    $i_id_espaco = $c_linha['id_espaco'];
    $i_id_oficina = $c_linha['id_oficina'];
    $i_id_setor   = $c_linha['id_setor'];
    $i_id_ocorrencia = $c_linha['id_ocorrencia'];
    //
    $c_tipo = $c_linha['tipo']; // recurso fisico, espaço fisico ou avulsa 
    $c_tipo_ordem = 'P'; // Preventiva 
    $c_descritivo = $c_linha['descritivo'];
    $c_descricao = 'Preventiva de '.$c_linha['espaco'];
    $c_tipo_preventiva = $c_linha['tipo_preventiva'];

    $i_id_preventiva = $c_linha['id'];
    // inserir dados da preventiva na tabela de ordens de serviços
    $c_sql = "insert into ordens (id_solicitante, id_responsavel, id_espaco, id_oficina, id_setor, data_inicio, hora_inicio, tipo,
    tipo_ordem, tipo_preventiva, descricao,  data_geracao, hora_geracao, status, id_ocorrencia, descritivo)
    value ('$i_id_solicitante', '$i_id_solicitante', '$i_id_espaco', '$i_id_oficina', '$i_id_setor', '$d_data_inicio', '$d_hora_inicio',
    'E', 'P', '$c_tipo_preventiva', '$c_descritivo', '$d_data_geracao', '$d_hora_geracao', 'A', $i_id_ocorrencia, '$c_descricao')";
    $resultado = $conection->query($c_sql);
    if (!$resultado) {
        die("Erro ao Executar Sql!!" . $conection->connect_error);
    }
    // mudança de dados da prevetiva gerada
    $i_periodicidade = $c_linha['periodicidade_geracao'];
    $c_dias = '+' . $i_periodicidade . ' days';
    $d_data_anterior = $c_linha['data_prox_realizacao'];
    $d_data_proxima = date('y-m-d', strtotime($c_dias, strtotime($c_linha['data_prox_realizacao']))); // incremento 1 dia a data do loop
    

    $c_sql = "update preventivas set data_prox_realizacao='$d_data_proxima', data_ult_realizacao='$d_data_anterior'
    where id='$i_id_preventiva' ";
    $resultado = $conection->query($c_sql);
    if (!$resultado) {
        die("Erro ao Executar Sql!!" . $conection->connect_error);
    }
    //  chamo pagina com o resumo da geração de preventivas
    header('location: /gop/preventivas/preventivas_resumo.php');

}
// 
