<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}


include('links.php');
include('conexao.php');

// pego data do dia
date_default_timezone_set('America/Sao_Paulo');
$agora = date('Y-m-d');
// sql com as preventiva com data da próxima realização igual ou inferior a data do dia em recurso fisico
$c_sql_recurso = "SELECT preventivas.id, preventivas.id_oficina, preventivas.periodicidade_geracao, preventivas.calibracao, preventivas.id_recurso, recursos.descricao as recurso,
preventivas.data_ult_realizacao, preventivas.data_prox_realizacao, preventivas.gerar,
case
when preventivas.calibracao ='S' then 'Sim'
when preventivas.calibracao ='N' then 'Não'
END AS preventiva_calibracao
FROM preventivas 
JOIN recursos ON preventivas.id_recurso=recursos.id
where data_prox_realizacao<='$agora' and gerar = 'Sim'
ORDER BY preventivas.data_prox_realizacao desc";
// sql com as preventiva com data da próxima realização igual ou inferior a data do dia em espaço fisico
$c_sql_espaco = "SELECT preventivas.id, preventivas.periodicidade_geracao, preventivas.calibracao, preventivas.id_espaco, espacos.descricao as espaco,
preventivas.data_ult_realizacao, preventivas.data_prox_realizacao, preventivas.gerar, preventivas.id_ocorrencia,
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
$c_linha = $result->fetch_assoc();
// insiro os registro do banco de dados na tabela 
// procuro solicitante
$c_responsavel = $_SESSION['c_usuario'];
$c_sql_responsavel = "Select id from usuarios where login='$c_responsavel'";
$result_responsavel = $conection->query($c_sql_responsavel);
$registro_responsavel = $result_responsavel->fetch_assoc();
$i_id_solicitante = $registro_responsavel['id'];

// variaveis para fazer o insert
$i_id_recurso = $c_linha['id_recurso'];
$i_id_oficina = $c_linha['id_oficina'];
//
$d_data_geracao =  date("Y-m-d");
$d_hora_geracao = date('H:i');
$c_tipo = 'R'; // recurso fisico, espaço fisico ou avulsa 
$c_tipo_ordem = 'P'; // Preventiva 
$c_descritivo = $c_linha['descritivo'];

// data de inicio
$d_data_inicio = date("Y-m-d");
$d_hora_inicio = date('H:i');
$i_id_ocorrencia = $result['id_ocorrencia'];
//
?>
