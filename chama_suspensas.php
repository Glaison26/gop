<?php
///////////////////////////////////////////////////////////////
/// rotina para chamar ordens de serviço em aberto do menu principal
///////////////////////////////////////////////////////////////
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("conexao.php");
date_default_timezone_set('America/Sao_Paulo');
$c_data = date('Y-m-d');
$c_where = "ordens.`status`='S'";
$c_wheretipo_recurso =  " and ordens.tipo='R'";
$c_wheretipo_espaco =  " and ordens.tipo='E'";
$c_wheretipo_avulso =  " and ordens.tipo='V'";
// montagem do sql para recursos físicos
$c_sql_recurso = "SELECT ordens.id, ordens.id_solicitacao, ordens.data_geracao, ordens.hora_geracao, ordens.descritivo,
                    ordens.`status`, ordens.id_setor, ordens.tipo_ordem, ordens.id_solicitante, setores.descricao AS setor,
                    usuarios.nome, recursos.descricao, ordens.data_previsao, recursos.patrimonio,
                    case
                    when ordens.status='A' then 'Aberta'
                    when ordens.status='E' then 'Em Andamento'
                    when ordens.status='C' then 'Concluída'
                    when ordens.status='S' then 'Suspensa'
                    when ordens.status='X' then 'Cancelada'
                    END AS ordens_status,
                    case
                    when tipo_ordem='C' then 'Corretiva'
                    when tipo_ordem='P' then 'Preventiva'
                    END AS ordens_tipo_texto
                    FROM ordens
                    JOIN setores ON ordens.id_setor=setores.id
                    JOIN usuarios ON ordens.id_solicitante=usuarios.id
                    JOIN recursos on ordens.id_recurso=recursos.id
                    where $c_where";
// sql de espaços fisico
$c_sql_espaco = "SELECT ordens.id, ordens.id_solicitacao, ordens.data_geracao, ordens.hora_geracao, ordens.descritivo,
                    ordens.`status`, ordens.id_setor, ordens.tipo_ordem, ordens.id_solicitante, setores.descricao AS setor, ordens.data_previsao,
                    usuarios.nome, 
                    case
                    when ordens.status='A' then 'Aberta'
                    when ordens.status='E' then 'Em Andamento'
                    when ordens.status='C' then 'Concluída'
                     when ordens.status='S' then 'Suspensa'
                     when ordens.status='X' then 'Cancelada'
                    END AS ordens_status,
                    case
                    when tipo_ordem='C' then 'Corretiva'
                    when tipo_ordem='P' then 'Preventiva'
                    END AS ordens_tipo_texto
                    FROM ordens
                    JOIN setores ON ordens.id_setor=setores.id
                    JOIN usuarios ON ordens.id_solicitante=usuarios.id
                     where $c_where";
// sql para abertas
$c_sql_avulso = "SELECT ordens.id, ordens.id_solicitacao, ordens.data_geracao, ordens.hora_geracao, ordens.descritivo,
                    ordens.`status`, ordens.id_setor, ordens.tipo_ordem, ordens.id_solicitante, setores.descricao AS setor,ordens.data_previsao,
                    usuarios.nome,
                    case
                    when ordens.status='A' then 'Aberta'
                    when ordens.status='E' then 'Em Andamento'
                    when ordens.status='C' then 'Concluída'
                     when ordens.status='S' then 'Suspensa'
                     when ordens.status='X' then 'Cancelada'
                    END AS ordens_status,
                    case
                    when tipo_ordem='C' then 'Corretiva'
                    when tipo_ordem='P' then 'Preventiva'
                    END AS ordens_tipo_texto
                    FROM ordens
                    JOIN setores ON ordens.id_setor=setores.id
                    JOIN usuarios ON ordens.id_solicitante=usuarios.id
 
 where $c_where";
// sql para recurso, espaços e avulsas               
$c_sqlrecursos = $c_sql_recurso . $c_wheretipo_recurso;
$c_sqlespacos = $c_sql_espaco . $c_wheretipo_espaco;
$c_sqlavulso = $c_sql_avulso . $c_wheretipo_avulso;
// guardo session para proxima pagina de tabelas
$_SESSION['sqlrecurso'] = $c_sqlrecursos;
$_SESSION['sqlespaco'] = $c_sqlespacos;
$_SESSION['sqlavulso'] = $c_sqlavulso;
$_SESSION['pesquisamenu'] = true;

echo $c_sqlrecursos;
//echo '----------------------------';
//echo $c_sqlespacos;
//echo '----------------------------';
//echo $c_sqlavulso;
header('location: /gop/ordens/ordens_lista.php');
