<?php
///////////////////////////////////////////////////////////////
/// rotina para chamar solicitações em aberto do menu principal
///////////////////////////////////////////////////////////////
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("conexao.php");

    // montagem do sql para recursos físicos
    $c_sqlrecursos = "SELECT solicitacao.id, solicitacao.data_abertura, solicitacao.hora_abertura, solicitacao.id_solicitante,
                    solicitacao.id_recursos, solicitacao.tipo,  solicitacao.`status`,
                    usuarios.nome AS solicitante, recursos.descricao AS recurso,
                    case 
                    WHEN solicitacao.tipo='P' THEN 'Programada'
                    ELSE 'Urgência'
                    END AS solicitacao_tipo,
                    case
                    when solicitacao.status='A' then 'Aberta'
                    when solicitacao.status='E' then 'Em Andamento'
                    when solicitacao.status='C' then 'Concluída'
                    END AS solicitacao_status
                    FROM solicitacao
                    JOIN usuarios ON solicitacao.id_solicitante=usuarios.id
                    JOIN recursos ON solicitacao.id_recursos=recursos.id
                    WHERE STATUS = 'A' order by solicitacao.data_abertura desc";
    // montagem do sql para espaços fisicos
    $c_sqlespacos = "SELECT solicitacao.id, solicitacao.data_abertura, solicitacao.hora_abertura, solicitacao.id_solicitante,
                    solicitacao.tipo,  solicitacao.`status`,
                    usuarios.nome AS solicitante, espacos.descricao AS espaco,
                    case 
                    WHEN solicitacao.tipo='P' THEN 'Programada'
                    ELSE 'Urgência'
                    END AS solicitacao_tipo,
                    case
                    when solicitacao.status='A' then 'Aberta'
                    when solicitacao.status='E' then 'Em Andamento'
                    when solicitacao.status='C' then 'Concluída'
                    END AS solicitacao_status
                    FROM solicitacao
                    JOIN usuarios ON solicitacao.id_solicitante=usuarios.id
                    JOIN espacos ON solicitacao.id_espaco=espacos.id               
                    WHERE STATUS = 'A' order by solicitacao.data_abertura desc";
    // montagem do sql para solicitações avulsas 
    $c_sqlavulso =  "SELECT solicitacao.id, solicitacao.data_abertura, solicitacao.hora_abertura, solicitacao.id_solicitante,
                    solicitacao.tipo,  solicitacao.`status`,
                    usuarios.nome AS solicitante, 
                    case 
                    WHEN solicitacao.tipo='P' THEN 'Programada'
                    ELSE 'Urgência'
                    END AS solicitacao_tipo,
                    case
                    when solicitacao.status='A' then 'Aberta'
                    when solicitacao.status='E' then 'Em Andamento'
                    when solicitacao.status='C' then 'Concluída'
                    END AS solicitacao_status
                    FROM solicitacao
                    JOIN usuarios ON solicitacao.id_solicitante=usuarios.id  
                    WHERE STATUS = 'A' and solicitacao.classificacao = 'V' order by solicitacao.data_abertura desc";
    // chamo pagina com os dados a serem selecionados passando a string sql
    $_SESSION['sqlrecurso'] = $c_sqlrecursos;
    $_SESSION['sqlespaco'] = $c_sqlespacos;
    $_SESSION['sqlavulso'] = $c_sqlavulso;
    $_SESSION['pesquisamenu'] = true;
    header('location: /gop/solicitacao_lista.php');


?>