<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("conexao.php");
include("links2.php");

if ($_SESSION['tiposolicitacao'] == 'R') { // recurso fisico
    // pego id do recurso selecionado na página anterior
    $i_id_recurso = $_GET["id"];
    // sql para pegar nome
    $c_sql = "SELECT recursos.id, recursos.descricao FROM recursos where recursos.id='$i_id_recurso'";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();
    $c_recurso = $registro['descricao'];
}
if ($_SESSION['tiposolicitacao'] == 'E') {  // espaço físico
    // pego id do recurso selecionado na página anterior
    $i_id_espaco = $_GET["id"];
    // sql para pegar nome
    $c_sql = "SELECT espacos.id, espacos.descricao FROM espacos where espacos.id='$i_id_espaco'";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();
    $c_espaco = $registro['descricao'];
}

$c_solicitacao = "";

// inclusão da solicitação no banco de dados

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    // procuro solicitante
    $c_solicitante = $_SESSION['c_usuario'];
    $c_sql_solicitante = "Select id,email from usuarios where login='$c_solicitante'";
    $result_solicitante = $conection->query($c_sql_solicitante);
    $registro_solicitante = $result_solicitante->fetch_assoc();
    $i_solicitante = $registro_solicitante['id'];
    $c_email = $registro_solicitante['email'];

    // tipo da solicitação
    if ($_POST['tipo'] == "Programada") {
        $c_tipo = "P";
    } else {
        $c_tipo = 'U';
    }
    // data de abertura
    date_default_timezone_set('America/Sao_Paulo');
    $d_data_abertura =   date("Y-m-d");
    $c_agora = date('H:i');
    $c_descricao = $_POST['solicitacao'];
    $msg_erro = "";
    do {

        if (($_POST['ocorrencia'] == '') || ($_POST['setor'] == '') || ($_POST['tipo'] == '') || ($_POST['solicitacao'] == '')) {
            $msg_erro = 'Todos os campos devem selecionados e preenchidos!!';
            break;
        }
        // procuro setor selecionado
        $c_setor = $_POST['setor'];
        $c_sql_setor = "Select id from setores where descricao='$c_setor'";
        $result_setor = $conection->query($c_sql_setor);
        $registro_setor = $result_setor->fetch_assoc();
        $i_setor = $registro_setor['id'];
        // select da tabela de ocorrencia
        $c_ocorrencia = $_POST['ocorrencia'];
        $c_sql_ocorrencia = "SELECT ocorrencias.id, ocorrencias.descricao FROM ocorrencias where descricao='$c_ocorrencia'";
        $result_ocorrencia = $conection->query($c_sql_ocorrencia);
        $c_linha = $result_ocorrencia->fetch_assoc();
        $i_ocorrencia = $c_linha['id'];
        //$d_data_abertura = $d_data_abertura->format('Y-m-d');
        // gravar informações 
        if ($_SESSION['tiposolicitacao'] == 'V') { // avulso
            $c_sql = "Insert into solicitacao (id_setor, id_solicitante, data_abertura, hora_abertura, 
                status, classificacao,tipo,descricao,id_ocorrencia) value ('$i_setor', '$i_solicitante',  '$d_data_abertura', 
                '$c_agora', 'A', 'V', '$c_tipo', '$c_descricao', $i_ocorrencia)";
        }
        if ($_SESSION['tiposolicitacao'] == 'R') { // recurso fisico
            $c_sql = "Insert into solicitacao (id_setor, id_solicitante, data_abertura, hora_abertura, 
            status, classificacao,tipo,descricao,  id_ocorrencia, id_recursos) value ('$i_setor', '$i_solicitante', '$d_data_abertura', 
            '$c_agora', 'A', 'R', '$c_tipo', '$c_descricao', '$i_ocorrencia', '$i_id_recurso')";
        }
        if ($_SESSION['tiposolicitacao'] == 'E') { // espaço fisico
            $c_sql = "Insert into solicitacao (id_setor, id_solicitante,id_espaco, data_abertura, hora_abertura, 
            status, classificacao,tipo,descricao, id_ocorrencia) value ('$i_setor', '$i_solicitante', '$i_id_espaco', '$d_data_abertura', 
            '$c_agora', 'A', 'E', '$c_tipo', '$c_descricao', $i_ocorrencia)";
        }
        echo $c_sql;
        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        // chamo o envio de email
        if (filter_var($c_email, FILTER_VALIDATE_EMAIL)) {
            $c_sql =    "SELECT MAX(solicitacao.ID) AS id_solicitacao FROM solicitacao";

            $result = $conection->query($c_sql);
            $c_linha = $result->fetch_assoc();
            $solicitacao = $c_linha['id_solicitacao'];
            $c_assunto = "Abertura de Solicitação de Serviço no GOP";
            $c_body = "Solicitação No.<b> $solicitacao </b> foi gerada com suceso! Aguarde o atendimento <br>"
                . "Descrição da Solicitação :" . $c_descricao;
            include('email_gop.php');
        }
        header('location: /gop/solicitacao_gerada.php?id_recurso=$i_id_recurso');



        //header('location: /gop/menu.php');
    } while (false);
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
            <h5>Conclusão de abertura de Solicitação de Serviço<h5>
        </div>
    </div>

    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Digite as informações da solicitação e clique em finalizar para gravar a solicitação. Todos os Campos são obrigatórios</h5>
        </div>
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                
                <h3><img Align='left' src='\gop\images\aviso.png' alt='30' height='35'><span>&nbsp;&nbsp;&nbsp; $msg_erro</span></h3>
            </div>
            ";
        }
        ?>
        <form method="post">


            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Tipo de Solicitação</label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="tipo" name="tipo" value="<?php echo $c_tipo; ?>">
                        <option></option>
                        <option>Programada</option>
                        <option>Urgência</option>

                    </select>
                </div>
                <label class="col-sm-2 col-form-label">Setor </label>
                <div class="col-sm-3">
                    <select class="form-select form-select-lg mb-3" id="setor" name="setor">
                        <option></option>
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
                <label class="col-sm-3 col-form-label">Ocorrencia </label>
                <div class="col-sm-7">
                    <select class="form-select form-select-lg mb-3" id="ocorrencia" name="ocorrencia">
                        <option></option>
                        <?php
                        // select da tabela de ocorrencia
                        $c_sql_setor = "SELECT ocorrencias.id, ocorrencias.descricao FROM ocorrencias ORDER BY ocorrencias.descricao";
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
            <div style="padding-top:5px;">

                <div class="row mb-7">
                    <label class="col-sm-3 col-form-label">Descrição</label>
                    <div class="col-sm-7">
                        <textarea class="form-control" id="solicitacao" name="solicitacao" rows="10"><?php echo $c_solicitacao; ?></textarea>
                    </div>
                </div>

            </div>
            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Finalizar</button>
                    <a class='btn btn' href='/gop/solicitacao_nova.php'><img src="\gop\images\saida.png" alt="" width="25" height="25"> Voltar</a>
                </div>
            </div>
        </form>
    </div>


</body>

</html>