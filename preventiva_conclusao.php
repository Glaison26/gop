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
                            <option>Rotina</option>
                            <option>Preditiva</option>
                            <option>Sistematica</option>
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
                    <label class="col-sm-2 col-form-label">Periodicidade</label>
                    <div class="col-sm-2">
                        <input type="number" class="form-control" placeholder="no. de dias" name="periodicidade" value="<?php echo $c_periodicidade; ?>" >
                    </div>
                    <label class="col-sm-3 col-form-label">Ultima Realização</label>
                    <div class="col-sm-2">
                        <input type="date"  class="form-control" id="datacadastro" name="datacadastro" value="<?php echo $d_dataultima; ?>">
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