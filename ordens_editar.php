<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('links2.php');
include('conexao.php');
if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/pops_lista.php');
        exit;
    }

    $i_id = $_GET["id"];
    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from ordens where id=$i_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/ordens_lista.php');
        exit;
    }
    // sql para pegar recurso fisico se os for de recurso fisico
    if ($registro['tipo'] == 'R') {
        $i_recurso = $registro['id_recurso'];
        $c_sql_recurso = "Select id, descricao from recursos where id='$i_recurso'";
        $result_recurso = $conection->query($c_sql_recurso);
        $registro_recurso = $result_recurso->fetch_assoc();
        $c_recurso = $registro_recurso['descricao'];
    }
    // sql para pegar espaço fisico se os for de espaço fisico
    if ($registro['tipo'] == 'E') {
        $i_espaco = $registro['id_espaco'];
        $c_sql_espaco = "Select id, descricao from espacos where id='$i_espaco'";
        $result_espaco = $conection->query($c_sql_espaco);
        $registro_espaco = $result_espaco->fetch_assoc();
        $c_espaco = $registro_espaco['descricao'];
    }

    // sql para pegar o responsável
    $c_responsavel = $registro['id_responsavel'];
    $c_sql_responsavel = "Select id,nome from usuarios where id='$c_responsavel'";
    $result_responsavel = $conection->query($c_sql_responsavel);
    $registro_responsavel = $result_responsavel->fetch_assoc();
    // capturo dados da tabela para as variaveis
    $c_data_geracao = $registro['data_geracao'];
    $c_hora_geracao = $registro['hora_geracao'];
    $c_data_inicio = $registro['data_inicio'];
    $c_hora_inicio = $registro['hora_inicio'];
    $c_nome_responsavel = $registro_responsavel['nome'];
    $i_solicitacao = $registro['id_solicitacao'];

    if ($registro['tipo_ordem'] == 'P') {
        $hab_preventiva = '';
        $hab_corretiva = 'disabled';
    } else {
        $hab_preventiva = 'disabled';
        $hab_corretiva = '';
    }
    $c_descricao = $registro['descricao'];
} else {
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<script>
    // função para verificas selct do tipo de ordem e desebilita/ habilitar corretiva e preventiva
    function verifica(value) {
        var input_corretiva = document.getElementById("tipo_corretiva");
        var input_preventiva = document.getElementById("tipo_preventiva");

        if (value == 'C') {
            input_corretiva.disabled = false;
            input_preventiva.disabled = true;
        } else if (value == 'P') {
            input_corretiva.disabled = true;
            input_preventiva.disabled = false;
        }
    };
</script>

<body>
    <div class="container -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Edição de dados da Ordem de Serviço<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h4>Edição de Ordem de Serviço no.<b><?php echo ' ' . $i_id ?></b>. Os campos com (*) são obrigatórios</h4>
        </div>

        <br>
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

        <form method="post">
            <!-- abas de ediçao de ordem de serviço -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#aba_dados" aria-controls="aba_dados" role="tab" data-toggle="tab">Informações de Abertura</a></li>
                <li role="presentation"><a href="#aba_solicitacao" aria-controls="aba_solicitacao" role="tab" data-toggle="tab">Informação da Solicitação</a></li>
                <li role="presentation"><a href="#aba_atendimento" aria-controls="aba_atendimento" role="tab" data-toggle="tab">Informações do Atendimento</a></li>
                <li role="presentation"><a href="#aba_conclusao" aria-controls="aba_conclusao" role="tab" data-toggle="tab">Informações da Conclusão</a></li>
            </ul>
            <div class="tab-content">
                <!-- aba de informações da ordem-->
                <div role="tabpanel" class="tab-pane active" id="aba_dados">
                    <div style="padding-top:20px;padding-left:20px;">
                        <div class="row mb-8">
                            <label class="col-md-2 form-label">Data da Geração</label>
                            <div class="col-sm-2">
                                <input type="Date" class="form-control" name="geracao" id="data_geracao" value='<?php echo $c_data_geracao; ?>'>
                            </div>
                            <label class="col-md-2 form-label">Hora da Geração</label>
                            <div class="col-sm-2">
                                <input type="time" class="form-control" name="hora_geracao" id="hora_geracao" value="<?php echo $c_hora_geracao ?>">
                            </div>
                        </div>
                        <br>

                        <div class="row mb-8">
                            <label class="col-md-2 form-label">Data do Inicio</label>
                            <div class="col-sm-2">
                                <input type="Date" class="form-control" name="data_inicio" id="data_inicio" value='<?php echo $c_data_inicio; ?>'>
                            </div>
                            <label class="col-md-2 form-label">Hora do Inicio</label>
                            <div class="col-sm-2">
                                <input type="time" class="form-control" name="hora_inicio" id="hora_geracao" value="<?php echo $c_hora_inicio ?>">
                            </div>
                        </div>
                        <br>
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Responsável</label>
                            <div class="col-sm-7">
                                <input type="text" readonly maxlength="50" class="form-control" name="responsavel" value="<?php echo $c_nome_responsavel; ?>">
                            </div>
                        </div>
                        <!-- verifico se é recurso ou serviço para aparecer. avulso não aparece -->
                        <div class="row mb-8">
                            <?php
                            if ($registro['tipo'] == 'R') {
                                echo "<label class='col-sm-2 col-form-label'>Recurso Físico</label>
                            <div class='col-sm-7'>
                                <input type='text' readonly  class='form-control' id = 'recurso' name='recurso' value='$c_recurso'>
                            </div>";
                            }
                            if ($registro['tipo'] == 'E') {
                                echo "<label class='col-sm-2 col-form-label'>Espaço Físico</label>
                            <div class='col-sm-7'>
                                <input type='text' readonly  class='form-control' id = 'espaco' name='espaco' value='$c_espaco'>
                            </div>";
                            }
                            ?>
                        </div>
                        <br>
                        <div class="row mb-8">
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
                                    <option $op>$c_linha[descricao]</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                            <label class="col-sm-2 col-form-label">No. Solicitação</label>
                            <div class="col-sm-2">
                                <input type="text" readonly class="form-control" id="solicitacao" name="solicitacao" value="<?php echo $i_solicitacao; ?>">
                            </div>
                        </div>
                        <div class="row mb-8">
                            <label class="col-sm-2 col-form-label">Tipo</label>
                            <div class="col-sm-2">
                                <select onchange="verifica(value)" class="form-select form-select-lg mb-3" id="tipo" name="tipo" value="<?php echo $c_tipo; ?>">
                                    <option <?= ($registro['tipo_ordem'] == 'C') ? 'selected' : '' ?> value='C'>Corretiva</option>
                                    <option <?= ($registro['tipo_ordem'] == 'P') ? 'selected' : '' ?> value="P">Preventiva</option>
                                </select>
                            </div>
                            <label class="col-sm-1 col-form-label">Corretiva</label>
                            <div class="col-sm-2">
                                <select <?php echo $hab_corretiva ?> class="form-select form-select-lg mb-3" id="tipo_corretiva" name="tipo_corretiva" value="<?php echo $c_tipo_corretiva; ?>">
                                    <option value='P' <?= ($registro['tipo_corretiva'] == 'P') ? 'selected' : '' ?>>Programada</option>
                                    <option value='U' <?= ($registro['tipo_corretiva'] == 'U') ? 'selected' : '' ?>>Urgênte</option>
                                </select>
                            </div>
                            <label class="col-sm-1 col-form-label">Preventiva</label>
                            <div class="col-sm-2">

                                <select <?php echo $hab_preventiva ?> class="form-select form-select-lg mb-3" id="tipo_preventiva" name="tipo_preventiva" value="<?php echo $c_tipo_preventiva; ?>">
                                    <option value='R' <?= ($registro['tipo_corretiva'] == 'R') ? 'selected' : '' ?>>Rotina</option>
                                    <option value='P' <?= ($registro['tipo_corretiva'] == 'P') ? 'selected' : '' ?>>Preditiva</option>
                                    <option value='S' <?= ($registro['tipo_corretiva'] == 'S') ? 'selected' : '' ?>>Sistematica</option>
                                </select>
                            </div>
                        </div>


                    </div>
                </div>
                <!-- aba de informações da solicitação da ordem-->
                <div role="tabpanel" class="tab-pane" id="aba_solicitacao">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Descrição</label>
                            <div class="col-sm-8">
                                <textarea class="form-control" id="descricao" name="descricao" rows="10 "><?php echo $c_descricao ?></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- aba de informações do atendimento da ordem-->
                <div role="tabpanel" class="tab-pane" id="aba_atendimento">
                    <div style="padding-top:15px;padding-left:20px;">
                        <p>terceira aba</p>
                    </div>
                </div>
                <!-- aba de informações da conclusão da ordem-->
                <div role="tabpanel" class="tab-pane" id="aba_conclusao">
                    <div style="padding-top:15px;padding-left:20px;">
                        <p>quarta aba</p>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/ordens_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>
            </div>

        </form>
    </div>

</body>

</html>