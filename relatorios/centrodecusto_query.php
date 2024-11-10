<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
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

    // sql para tipo de atendimento (programada ou urgência)
    $c_tipo_atendimento = $_POST['tipo'];

    if ($c_tipo_atendimento == "1") {  // corretiva
        $c_where = $c_where . "ordens.tipo_ordem='C' and ";
        $c_query = $c_query . 'Corretivas -';
        // sql para tipo de ordem corretiva (programada ou urgência)
        $c_tipo = $_POST['tipo_corretiva'];
        if ($c_tipo == "Programada") {
            $c_where = $c_where . "ordens.tipo_corretiva='P' and ";
            $c_query = $c_query . 'Programadas -';
        }
        if ($c_tipo == "Urgênte") {
            $c_where = $c_where . "ordens.tipo_corretiva='U' and ";
            $c_query = $c_query . 'Urgêntes -';
        }
    }
    // preventiva
    if ($c_tipo_atendimento == "2") { // preventiva
        $c_where = $c_where . "ordens.tipo_ordem='P' and ";
        $c_query = $c_query . 'Preventivas -';
    }
    // sql para status
    $c_status = $_POST['status'];
    if ($c_status == "Aberta") {
        $c_where = $c_where . "ordens.status='A' and ";
        $c_query = $c_query . 'Abertas -';
    }
    if ($_POST['status'] == "Em Andamento") {
        $c_where = $c_where . "ordens.status='E' and ";
        $c_query = $c_query . 'Em andamento -';
    }
    if ($_POST['status'] == "Concluída") {
        $c_where = $c_where . "ordens.status='C' and ";
        $c_query = $c_query . 'Concluídas -';
    }
    if ($_POST['status'] == "Suspensa") {
        $c_where = $c_where . "ordens.status='S' and ";
        $c_query = $c_query . 'Suspensas -';
    }
    if ($_POST['status'] == "Cancelada") {
        $c_where = $c_where . "ordens.status='X' and ";
        $c_query = $c_query . 'Canceladas -';
    }

    // sql para solicitante
    if ($_POST["solicitante"] <> "Todos") {
        $c_solicitante = $_POST["solicitante"];
        $c_sql_solicitante = "select usuarios.id, usuarios.nome from usuarios where usuarios.nome = '$c_solicitante'";
        $result = $conection->query($c_sql_solicitante);
        $c_linha = $result->fetch_assoc();
        $i_id_solicitante = $c_linha['id'];
        $c_where = $c_where . "ordens.id_solicitante='$i_id_solicitante' and ";
        $c_query = $c_query . 'Solicitante:'. $c_linha['id']. '-';
    }
    // sql para setor
    if ($_POST["setor"] <> "Todos") {
        $c_setor = $_POST["setor"];
        $c_sql_setor = "select setores.id, setores.descricao from setores where setores.descricao = '$c_setor'";
        $result = $conection->query($c_sql_setor);
        $c_linha = $result->fetch_assoc();
        $i_id_setor = $c_linha['id'];
        $c_where = $c_where . "ordens.id_setor='$i_id_setor' and ";
        $c_query = $c_query . 'Setor:'. $c_linha['descricao']. '-';
    }
    // sql para oficinas
    if ($_POST['oficina'] <> "Todas") {
        $c_oficina = $_POST["oficina"];
        $c_sql_oficina = "select oficinas.id, oficinas.descricao from oficinas where oficinas.descricao = '$c_oficina'";
        $result = $conection->query($c_sql_oficina);
        $c_linha = $result->fetch_assoc();
        $i_id_oficina = $c_linha['id'];
        $c_where = $c_where . "ordens.id_oficina='$i_id_oficina' and ";
        $c_query = $c_query . 'Oficina:'. $c_linha['descricao']. '-';
    }

    $c_where = $c_where = substr($c_where, 0, -5); // tirar o and no final
    // montagem do sql para recursos físicos
    //
    $c_sql = "SELECT centrodecusto.id, centrodecusto.descricao, COUNT(centrodecusto.id) AS total FROM ordens
            JOIN setores ON ordens.id_setor=setores.id
            JOIN centrodecusto ON setores.id_centrodecusto=centrodecusto.id
            where $c_where
            GROUP BY centrodecusto.id order by total desc";
             
    // guardo session para proxima pagina de tabelas
    $_SESSION['sql'] = $c_sql;
    if (empty($c_query))
        $_SESSION['query'] = "Nenhum";
    else
        $_SESSION['query'] = $c_query;
    //echo $c_sql;
    echo "<script> window.open('/gop/relatorios/centrodecusto_relatorio.php?id=', '_blank');</script>";
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
            <h5>Opções para Relatório de Centros de Custo<h5>
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

            <div class="row mb-3">

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
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Oficina </label>
                <div class="col-sm-3">
                    <select class="form-select form-select-lg mb-3" id="oficina" name="oficina">
                        <option>Todas</option>
                        <?php
                        // select da tabela de setores
                        $c_sql_setor = "SELECT oficinas.id, oficinas.descricao FROM oficinas ORDER BY oficinas.descricao";
                        $result_setor = $conection->query($c_sql_setor);
                        while ($c_linha = $result_setor->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
                <label class="col-sm-1 col-form-label">Tipo</label>
                <div class="col-sm-2">
                    <select onchange="verifica(value)" class="form-select form-select-lg mb-3" id="tipo" name="tipo" value="<?php echo $c_tipo; ?>">
                        <option value="0">Todas</option>
                        <option value="1">Corretiva</option>
                        <option value="2">Preventiva</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Tipo Corretiva</label>
                <div class="col-sm-2">
                    <select disabled class="form-select form-select-lg mb-3" id="tipo_corretiva" name="tipo_corretiva" value="<?php echo $c_tipo_corretiva; ?>">
                        <option>Todos</option>
                        <option>Programada</option>
                        <option>Urgênte</option>
                    </select>
                </div>
                <label class="col-sm-2 col-form-label">Tipo Preventiva</label>
                <div class="col-sm-2">
                    <select disabled class="form-select form-select-lg mb-3" id="tipo_preventiva" name="tipo_preventiva" value="<?php echo $c_tipo_preventiva; ?>">
                        <option>Todas</option>
                        <option>Rotina</option>
                        <option>Preditiva</option>
                        <option>Sistematica</option>
                    </select>
                </div>
            </div>


            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Status</label>
                <div class="col-sm-3">
                    <select class="form-select form-select-lg mb-3" id="status" name="status" value="<?php echo $c_status; ?>">
                        <option>Todos</option>
                        <option>Aberta</option>
                        <option>Concluída</option>
                        <option>Suspensa</option>
                        <option>Cancelada</option>
                    </select>
                </div>
            </div>
        </form>
    </div>

</body>

</html>