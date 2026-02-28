<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('../links2.php');
include('../conexao.php');
$i_id = $_GET["id"];
//
if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário
    if (!isset($_GET["id"])) {
        header('location: /gop/preventivas/preventivas_lista.php');
        exit;
    }


    // leitura da preventiva através de sql usando id passada
    $c_sql = "select * from preventivas where id=$i_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/preventivas/preventivas_lista.php');
        exit;
    }

    //
    $d_data_cadastro = $registro['data_cadastro'];
    $c_periodicidade = $registro['periodicidade_geracao'];
    $c_prazo = $registro['prazo_atendimento'];
    $d_data_ultima = $registro['data_ult_realizacao'];
    $c_descritivo = $registro['descritivo'];
    $i_setor = $registro['id_setor'];
    $i_id_ocorrencia = $registro['id_ocorrencia'];
} else {  // post das informações
    do {
        if (!is_numeric($_POST['periodicidade'])) {
            $msg_erro = "Valor de periodicidade inválido !!";
            break;
        }
        if (!is_numeric($_POST['prazo'])) {
            $msg_erro = "Valor de prazo de atendimento inválido !!";
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
        // procuro setor selecionado
        $c_setor = $_POST['setor'];
        $c_sql_setor = "Select id from setores where descricao='$c_setor'";
        $result_setor = $conection->query($c_sql_setor);
        $registro_setor = $result_setor->fetch_assoc();
        $i_setor = $registro_setor['id'];
        //

        // procuro pelo id do executor responsável
        $c_executor_resp = $_POST['responsavel'];
        $c_sql_executor_resp = "Select id, nome from executores where nome='$c_executor_resp'";
        $result_executor_resp = $conection->query($c_sql_executor_resp);
        $registro_executor_resp = $result_executor_resp->fetch_assoc();
        $i_executor_resp = $registro_executor_resp['id'];
        //
        $d_data_cadastro = new DateTime($_POST['datacadastro']);
        $d_data_cadastro = $d_data_cadastro->format('Y-m-d');
        $i_periodicidade = $_POST['periodicidade'];
        $c_data_ultima = new DateTime($_POST['data_ultima']);
        $c_data_ultima = $c_data_ultima->format('Y-m-d');
        // ocorrencias
        $c_ocorrencia = $_POST['ocorrencia'];
        $c_sql_ocorrencia = "select ocorrencias.id from ocorrencias where ocorrencias.descricao='$c_ocorrencia'";
        $result_ocorrencia = $conection->query($c_sql_ocorrencia);
        $registro_ocorrencia = $result_ocorrencia->fetch_assoc();
        $i_id_ocorrencia = $registro_ocorrencia['id'];


        $c_prazo = $_POST['prazo'];
        $c_dias = '+' . $i_periodicidade . ' days';
        $d_data_proxima = date('y-m-d', strtotime($c_dias, strtotime($c_data_ultima))); // incremento 1 dia a data do loop
        // sql para alteração do registro
        $c_sql = "update preventivas set id_oficina='$i_id_oficina', id_setor='$i_setor',
    tipo_preventiva='$c_tipopreventiva', data_cadastro='$d_data_cadastro',periodicidade_geracao='$i_periodicidade',
    data_prox_realizacao='$d_data_proxima', data_ult_realizacao='$c_data_ultima', id_ocorrencia='$i_id_ocorrencia', 
    descritivo='$c_descritivo', prazo_atendimento='$c_prazo', id_executor=$i_executor_resp where id=$i_id";
        echo $c_sql;

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/preventivas/preventivas_lista.php');
    } while (false);
}


?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/gop/css/basico.css">

    <script>
        // chama arquivo para pegar id da oficina e filtrar os executores da mesma
        function verifica(value) {
            window.location.href = "/gop/preventivas/preventivas_verifica_oficina.php?id=" + value;
        }
    </script>

</head>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Edição de Preventiva<h5>
        </div>
    </div>

    <div class="container-fluid">


        <div class="container content-box">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
                </div>
                <h5>Edite os dados da preventiva e clique em salvar</h5>
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


                </div>


                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Responsável </label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="responsavel" name="responsavel" required>
                            <option></option>
                            <?php
                            // select da tabela de setores
                            $c_sql_resp = "SELECT executores.id, executores.nome FROM executores where ativo = 'SIM'  ORDER BY executores.nome";
                            $result_resp = $conection->query($c_sql_resp);
                            while ($c_linha = $result_resp->fetch_assoc()) {
                                $op = "";
                                if ($c_linha['id'] == $registro['id_executor']) {
                                    $op = "selected";
                                }
                                echo "<option $op>$c_linha[nome]</option>";
                            }


                            ?>
                        </select>

                    </div>
                    <label class="col-sm-2 col-form-label">Prazo de Atendimento</label>
                    <div class="col-sm-2">
                        <input type="number" placeholder="no. de dias" class="form-control" id="prazo" name="prazo" value='<?php echo $c_prazo ?>' required>
                    </div>


                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Ultima Realização</label>
                    <div class="col-sm-3">
                        <input type="date" class="form-control" id="data_ultima" name="data_ultima" value="<?php echo $d_data_ultima; ?>">
                    </div>
                    <label class="col-sm-2 col-form-label">Periodicidade</label>
                    <div class="col-sm-2">
                        <input required type="number" class="form-control" placeholder="no. de dias" name="periodicidade" value="<?php echo $c_periodicidade; ?>" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Setor </label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="setor" name="setor">

                            <?php
                            // select da tabela de setores
                            $c_sql_setor = "SELECT setores.id, setores.descricao FROM setores ORDER BY setores.descricao";
                            $result_setor = $conection->query($c_sql_setor);
                            while ($c_linha = $result_setor->fetch_assoc()) {
                                $op = "";
                                if ($c_linha['id'] == $registro['id_setor']) {
                                    $op = "selected";
                                }
                                echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                            }
                            ?>
                        </select>

                    </div>
                    <label class="col-sm-2 col-form-label">Tipo Preventiva</label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="tipo_preventiva" name="tipo_preventiva" value="<?php echo $c_tipo_preventiva; ?>">

                            <option <?= ($registro['tipo_preventiva'] == 'R') ? 'selected' : '' ?> value="R">Rotina</option>
                            <option <?= ($registro['tipo_preventiva'] == 'P') ? 'selected' : '' ?> value="P">Preditiva</option>
                            <option <?= ($registro['tipo_preventiva'] == 'S') ? 'selected' : '' ?> value="S">Sistematica</option>
                        </select>
                    </div>

                </div>

                <hr>
                <div class="row mb-3" style="padding-top:15px;padding-left:20px;">
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">Descritivo</label>
                        <div class="col-sm-9">
                            <textarea required class="form-control" id="descritivo" name="descritivo" rows="10"><?php echo $c_descritivo ?></textarea>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                        <a class='btn btn-success' href='/gop/preventivas/preventivas_lista.php'><img src="\gop\images\saida.png" alt="" width="25" height="18"> Voltar</a>
                    </div>
                </div>
            </form>
        </div>

    </div>
</body>

</html>