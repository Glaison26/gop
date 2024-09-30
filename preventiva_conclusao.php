<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("conexao.php");
include("links2.php");
include_once "lib_gop.php";
$msg_erro = "";
$c_descritivo = "";
date_default_timezone_set('America/Sao_Paulo');
$d_datacadastro = date('m-d-y');
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
// rotina para gravação dos dados
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    do {
        if (empty($_POST['tipo_preventiva']) || empty($_POST['oficina']) || empty($_POST['ocorrencia']) || empty($_POST['centrodecusto'])) {
            $msg_erro = "Todos os Campos devem ser preenchidos!!!";
            break;
        }

        if (!is_numeric($_POST['periodicidade'])) {
            $msg_erro = "Valor de periodicidade inválido !!";
            break;
        }
        $c_descritivo = $_POST['descritivo'];
        $c_tipopreventiva = $_POST['tipo_preventiva'];
        // sql para pegar oficina
        $c_oficina = $_POST["oficina"];
        $c_sql_oficina = "select oficinas.id, oficinas.descricao from oficinas where oficinas.descricao = '$c_oficina'";
        $result = $conection->query($c_sql_oficina);
        $c_linha = $result->fetch_assoc();
        $i_id_oficina = $c_linha['id'];
        // verifico a id do centro de custo selecionado no combo 
        $c_centrodecusto = $_POST['centrodecusto'];
        $c_sql_secundario = "SELECT centrodecusto.id FROM centrodecusto where centrodecusto.descricao='$c_centrodecusto' ORDER BY centrodecusto.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_id_centrodecusto = $registro_secundario['id'];
        //
        $d_data_cadastro = new DateTime($_POST['datacadastro']);
        $d_data_cadastro = $d_data_cadastro->format('Y-m-d');
        $i_periodicidade = $_POST['periodicidade'];
        $c_data_ultima = new DateTime($_POST['data_ultima']);
        $c_data_ultima = $c_data_ultima->format('Y-m-d');
        // 
        $c_ocorrencia = $_POST['ocorrencia'];
        $c_sql_ocorrencia = "select ocorrencias.id from ocorrencias where ocorrencias.descricao='$c_ocorrencia'";
        $result_ocorrencia = $conection->query($c_sql_ocorrencia);
        $registro_ocorrencia = $result_ocorrencia->fetch_assoc();
        $i_id_ocorrencia = $registro_ocorrencia['id'];
        if (!isset($_POST['chk_calibracao'])) {
            $c_calibracao = 'N';
        } else {
            $c_calibracao = 'S';
        }
        $c_dias = '+' . $i_periodicidade . ' days';
        $d_data_proxima = date('y-m-d', strtotime($c_dias, strtotime($c_data_ultima))); // incremento 1 dia a data do loop
        // sql para inclusão do registro
        if ($_SESSION['tiposolicitacao'] == 'R') // sql para recursos fisicos
            $c_sql = "Insert into preventivas (id_recurso,id_oficina,id_centrodecusto,tipo,tipo_preventiva, data_cadastro
                    , periodicidade_geracao, data_prox_realizacao, data_ult_realizacao, calibracao,descritivo, gerar, id_ocorrencia) 
                    value ('$i_id_recurso', '$i_id_oficina', '$i_id_centrodecusto', 'R', '$c_tipopreventiva',
                    '$d_data_cadastro', '$i_periodicidade', '$d_data_proxima', '$c_data_ultima','$c_calibracao', '$c_descritivo', 'Sim', '$i_id_ocorrencia')";
        if ($_SESSION['tiposolicitacao'] == 'E') // sql para espacos fisicos
            $c_sql = "Insert into preventivas (id_espaco,id_oficina,id_centrodecusto,tipo,tipo_preventiva, data_cadastro
                      , periodicidade_geracao, data_prox_realizacao, data_ult_realizacao, calibracao,descritivo, gerar, id_ocorrencia) 
                      value ('$i_id_espaco', '$i_id_oficina', '$i_id_centrodecusto', 'E', '$c_tipopreventiva',
                     '$d_data_cadastro', '$i_periodicidade', '$d_data_proxima', '$c_data_ultima','$c_calibracao', '$c_descritivo', 'Sim', '$i_id_ocorrencia')";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/preventivas.php');
    } while (false);
}
?>

