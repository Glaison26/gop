<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
include("../links2.php");
include_once "../lib_gop.php";
$msg_erro = "";
//$c_descritivo = "";
$c_descritivo = $_SESSION['ocorrencia'];
$c_ocorrencia = $_SESSION['valor_ocorrencia'];
date_default_timezone_set('America/Sao_Paulo');
$i_id_oficina = $_SESSION['i_id_oficina']; // valor inicial da id da oficina
$d_datacadastro = date('m-d-y');
if ($_SESSION['tiposolicitacao'] == 'R') { // recurso fisico
    // pego id do recurso selecionado na página anterior
    if (isset($_GET['id'])) {
        $i_id_recurso = $_GET['id'];
        $_SESSION['id_recurso'] = $i_id_recurso;
    } else {
        $i_id_recurso = $_SESSION['id_recurso'];
    }

    // sql para pegar nome
    $c_sql = "SELECT recursos.id, recursos.descricao FROM recursos where recursos.id='$i_id_recurso'";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();
    $c_recurso = $registro['descricao'];
}
if ($_SESSION['tiposolicitacao'] == 'E') {  // espaço físico
    // pego id do recurso selecionado na página anterior
    if (isset($_GET['id'])) {
        $i_id_espaco = $_GET['id'];
        $_SESSION['id_espaco'] = $i_id_espaco;
    } else {
        $i_id_espaco = $_SESSION['id_espaco'];
    }
    // sql para pegar nome
    $c_sql = "SELECT espacos.id, espacos.descricao FROM espacos where espacos.id='$i_id_espaco'";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();
    $c_espaco = $registro['descricao'];
}
// rotina para gravação dos dados
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    do {


        if (!is_numeric($_POST['periodicidade'])) {
            $msg_erro = "Valor de periodicidade inválido !!";
            break;
        }
        if (!is_numeric($_POST['prazo'])) {
            $msg_erro = "Valor de prazo de atendimento inválido !!";
            break;
        }
        // setores
        // procuro setor selecionado
        $c_setor = $_POST['setor'];
        $c_sql_setor = "Select id from setores where descricao='$c_setor'";
        $result_setor = $conection->query($c_sql_setor);
        $registro_setor = $result_setor->fetch_assoc();
        $i_setor = $registro_setor['id'];
        //
        $c_descritivo = $_POST['descritivo'];
        $c_tipopreventiva = $_POST['tipo_preventiva'];
        // procuro pelo id do executor responsável
        $c_executor_resp = $_POST['responsavel'];
        $c_sql_executor_resp = "Select id, nome from executores where nome='$c_executor_resp'";
        $result_executor_resp = $conection->query($c_sql_executor_resp);
        $registro_executor_resp = $result_executor_resp->fetch_assoc();
        $i_executor_resp = $registro_executor_resp['id'];
        // sql para pegar oficina
        $c_oficina = $_POST["oficina"];
        $c_sql_oficina = "select oficinas.id, oficinas.descricao from oficinas where oficinas.descricao = '$c_oficina'";
        $result = $conection->query($c_sql_oficina);
        $c_linha = $result->fetch_assoc();
        $i_id_oficina = $c_linha['id'];
        //
        $d_data_cadastro = new DateTime($_POST['datacadastro']);
        $d_data_cadastro = $d_data_cadastro->format('Y-m-d');
        $i_periodicidade = $_POST['periodicidade'];
        $c_data_ultima = new DateTime($_POST['data_ultima']);
        $c_data_ultima = $c_data_ultima->format('Y-m-d');
        $c_prazo = $_POST['prazo'];
        // 
        // 
        $c_ocorrencia = $_POST['ocorrencia'];
        $c_sql_ocorrencia = "select ocorrencias.id from ocorrencias where ocorrencias.descricao='$c_ocorrencia'";
        $result_ocorrencia = $conection->query($c_sql_ocorrencia);
        $registro_ocorrencia = $result_ocorrencia->fetch_assoc();
        $i_id_ocorrencia = $registro_ocorrencia['id'];

        $c_dias = '+' . $i_periodicidade . ' days';
        $d_data_proxima = date('y-m-d', strtotime($c_dias, strtotime($c_data_ultima))); // incremento 1 dia a data do loop
        // sql para inclusão do registro para recurso fisico
        if ($_SESSION['tiposolicitacao'] == 'R') { // sql para recursos fisicos
            $c_sql = "Insert into preventivas (id_recurso,id_oficina, id_setor,tipo,tipo_preventiva, data_cadastro
                    , periodicidade_geracao, data_prox_realizacao, data_ult_realizacao,descritivo, gerar,
                      id_ocorrencia, prazo_atendimento, id_executor) 
                    value ('$i_id_recurso', '$i_id_oficina', '$i_setor',  'R', '$c_tipopreventiva',
                    '$d_data_cadastro', '$i_periodicidade', '$d_data_proxima', '$c_data_ultima',
                     '$c_descritivo', 'Sim', '$i_id_ocorrencia', $c_prazo, $i_executor_resp)";
        }
        //
        if ($_SESSION['tiposolicitacao'] == 'E') { // sql para espacos fisicos
            $c_sql = "Insert into preventivas (id_espaco,id_oficina, id_setor, tipo,tipo_preventiva, data_cadastro
                      , periodicidade_geracao, data_prox_realizacao, data_ult_realizacao, descritivo, 
                      gerar,  id_ocorrencia, prazo_atendimento, id_executor ) 
                      value ('$i_id_espaco', '$i_id_oficina', '$i_setor', '$i_id_centrodecusto', 'E', '$c_tipopreventiva',
                     '$d_data_cadastro', '$i_periodicidade', '$d_data_proxima', '$c_data_ultima',
                      '$c_descritivo', 'Sim', '$i_id_ocorrencia', $c_prazo,  $i_executor_resp)";
        }
        if ($_SESSION['tiposolicitacao'] == 'V') { // sql para preventivas avulsas sem espaço fisico ou recurso fisico
            $c_sql = "Insert into preventivas (id_oficina, id_setor, tipo,tipo_preventiva, data_cadastro
                      , periodicidade_geracao, data_prox_realizacao, data_ult_realizacao,descritivo, 
                      gerar,  id_ocorrencia, prazo_atendimento, id_executor ) 
                      value ('$i_id_oficina', '$i_setor',  'V', '$c_tipopreventiva',
                     '$d_data_cadastro', '$i_periodicidade', '$d_data_proxima', '$c_data_ultima',
                      '$c_descritivo', 'Sim', '$i_id_ocorrencia', $c_prazo,  $i_executor_resp)";
        }

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/preventivas/preventivas_finalizar.php');
    } while (false);
}
?>

