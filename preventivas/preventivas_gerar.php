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
 preventivas.periodicidade_geracao, preventivas.id_recurso, recursos.descricao as recurso,
preventivas.data_ult_realizacao, preventivas.data_prox_realizacao, preventivas.tipo_preventiva, 
preventivas.descritivo, preventivas.gerar, preventivas.id_ocorrencia, prazo_atendimento, preventivas.id_executor
FROM preventivas 
JOIN recursos ON preventivas.id_recurso=recursos.id
where data_prox_realizacao<='$agora' and gerar = 'Sim'
ORDER BY preventivas.data_prox_realizacao desc";
//echo $c_sql_recurso;
// sql com as preventiva com data da próxima realização igual ou inferior a data do dia em espaço fisico
$c_sql_espaco = "SELECT preventivas.id, preventivas.tipo, preventivas.id_oficina, preventivas.tipo_preventiva, 
preventivas.periodicidade_geracao, preventivas.descritivo, preventivas.id_setor, preventivas.id_espaco, 
espacos.descricao as espaco, preventivas.data_ult_realizacao, preventivas.data_prox_realizacao,
 preventivas.gerar, preventivas.id_ocorrencia, prazo_atendimento, preventivas.id_executor
FROM preventivas 
JOIN espacos ON preventivas.id_espaco=espacos.id
where data_prox_realizacao<='$agora'
ORDER BY preventivas.data_prox_realizacao desc";
// sql com as preventivas sem viculo com espaços fisicos e recursos fisicos
$c_sql_geral = "SELECT preventivas.id, preventivas.tipo, preventivas.id_oficina, preventivas.tipo_preventiva, 
preventivas.periodicidade_geracao, preventivas.descritivo, preventivas.id_setor, preventivas.id_espaco, 
 preventivas.data_ult_realizacao, preventivas.data_prox_realizacao, ocorrencias.descricao as ocorrencia,
 preventivas.gerar, preventivas.id_ocorrencia, prazo_atendimento, preventivas.id_executor

