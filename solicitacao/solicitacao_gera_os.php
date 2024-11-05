<?php
//////////////////////////////////////////////////////////////////////
// rotina para geração da ordem de serviço através de uma solicitação
/////////////////////////////////////////////////////////////////////

session_start(); // controle de acesso ao formulário
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
date_default_timezone_set('America/Sao_Paulo');
$msg_erro = "";

// pego id da solicitação selecionado na página anterior
$i_id = $_GET["id"];

// rotina para geração de ordem de serviço
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $msg_erro = "";
    // procuro oficina selecionado
    $c_oficina = $_POST['oficina'];
    $c_sql_oficina = "Select id, email from oficinas where descricao='$c_oficina'";
    $result_oficina = $conection->query($c_sql_oficina);
    $registro_oficina = $result_oficina->fetch_assoc();

    // procuro solicitante
    $c_responsavel = $_SESSION['c_usuario'];
    $c_sql_responsavel = "Select id from usuarios where login='$c_responsavel'";
    $result_responsavel = $conection->query($c_sql_responsavel);
    $registro_responsavel = $result_responsavel->fetch_assoc();

    // select da solicitação para capturar dados 
    $c_sql_solicitacao = "select * from solicitacao where id='$i_id'";
    $result_solicitacao = $conection->query($c_sql_solicitacao);
    $registro_solicitacao = $result_solicitacao->fetch_assoc();
    // variaveis para fazer o insert
    $i_id_solicitante = $registro_solicitacao['id_solicitante'];
    $i_id_setor = $registro_solicitacao['id_setor'];
    if ($registro_solicitacao['classificacao'] == 'R') {
        $i_id_recurso = $registro_solicitacao['id_recursos'];
    } else {
        $i_id_recurso = 0;
    }
    if ($registro_solicitacao['classificacao'] == 'E') {
        $i_id_espaco = $registro_solicitacao['id_espaco'];
    } else {
        $i_id_espaco = 0;
    }
    $i_id_oficina = $registro_oficina['id'];
    $i_responsavel = $registro_responsavel['id'];
    $d_data_geracao =  date("Y-m-d");
    $d_hora_geracao = date('H:i');
    $c_tipo = $registro_solicitacao['classificacao']; // recurso fisico, espaço fisico ou avulsa 
    $c_tipo_ordem = 'C'; // corretiva 
    $c_tipo_corretiva = $registro_solicitacao['tipo']; // preventiva(normal) ou urgencia
    $c_descritivo = $_POST['descritivo'];
    $c_descricao = $registro_solicitacao['descricao'];
    // data de inicio
    $d_data_inicio = new DateTime($_POST['data_inicio']);
    $d_data_inicio = $d_data_inicio->format('Y-m-d');
    $d_hora_inicio = new DateTime($_POST['hora_inicio']);
    $d_hora_inicio = $d_hora_inicio->format('H:i');

    $d_data_previsao = new DateTime($_POST['data_sla']);
    $d_data_previsao = $d_data_previsao->format('Y-m-d');
    $d_hora_previsao =  new DateTime($_POST['hora_sla']);
    $d_hora_previsao = $d_hora_previsao->format('H:i');
    $i_id_ocorrencia = $registro_solicitacao['id_ocorrencia'];
    //echo $descritivo;

    do {
        // verificos se solicitação está aberta. Se não não deixo gerar ordem de serviço
        if ($registro_solicitacao['status'] <> 'A') {
            $msg_erro = " Já foi gerada ums Ordem de Serviço para esta Solicitação! Não foi possivel Gerar
             Ordem de Serviço! ";
            break;
        }
        // monto sql
        $c_sql = "Insert into ordens (id_solicitante,id_responsavel, id_setor, id_recurso
             , id_espaco, id_oficina, tipo, tipo_ordem, tipo_corretiva, descritivo
             , descricao, data_geracao, hora_geracao, data_previsao, hora_previsao, status, id_solicitacao, id_ocorrencia, data_inicio, hora_inicio) 
             value ('$i_id_solicitante', '$i_responsavel','$i_id_setor', '$i_id_recurso', 
             '$i_id_espaco', '$i_id_oficina', '$c_tipo', '$c_tipo_ordem', '$c_tipo_corretiva',
             '$c_descritivo', '$c_descricao', '$d_data_geracao', '$d_hora_geracao', 
             '$d_data_previsao', '$d_hora_previsao', 'A', '$i_id ', '$i_id_ocorrencia', '$d_data_inicio','$d_hora_inicio') ";
        $result = $conection->query($c_sql);
        $c_sql =    "SELECT MAX(ordens.ID) AS id_ordem FROM ordens";
        $result = $conection->query($c_sql);
        $c_linha = $result->fetch_assoc();
        $i_ordem = $c_linha['id_ordem'];

        // mudo status da solicitacao que gerou a ordem de serviços
        $c_sql = "Update solicitacao SET status = 'E', id_ordem='$i_ordem' where id='$i_id'";
        $result = $conection->query($c_sql);
        // envia email com numero da OS e previsão de atendimento para solicitante
        // procuro solicitante
        $c_sql_solicitante = "Select id, email from usuarios where id='$i_responsavel'";
        $result_solicitante = $conection->query($c_sql_solicitante);
        $registro_solicitante = $result_solicitante->fetch_assoc();
        $c_email = $registro_solicitante['email']; // email do solicitante
        $c_email_oficina = $registro_oficina['email']; // email da oficina selecionada na ordem de serviço
        //echo $c_email_oficina;
        
        // chamo o envio de email ordem de serviço gerada
        if (filter_var($c_email, FILTER_VALIDATE_EMAIL)) {
            $c_sql = "SELECT MAX(ordens.ID) AS id_ordens FROM ordens";
            $result = $conection->query($c_sql);
            $c_linha = $result->fetch_assoc();
            $ordem = $c_linha['id_ordens'];
            $c_data_inicio = new DateTime($_POST['data_inicio']);
            $c_data_inicio = $c_data_inicio->format('Y-m-d');
            $data = new DateTime($d_data_previsao);
            $data = $data->format('d-m-Y');
            $c_assunto = "Abertura de Ordem  de Serviço no GOP";
            $c_body = "A Ordem de serviço No.<b> $ordem da solicitação no. $i_id </b> foi gerada com suceso! Aguarde o atendimento <br>"
                . "Descrição da Solicitação :" . $c_descricao . "<br>" .
                " Previsão de execução: $data";
            include('../email_gop.php');
        }
      

        header('location: /gop/solicitacao/Ordem_gerada.php');
    } while (false);
}