<!-- Interface HTML da pagina de inclusão de preventiva -->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GOP - Preventivas - Nova Preventiva</title>
    <link rel="stylesheet" href="/gop/css/basico.css">


</head>

<body>

    <script>
        // chama arquivo para pegar id da oficina e filtrar os executores da mesma
        function verifica(value) {
            window.location.href = "/gop/preventivas/preventivas_verifica_oficina.php?id=" + value;
        }
    </script>

    <script>
        // chama arquivo para pegar ocorrencia
        function verifica_ocorrencia(value) {
            window.location.href = "/gop/preventivas/verifica_ocorrencia.php?id=" + value;
        }
    </script>

    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Cadastro de Prevêntivas<h5>
        </div>
    </div>

    <div class="container-fluid">


        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                
                <h3><img Align='left' src='\gop\images\aviso.png' alt='30' height='35'><span>&nbsp;&nbsp;&nbsp; $msg_erro</span></h3>
            </div>
            ";
        }
        ?>
        <div class="container content-box">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
                </div>
                <h5>Entre com os dados da nova preventiva e clique em salvar</h5>
            </div>
            <form method="post">
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Ocorrencia </label>
                    <div class="col-sm-7">
                        <select onchange="verifica_ocorrencia(value)" required class="form-select form-select-lg mb-3" id="ocorrencia" name="ocorrencia" value="<?php echo $c_ocorrencia ?>">
                            <option></option>
                            <?php
                            // select da tabela de ocorrencia
                            $c_sql_setor = "SELECT ocorrencias.id, ocorrencias.descricao FROM ocorrencias ORDER BY ocorrencias.descricao";
                            $result_setor = $conection->query($c_sql_setor);
                            while ($c_linha = $result_setor->fetch_assoc()) {
                                if (!empty($_SESSION['valor_ocorrencia'])) {
                                    if ($_SESSION['valor_ocorrencia'] == $c_linha['descricao'])
                                        $op = 'selected';
                                    else
                                        $op = "";
                                }
                                echo "  
                          <option $op>$c_linha[descricao]</option>";
                            }
                            ?>
                        </select>

                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Data de Cadastro</label>
                    <div class="col-sm-3">
                        <input required type="date" class="form-control" id="datacadastro" name="datacadastro" value='<?php echo date("Y-m-d"); ?>'>
                    </div>
                    <label class="col-sm-1 col-form-label">Oficina </label>
                    <div class="col-sm-3">
                        <select onchange="verifica(value)" class="form-select form-select-lg mb-3" id="oficina" name="oficina" required>
                            <option></option>
                            <?php
                            // select da tabela de oficinas
                            $c_sql_oficina = "SELECT oficinas.id, oficinas.descricao FROM oficinas ORDER BY oficinas.descricao";
                            $result_oficina = $conection->query($c_sql_oficina);
                            while ($c_linha = $result_oficina->fetch_assoc()) {
                                $op = "";
                                if ($_SESSION['i_id_oficina'] == $c_linha['id'])
                                    $op = 'selected';
                                else
                                    $op = "";
                                echo "<option $op>$c_linha[descricao]</option>";
                            }
                            ?>
                        </select>
                    </div>

                </div>


                <div class="row mb-3">

                    <label class="col-sm-2 col-form-label">Responsável </label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="responsavel" name="responsavel" required>
                            <option></option>
                            <?php
                            // select da tabela de setores
                            $c_sql_resp = "SELECT executores.id, executores.nome FROM executores where id_oficina='$i_id_oficina' and ativo = 'SIM' ORDER BY executores.nome";
                            $result_resp = $conection->query($c_sql_resp);
                            while ($c_linha = $result_resp->fetch_assoc()) {
                                echo "  
                          <option>$c_linha[nome]</option>
                        ";
                            }
                            ?>
                        </select>
                    </div>

                    <label class="col-sm-2 col-form-label">Prazo Atend.</label>
                    <div class="col-sm-2">
                        <input required type="number" placeholder="no. de dias" class="form-control" id="prazo" name="prazo">
                    </div>

                </div>


                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Ultima Realização</label>
                    <div class="col-sm-3">
                        <input type="date" class="form-control" id="data_ultima" required name="data_ultima">
                    </div>
                    <label class="col-sm-2 col-form-label">Periodicidade</label>
                    <div class="col-sm-2">
                        <input required type="number" class="form-control" placeholder="no. de dias" name="periodicidade" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Setor </label>
                    <div class="col-sm-3">
                        <select required class="form-select form-select-lg mb-3" id="setor" name="setor">
                            <option></option>
                            <?php
                            // select da tabela de setores
                            $c_sql_setor = "SELECT setores.id, setores.descricao FROM setores ORDER BY setores.descricao";
                            $result_setor = $conection->query($c_sql_setor);
                            while ($c_linha = $result_setor->fetch_assoc()) {
                                echo "  
                          <option>$c_linha[descricao]</option>";
                            }
                            ?>
                        </select>
                    </div>
                    <label class="col-sm-2 col-form-label">Tipo Preventiva</label>
                    <div class="col-sm-2">
                        <select class="form-select form-select-lg mb-3" id="tipo_preventiva" required name="tipo_preventiva" value="<?php echo $c_tipo_preventiva; ?>" required>
                            <option></option>
                            <option value="R">Rotina</option>
                            <option value="P">Preditiva</option>
                            <option value="S">Sistematica</option>
                        </select>
                    </div>


                </div>


                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Descritivo</label>
                    <div class="col-sm-7">
                        <textarea required class="form-control" id="descritivo" name="descritivo" rows="10"><?php echo $c_descritivo ?></textarea>
                    </div>
                </div>

                <hr>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Finalizar</button>
                        <a class='btn' href='/gop/preventivas/preventivas_nova.php'><img src="\gop\images\saida.png" alt="" width="25" height="18"> Voltar</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>

</html>