FROM preventivas 
join ocorrencias on preventivas.id_ocorrencia=ocorrencias.id
where data_prox_realizacao<='$agora' and preventivas.tipo = 'V'
ORDER BY preventivas.data_prox_realizacao desc";
//echo $c_sql_geral;
//die();


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
// loop parapreventivas de recursos fisicos
while ($c_linha = $result->fetch_assoc()) {

    // variaveis para fazer o insert
    $i_id_recurso = $c_linha['id_recurso'];
    $i_id_oficina = $c_linha['id_oficina'];
    $i_id_setor   = $c_linha['id_setor'];
    $i_id_ocorrencia = $c_linha['id_ocorrencia'];
    $i_id_responsavel = $c_linha['id_executor'];
    $i_id_executor_responsavel = $c_linha['id_executor'];
    //
    $c_tipo = $c_linha['tipo']; // recurso fisico, espaço fisico ou avulsa 
    $c_tipo_ordem = 'P'; // Preventiva 
    $c_descritivo = $c_linha['descritivo'];
    $c_descricao = 'Preventiva de ' . $c_linha['recurso'];
    $c_tipo_preventiva = $c_linha['tipo_preventiva'];
    $i_id_preventiva = $c_linha['id'];
    $c_prazo = $c_linha['prazo_atendimento'];
    $c_dias = '+' . $c_prazo . ' days';
    $d_data_previsao = date('y-m-d', strtotime($c_dias, strtotime($d_data_geracao))); // incremento 1 dia a data do loop

    // inserir dados da preventiva na tabela de ordens de serviços
    $c_sql = "insert into ordens (id_solicitante, id_responsavel, id_recurso, id_oficina, id_setor, data_inicio, hora_inicio, tipo,
    tipo_ordem, tipo_preventiva, descricao,  data_geracao, hora_geracao, status, id_ocorrencia, descritivo, data_previsao, hora_previsao, id_executor_responsavel)
    value ('$i_id_solicitante', '$i_id_solicitante', '$i_id_recurso', '$i_id_oficina','$i_id_setor', '$d_data_inicio', '$d_hora_inicio',
    'R', 'P', '$c_tipo_preventiva', '$c_descritivo', '$d_data_geracao', '$d_hora_geracao', 'A',
    '$i_id_ocorrencia', '$c_descricao', '$d_data_previsao', '$d_hora_geracao', '$i_id_executor_responsavel')";
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
    // pego id da ultima ordem gerada para acrescentar anexos
    $c_sql_ultimo =  "SELECT MAX(ordens.ID) AS id_ordem FROM ordens";
    $result_ultimo = $conection->query($c_sql_ultimo);
    $c_linha_ultimo = $result_ultimo->fetch_assoc();
    $id_ordem_ultimo = $c_linha_ultimo['id_ordem'];  // id da ultima ordem gerada
    //// gerar materiais constantes na preventiva nos materiais da ordem de serviço
    $c_sql_materiais = "select * from preventivas_materiais where id_preventiva='$i_id_preventiva'";
    $result_material = $conection->query($c_sql_materiais);
    // loop para inserir materiais
    while ($c_linha_material = $result_material->fetch_assoc()) {
        $c_sql_mat_ordem = "insert into ordens_materiais (id_ordem, id_material, id_unidade, quantidade) value 
        ('$id_ordem_ultimo', '$c_linha_material[id_material]', '$c_linha_material[id_unidade]', '$c_linha_material[quantidade]')";
        $resultado_mat = $conection->query($c_sql_mat_ordem);
    }
    // gerar executores de serviços
    $c_sql_executores = "select * from preventivas_executores where id_preventiva='$i_id_preventiva'";
    $result_executores = $conection->query($c_sql_executores);
    // loop para inserir executores
    while ($c_linha_executor = $result_executores->fetch_assoc()) {
        $c_sql_exec_ordem = "insert into ordens_executores (id_ordem, id_executor) value ('$id_ordem_ultimo','$c_linha_executor[id_executor]')";
        $result_exec = $conection->query($c_sql_exec_ordem);
    }
    // gerar pops de serviços
    $c_sql_pop = "select * from preventivas_pop where id_preventiva='$i_id_preventiva'";
    $result_pops = $conection->query($c_sql_pop);
    // loop para inserir pop
    while ($c_linha_pop = $result_pops->fetch_assoc()) {
        $c_sql_pop_ordem = "insert into ordens_pop (id_ordem, id_pop) value ('$id_ordem_ultimo','$c_linha_pop[id_pop]')";
        $result_pop = $conection->query($c_sql_pop_ordem);
    }
    // gerar checklist de serviços
    $c_sql_check = "select * from preventivas_checklist where id_preventiva='$i_id_preventiva'";
    $result_checks = $conection->query($c_sql_check);
    // loop para inserir pop
    while ($c_linha_check = $result_checks->fetch_assoc()) {
        $c_sql_check_ordem = "insert into ordens_check (id_ordem, id_check) value ('$id_ordem_ultimo','$c_linha_check[id_check]')";
        $result_check = $conection->query($c_sql_check_ordem);
    }
    // gerar ferramentas de serviços
    $c_sql_ferramenta = "select * from preventivas_ferramentas where id_preventiva='$i_id_preventiva'";
    $result_ferramentas = $conection->query($c_sql_ferramenta);
    // loop para inserir pop
    while ($c_linha_ferramenta = $result_ferramentas->fetch_assoc()) {
        $c_sql_ferramenta_ordem = "insert into ordens_ferramentas (id_ordem, id_ferramenta) value ('$id_ordem_ultimo','$c_linha_ferramenta[id_ferramenta]')";
        $result_ferramenta = $conection->query($c_sql_ferramenta_ordem);
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
    $i_id_responsavel = $c_linha['id_executor'];
    //
    $c_tipo = $c_linha['tipo']; // recurso fisico, espaço fisico ou avulsa 
    $c_tipo_ordem = 'P'; // Preventiva 
    $c_descritivo = $c_linha['descritivo'];
    $c_descricao = 'Preventiva de ' . $c_linha['espaco'];
    $c_tipo_preventiva = $c_linha['tipo_preventiva'];
    $c_prazo = $c_linha['prazo_atendimento'];
    $c_dias = '+' . $c_prazo . ' days';
    $d_data_previsao = date('y-m-d', strtotime($c_dias, strtotime($d_data_geracao))); // incremento 1 dia a data do loop

    $i_id_preventiva = $c_linha['id'];
    // inserir dados da preventiva na tabela de ordens de serviços
    $c_sql = "insert into ordens (id_solicitante, id_responsavel, id_espaco, id_oficina, id_setor, data_inicio, hora_inicio, tipo, 
    tipo_ordem, tipo_preventiva, descricao,  data_geracao, hora_geracao, status, id_ocorrencia, descritivo, data_previsao, hora_previsao, id_executor_responsavel)
    value ('$i_id_solicitante', '$i_id_responsavel', '$i_id_espaco', '$i_id_oficina', '$i_id_setor', '$d_data_inicio', '$d_hora_inicio',
    'E', 'P', '$c_tipo_preventiva', '$c_descritivo', '$d_data_geracao', '$d_hora_geracao', 'A',
     $i_id_ocorrencia, '$c_descricao', '$d_data_previsao', '$d_hora_geracao', '$i_id_responsavel')";
    echo $c_sql;
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
    // pego id da ultima ordem gerada para acrescentar anexos
    $c_sql_ultimo =  "SELECT MAX(ordens.ID) AS id_ordem FROM ordens";
    $result_ultimo = $conection->query($c_sql_ultimo);
    $c_linha_ultimo = $result_ultimo->fetch_assoc();
    $id_ordem_ultimo = $c_linha_ultimo['id_ordem'];  // id da ultima ordem gerada
    //// gerar materiais constantes na preventiva nos materiais da ordem de serviço
    $c_sql_materiais = "select * from preventivas_materiais where id_preventiva='$i_id_preventiva'";
    $result_material = $conection->query($c_sql_materiais);
    // loop para inserir materiais
    while ($c_linha_material = $result_material->fetch_assoc()) {
        $c_sql_mat_ordem = "insert into ordens_materiais (id_ordem, id_material, id_unidade, quantidade) value 
            ('$id_ordem_ultimo', '$c_linha_material[id_material]', '$c_linha_material[id_unidade]', '$c_linha_material[quantidade]')";
        $resultado_mat = $conection->query($c_sql_mat_ordem);
    }
    // gerar executores de serviços
    $c_sql_executores = "select * from preventivas_executores where id_preventiva='$i_id_preventiva'";
    $result_executores = $conection->query($c_sql_executores);
    // loop para inserir executores
    while ($c_linha_executor = $result_executores->fetch_assoc()) {
        $c_sql_exec_ordem = "insert into ordens_executores (id_ordem, id_executor) value ('$id_ordem_ultimo','$c_linha_executor[id_executor]')";
        $result_exec = $conection->query($c_sql_exec_ordem);
    }
    // gerar pops de serviços
    $c_sql_pop = "select * from preventivas_pop where id_preventiva='$i_id_preventiva'";
    $result_pops = $conection->query($c_sql_pop);
    // loop para inserir pop
    while ($c_linha_pop = $result_pops->fetch_assoc()) {
        $c_sql_pop_ordem = "insert into ordens_pop (id_ordem, id_pop) value ('$id_ordem_ultimo','$c_linha_pop[id_pop]')";
        $result_pop = $conection->query($c_sql_pop_ordem);
    }
    // gerar checklist de serviços
    $c_sql_check = "select * from preventivas_checklist where id_preventiva='$i_id_preventiva'";
    $result_checks = $conection->query($c_sql_check);
    // loop para inserir pop
    while ($c_linha_check = $result_checks->fetch_assoc()) {
        $c_sql_check_ordem = "insert into ordens_check (id_ordem, id_check) value ('$id_ordem_ultimo','$c_linha_check[id_check]')";
        $result_check = $conection->query($c_sql_check_ordem);
    }
    // gerar ferramentas de serviços
    $c_sql_ferramenta = "select * from preventivas_ferramentas where id_preventiva='$i_id_preventiva'";
    $result_ferramentas = $conection->query($c_sql_ferramenta);
    // loop para inserir pop
    while ($c_linha_ferramenta = $result_ferramentas->fetch_assoc()) {
        $c_sql_ferramenta_ordem = "insert into ordens_ferramentas (id_ordem, id_ferramenta) value ('$id_ordem_ultimo','$c_linha_ferramenta[id_ferramenta]')";
        $result_ferramenta = $conection->query($c_sql_ferramenta_ordem);
    }
}