?>

<!-- Frame da págiana para geração -->
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
            <h5>Geração de Ordem de Serviço<h5>
        </div>
    </div>

    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Informações para geração da Ordem de Serviço a partir da solicitação No. <?php echo $i_id ?>. Preencha as informações e clique em gerar Ordem de Serviço.</h5>
        </div>
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <div style='padding-left:15px;'>
                    
                </div>
                <h4><img Align='left' src='\gop\images\aviso.png' alt='30' height='35'> $msg_erro</h4>
            </div>
            ";
        }
        ?>
        <form method="post" onsubmit="return confirm('Confirma geração de Ordem de Serviço?')">
            <hr>
            <button type="submit" class="btn btn btn-sm" href=""><img src="\gop\images\ordem.png" alt="" width="25" height="25"> Gerar Ordem de Serviço</button>
            <a class="btn btn btn-sm" href="\gop\solicitacao\solicitacao_lista.php"><img src="\gop\images\saida.png" alt="" width="25" height="25"> Voltar</a>
            <hr>
            <div class="row mb-6">
                <label class="col-md-2 form-label">Data Inicio</label>
                <div class="col-sm-2">
                    <input type="Date" class="form-control" name="data1" id="data_inicio" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                </div>
                <label class="col-md-1 form-label">Hora</label>
                <div class="col-sm-2">
                    <input type="time" class="form-control" name="hora_inicio" id="hora_inicio" required>
                </div>
            </div>
            <br>
            <div class="row mb-6">
                <label class="col-md-2 form-label">Prazo SLA </label>
                <div class="col-sm-2">
                    <input type="Date" class="form-control" name="data_sla" id="data_sla" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                </div>
                <label class="col-md-1 form-label">Hora</label>
                <div class="col-sm-2">
                    <input type="time" class="form-control" name="hora_sla" id="hora_sla" required>
                </div>
            </div>
            <br>
            <div class="row mb-6">
                <label class="col-md-2 form-label">Descritivo</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" name="descritivo" id="descritivo" required>
                </div>
                <br>
            </div>
            <br>
            <div class="row mb-6">
                <label class="col-sm-2 col-form-label">Oficina </label>
                <div class="col-sm-3">
                    <select class="form-select form-select-lg mb-3" id="oficina" name="oficina" required>
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
            </div>
        </form>
    </div>

</body>

</html>