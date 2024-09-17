<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("conexao.php");
include("links2.php");


// rotina para montagem do sql com as opções selecionadas
if ((isset($_POST["btnpesquisa"])) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {

    // formatação de datas para o sql
    $d_data1 = $_POST['data1'];
    $d_data1 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data1)));
    $d_data2 = $_POST['data2'];
    $d_data2 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data2)));
    // expressão sql inicia para recursos fisicos
    // data de abertura
    if ($_POST['numero'] == '') {
        $c_where = "(data_abertura>='$d_data1' and data_abertura<='$d_data2') and ";
    }
    // sql para status
    $c_status = $_POST['status'];
    if ($c_status == "Aberta") {
        $c_where = $c_where . "solicitacao.status='A' and ";
    }
    if ($_POST['status'] == "Em Andamento") {
        $c_where = $c_where . "solicitacao.status='E' and ";
    }
    if ($_POST['status'] == "Concluída") {
        $c_where = $c_where . "solicitacao.status='C' and ";
    }
    // sql para tipo de solicitação (programada ou urgência)
    $c_tipo = $_POST['tipo'];
    if ($c_tipo == "Programada") {
        $c_where = $c_where . "solicitacao.tipo='P' and ";
    }
    if ($c_tipo == "Urgência") {
        $c_where = $c_where . "solicitacao.tipo='U' and ";
    }
    // sql para solicitante
    if ($_POST["solicitante"] <> "Todos") {
        $c_solicitante = $_POST["solicitante"];
        $c_sql_solicitante = "select usuarios.id, usuarios.nome from usuarios where usuarios.nome = '$c_solicitante'";
        $result = $conection->query($c_sql_solicitante);
        $c_linha = $result->fetch_assoc();
        $i_id_solicitante = $c_linha['id'];
        $c_where = $c_where . "solicitacao.id_solicitante='$i_id_solicitante' and ";
    }
    // sql para setor
    if ($_POST["setor"] <> "Todos") {
        $c_setor = $_POST["setor"];
        $c_sql_setor = "select setores.id, setores.descricao from setores where setores.descricao = '$c_setor'";
        $result = $conection->query($c_sql_setor);
        $c_linha = $result->fetch_assoc();
        $i_id_setor = $c_linha['id'];
        $c_where = $c_where . "solicitacao.id_setor='$i_id_setor' and ";
    }
    if ($_POST['descritivo'] <> '') {
        $c_descritivo = $_POST['descritivo'];
        $c_where = $c_where . "solicitacao.descricao LIKE '%$c_descritivo%' and ";
    }
    if ($_POST['numero'] <> '') {
        $c_numero = $_POST['numero'];
        $c_where = $c_where . "solicitacao.id = '$c_numero' and ";
    }
    $c_where = $c_where = substr($c_where, 0, -5); // tirar o and no final
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
                    where $c_where" . " order by solicitacao.data_abertura desc";
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
                    where $c_where" . " order by solicitacao.data_abertura desc";
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
                    where $c_where and classificacao='V'" . " order by solicitacao.data_abertura desc";
    // chamo pagina com os dados a serem selecionados passando a string sql
    $_SESSION['sqlrecurso'] = $c_sqlrecursos;
    $_SESSION['sqlespaco'] = $c_sqlespacos;
    $_SESSION['sqlavulso'] = $c_sqlavulso;
    $_SESSION['pesquisamenu'] = false;
    header('location: /gop/solicitacao_lista.php');
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
        var input_recurso = document.getElementById("recurso");
        var input_espaco = document.getElementById("espaco");

        if (value == 1) {
            input_recurso.disabled = false;
            input_espaco.disabled = true;
        } else if (value == 2) {
            input_recurso.disabled = true;
            input_espaco.disabled = false;
        }
    };
</script>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Solicitações de Serviços<h5>
        </div>
    </div>

    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Clique em nova solitação para abrir uma nova solicitação de serviço ou realize uma pesquisa com as opções de pesquisa abaixo</h5>
        </div>
        <form method="post">
            <div style="padding-top:5px;padding-bottom:15px">
                <a class="btn btn btn-sm" href="solicitacao_nova.php"><img src="\gop\images\contato.png" alt="" width="25" height="25"> Nova Solicitação</a>
                <button type="submit" name='btnpesquisa' id='btnpesquisa' class="btn btn btn-sm"><img src="\gop\images\lupa.png" alt="" width="20" height="20"></span> Pesquisar</button>
            
                <!--<a class="btn btn btn-sm" href="#"><img src="\gop\images\eraser.png" alt="" width="25" height="25"> Limpar pesquisa</a> -->
                <a class="btn btn btn-sm" href="\gop\menu.php"><img src="\gop\images\voltar.png" alt="" width="25" height="25"> Voltar</a>
            </div>
            <div class="card">
                <div class="card-header">
                    <h5 class="text-center">Opções para pesquisa</h5>
                </div>
                <div class="form-group">
                    <div style="padding-top:15px;">
                        <label class="col-md-2 form-label">No. da Solicitação</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" name="numero" id="numero">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div style="padding-top:15px;">
                        <label class="col-md-2 form-label">De</label>
                        <div class="col-sm-2">
                            <input type="Date" class="form-control" name="data1" id="data1" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                        </div>
                        <label class="col-md-1 form-label">até</label>
                        <div class="col-sm-2">
                            <input type="Date" class="form-control" name="data2" id="data2" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                        </div>

                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 col-form-label">Status</label>
                    <div class="col-sm-2">
                        <select class="form-select form-select-lg mb-3" id="status" name="status" value="<?php echo $c_status; ?>">
                            <option>Todos</option>
                            <option>Aberta</option>
                            <option>Em Andamento</option>
                            <option>Concluída</option>
                        </select>
                    </div>
                    <label class="col-sm-1 col-form-label">Tipo</label>
                    <div class="col-sm-2">
                        <select class="form-select form-select-lg mb-3" id="tipo" name="tipo" value="<?php echo $c_tipo; ?>">
                            <option>Todos</option>
                            <option>Programada</option>
                            <option>Urgência</option>
                        </select>
                    </div>


                </div>
                <div class="form-group">

                    <label class="col-sm-2 col-form-label">Solicitante </label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="solicitante" name="solicitante">
                            <option>Todos</option>
                            <?php
                            // select da tabela de solicitantes
                            $c_sql_sol = "SELECT usuarios.id, usuarios.nome FROM usuarios ORDER BY usuarios.nome";
                            $result_sol = $conection->query($c_sql_sol);
                            while ($c_linha = $result_sol->fetch_assoc()) {
                                echo "  
                          <option>$c_linha[nome]</option>
                        ";
                            }
                            ?>
                        </select>
                    </div>
                    <label class="col-sm-1 col-form-label">Setor </label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="setor" name="setor">
                            <option>Todos</option>
                            <?php
                            // select da tabela de setores
                            $c_sql_setor = "SELECT setores.id, setores.descricao FROM setores ORDER BY setores.descricao";
                            $result_setor = $conection->query($c_sql_setor);
                            while ($c_linha = $result_setor->fetch_assoc()) {
                                echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                            }
                            ?>
                        </select>
                    </div>

                </div>
                <div class="form-group">

                </div>
                <div class="form-group">
                    <label class="col-md-2 form-label">Descritivo</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" name="descritivo" id="descritivo">
                    </div>
                </div>

            </div>

        </form>
    </div>



</body>

</html>