<!-- Interface HTML da pagina de inclusão de preventiva -->

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
            <h5>Cadastro de Prevêntivas<h5>
        </div>
    </div>

    <div class="container -my5">

        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Entre com os dados da nova preventiva e clique em salvar</h5>
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
            <br>

            <div style="padding-left :15px;" class="row mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="" id="chk_calibracao">
                    <label class="form-check-label" for="chk_calibracao">
                        Calibração
                    </label>
                </div>
            </div>
            <br>
            <div class="row mb-3">

                <div class="row mb-3">

                    <label class="col-sm-2 col-form-label">Data de Cadastro</label>
                    <div class="col-sm-3">
                        <input type="date" class="form-control" id="datacadastro" name="datacadastro" value='<?php echo date("Y-m-d"); ?>'>
                    </div>
                    <label class="col-sm-2 col-form-label">Tipo Preventiva</label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="tipo_preventiva" name="tipo_preventiva" value="<?php echo $c_tipo_preventiva; ?>">
                            <option></option>
                            <option value="R">Rotina</option>
                            <option value="P">Preditiva</option>
                            <option value="S">Sistematica</option>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Oficina </label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="oficina" name="oficina">
                            <option></option>
                            <?php
                            // select da tabela de oficinas
                            $c_sql_oficina = "SELECT oficinas.id, oficinas.descricao FROM oficinas ORDER BY oficinas.descricao";
                            $result_oficina = $conection->query($c_sql_oficina);
                            while ($c_linha = $result_oficina->fetch_assoc()) {
                                $op = "";
                                if ($c_linha['id'] == $registro['id_oficina']) {
                                    $op = "selected";
                                }
                                echo "<option $op>$c_linha[descricao]</option>";
                            }
                            ?>
                        </select>
                    </div>

                    <label class="col-sm-2 col-form-label">Centro de Custo </label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="centrodecusto" name="centrodecusto">
                            <option></option>
                            <?php
                            // select da tabela de centro de custo
                            $c_sql_custo = "SELECT centrodecusto.id, centrodecusto.descricao FROM centrodecusto ORDER BY centrodecusto.descricao";
                            $result_custo = $conection->query($c_sql_custo);
                            while ($c_linha = $result_custo->fetch_assoc()) {
                                $op = '';
                                if ($c_linha['id'] == $i_centrodecusto) {
                                    $op = 'selected';
                                } else {
                                    $op = '';
                                }

                                echo "<option $op>$c_linha[descricao]</option>";
                            }

                            ?>
                        </select>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Periodicidade</label>
                    <div class="col-sm-2">
                        <input type="number" class="form-control" placeholder="no. de dias" name="periodicidade" value="<?php echo $c_periodicidade; ?>">
                    </div>
                    <label class="col-sm-3 col-form-label">Ultima Realização</label>
                    <div class="col-sm-2">
                        <input type="date" class="form-control" id="data_ultima" name="data_ultima" value="<?php echo $d_dataultima; ?>">
                    </div>

                </div>
                <br>
                <div class="row m3-2">
                    <label class="col-sm-2 col-form-label">Ocorrencia </label>
                    <div class="col-sm-8">
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
                <hr>
                <div class="row mb-3" style="padding-top:15px;padding-left:20px;">
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">Descritivo</label>
                        <div class="col-sm-8">
                            <textarea class="form-control" id="descritivo" name="descritivo" rows="10"><?php echo $c_descritivo ?></textarea>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Finalizar</button>
                        <a class='btn btn-success' href='/gop/preventivas_nova.php'><img src="\gop\images\saida.png" alt="" width="25" height="18"> Voltar</a>
                    </div>
                </div>
        </form>

    </div>
</body>

</html>