////////////////////////////////////
// geração para preventivas sem vinculo
////////////////////////////////////

$result = $conection->query($c_sql_geral);
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
// loop parapreventivas de recursos fisicos

while ($c_linha = $result->fetch_assoc()) {

    // variaveis para fazer o insert

    $i_id_oficina = $c_linha['id_oficina'];
    $i_id_setor   = $c_linha['id_setor'];
    $i_id_ocorrencia = $c_linha['id_ocorrencia'];
    $i_id_responsavel = $c_linha['id_executor'];
    $i_id_executor_responsavel = $c_linha['id_executor'];
    //
    $c_tipo = $c_linha['tipo']; // recurso fisico, espaço fisico ou avulsa 
    $c_tipo_ordem = 'P'; // Preventiva 
    $c_descritivo = $c_linha['descritivo'];
    $c_descricao = 'Preventiva de ' . $c_linha['ocorrencia'];
    $c_tipo_preventiva = $c_linha['tipo_preventiva'];
    $i_id_preventiva = $c_linha['id'];
    $c_prazo = $c_linha['prazo_atendimento'];
    $c_dias = '+' . $c_prazo . ' days';
    $d_data_previsao = date('y-m-d', strtotime($c_dias, strtotime($d_data_geracao))); // incremento 1 dia a data do loop

    // inserir dados da preventiva na tabela de ordens de serviços
    $c_sql = "insert into ordens (id_solicitante, id_responsavel,  id_oficina, id_setor, data_inicio, hora_inicio, tipo,
    tipo_ordem, tipo_preventiva, descricao,  data_geracao, hora_geracao, status, id_ocorrencia, descritivo, data_previsao, hora_previsao, id_executor_responsavel)
    value ('$i_id_solicitante', '$i_id_solicitante',  '$i_id_oficina','$i_id_setor', '$d_data_inicio', '$d_hora_inicio',
    'V', 'P', '$c_tipo_preventiva', '$c_descritivo', '$d_data_geracao', '$d_hora_geracao', 'A',
    '$i_id_ocorrencia', '$c_descricao', '$d_data_previsao', '$d_hora_geracao', '$i_id_executor_responsavel')";
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
    // pego id da ultima ordem gerada para acrescentar anexos
    $c_sql_ultimo =  "SELECT MAX(ordens.ID) AS id_ordem FROM ordens";
    $result_ultimo = $conection->query($c_sql_ultimo);
    $c_linha_ultimo = $result_ultimo->fetch_assoc();
    $id_ordem_ultimo = $c_linha_ultimo['id_ordem'];  // id da ultima ordem gerada
    //// gerar materiais constantes na preventiva nos materiais da ordem de serviço
    $c_sql_materiais = "select * from preventivas_materiais where id_preventiva='$i_id_preventiva'";
    $result_material = $conection->query($c_sql_materiais);
    // loop para inserir materiais
    while ($c_linha_material = $result_material->fetch_assoc()) {
        $c_sql_mat_ordem = "insert into ordens_materiais (id_ordem, id_material, id_unidade, quantidade) value 
        ('$id_ordem_ultimo', '$c_linha_material[id_material]', '$c_linha_material[id_unidade]', '$c_linha_material[quantidade]')";
        $resultado_mat = $conection->query($c_sql_mat_ordem);
    }
    // gerar executores de serviços
    $c_sql_executores = "select * from preventivas_executores where id_preventiva='$i_id_preventiva'";
    $result_executores = $conection->query($c_sql_executores);
    // loop para inserir executores
    while ($c_linha_executor = $result_executores->fetch_assoc()) {
        $c_sql_exec_ordem = "insert into ordens_executores (id_ordem, id_executor) value ('$id_ordem_ultimo','$c_linha_executor[id_executor]')";
        $result_exec = $conection->query($c_sql_exec_ordem);
    }
    // gerar pops de serviços
    $c_sql_pop = "select * from preventivas_pop where id_preventiva='$i_id_preventiva'";
    $result_pops = $conection->query($c_sql_pop);
    // loop para inserir pop
    while ($c_linha_pop = $result_pops->fetch_assoc()) {
        $c_sql_pop_ordem = "insert into ordens_pop (id_ordem, id_pop) value ('$id_ordem_ultimo','$c_linha_pop[id_pop]')";
        $result_pop = $conection->query($c_sql_pop_ordem);
    }
    // gerar checklist de serviços
    $c_sql_check = "select * from preventivas_checklist where id_preventiva='$i_id_preventiva'";
    $result_checks = $conection->query($c_sql_check);
    // loop para inserir pop
    while ($c_linha_check = $result_checks->fetch_assoc()) {
        $c_sql_check_ordem = "insert into ordens_check (id_ordem, id_check) value ('$id_ordem_ultimo','$c_linha_check[id_check]')";
        $result_check = $conection->query($c_sql_check_ordem);
    }
    // gerar ferramentas de serviços
    $c_sql_ferramenta = "select * from preventivas_ferramentas where id_preventiva='$i_id_preventiva'";
    $result_ferramentas = $conection->query($c_sql_ferramenta);
    // loop para inserir pop
    while ($c_linha_ferramenta = $result_ferramentas->fetch_assoc()) {
        $c_sql_ferramenta_ordem = "insert into ordens_ferramentas (id_ordem, id_ferramenta) value ('$id_ordem_ultimo','$c_linha_ferramenta[id_ferramenta]')";
        $result_ferramenta = $conection->query($c_sql_ferramenta_ordem);
    }
}

//  chamo pagina com o resumo da geração de preventivas
header('location: /gop/preventivas/preventivas_resumo.php');
// 
