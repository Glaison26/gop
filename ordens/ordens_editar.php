<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('../links2.php');
include('../conexao.php');
if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/pops_lista.php');
        exit;
    }
    $_SESSION['id_ordem'] = $_GET["id"];
    $i_id = $_SESSION['id_ordem'];
    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from ordens where id=$i_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();
    // varuavel para colocar campos em somente leitura para ordens já fechadas
    if ($registro['status'] == 'C' || $registro['status'] == 'X') {
        $c_estado = "readonly";
        $c_ativa = "disabled";
    } else {
        $c_estado = "";
        $c_ativa = "";
    }

    if (!$registro) {
        header('location: /gop/ordens/ordens_gerenciar.php');
        exit;
    }
    // sql para pegar recurso fisico se os for de recurso fisico
    if ($registro['tipo'] == 'R') {
        $i_recurso = $registro['id_recurso'];
        $c_sql_recurso = "Select id, descricao, patrimonio from recursos where id='$i_recurso'";
        $result_recurso = $conection->query($c_sql_recurso);
        $registro_recurso = $result_recurso->fetch_assoc();
        $c_recurso = $registro_recurso['patrimonio'] . ' - ' . $registro_recurso['descricao'];
    }
    // sql para pegar espaço fisico se os for de espaço fisico
    if ($registro['tipo'] == 'E') {
        $i_espaco = $registro['id_espaco'];
        $c_sql_espaco = "Select id, descricao from espacos where id='$i_espaco'";
        $result_espaco = $conection->query($c_sql_espaco);
        $registro_espaco = $result_espaco->fetch_assoc();
        $c_espaco = $registro_espaco['descricao'];
    }

    // sql para pegar ocorrencia

    $i_ocorrencia = $registro['id_ocorrencia'];
    $c_sql_ocorrencia = "Select id, descricao from ocorrencias where id='$i_ocorrencia'";
    $result_ocorrencia = $conection->query($c_sql_ocorrencia);
    $registro_ocorrencia = $result_ocorrencia->fetch_assoc();
    $c_ocorrencia = $registro_ocorrencia['descricao'];
    // sql para pegar o responsável
    $c_responsavel = $registro['id_solicitante'];
    $c_sql_responsavel = "Select id,nome from usuarios where id='$c_responsavel'";
    $result_responsavel = $conection->query($c_sql_responsavel);
    $registro_responsavel = $result_responsavel->fetch_assoc();
    // capturo dados da tabela para as variaveis
    $c_data_geracao = $registro['data_geracao'];
    $c_hora_geracao = $registro['hora_geracao'];
    $c_data_inicio = $registro['data_inicio'];
    $c_hora_inicio = $registro['hora_inicio'];
    $c_data_previsao = $registro['data_previsao'];
    $c_hora_previsao = $registro['hora_previsao'];
    $c_data_entrada = $registro['data_entrada'];
    $c_hora_entrada = $registro['hora_entrada'];
    $c_data_inicio = $registro['data_inicio'];
    $c_hora_inicio = $registro['hora_inicio'];
    $c_data_entrega = $registro['data_entrega'];
    $c_hora_entrega = $registro['hora_entrega'];
    $c_data_saida = $registro['data_saida'];
    // 
    $c_data_conclusao = $registro['data_conclusao'];
    $c_hora_conclusao = $registro['hora_conclusao'];
    $c_data_garantia = $registro['data_garantia'];

    $c_descritivo = $registro['descritivo'];
    $c_nome_responsavel = $registro_responsavel['nome'];
    $i_solicitacao = $registro['id_solicitacao'];
    $i_id_responsavel = $registro['id_responsavel'];
    $i_id_executor_responsavel = $registro['id_executor_responsavel'];

    if ($registro['tipo_ordem'] == 'P') {
        $hab_preventiva = '';
        $hab_corretiva = 'disabled';
    } else {
        $hab_preventiva = 'disabled';
        $hab_corretiva = '';
    }
    $c_descricao = $registro['descricao'];
    // mau uso
    if ($registro['mau_uso'] == 'S') {
        $c_mau_uso = 'checked';
    } else {
        $c_mau_uso = '';
    }
    $c_situacao = $registro['situacao'];
    // situação
    if ($registro['situacao'] == 'N') {
        $c_hab_nao_conformidade = '';
    } else {
        $c_hab_nao_conformidade = 'disabled';
    }
    $c_conclusao = $registro['conclusao'];
    $c_nota = $registro['numero_nota'];
    $c_valor_material = 0;
    $c_valor_servico = 0;
    if ($registro['valor_material'] > 0)
        $c_valor_material = number_format($registro['valor_material'], 2, '.', '');
    if ($registro['valor_servico'] > 0)
        $c_valor_servico = number_format($registro['valor_servico'], 2, '.', '');
    $c_status = $registro['status'];

    if ($c_status == 'A') {
        $c_status = 'Aberta';
    } else {
        $c_status = 'Concluída';
    }
} else // metodo post
{

    $c_data_inicio = new DateTime($_POST['data_inicio']);
    $c_data_inicio = $c_data_inicio->format('Y-m-d');
    $c_hora_inicio =  new DateTime($_POST['hora_inicio']);
    $c_hora_inicio = $c_hora_inicio->format('H:i');
    // sql para pegar a id do setor selecionado
    $c_setor = $_POST['setor'];
    $c_sql_setor = "SELECT setores.id FROM setores where descricao = '$c_setor'";
    $result_setor = $conection->query($c_sql_setor);
    $c_linha = $result_setor->fetch_assoc();
    $i_setor = $c_linha['id'];
    //
    $c_tipo_ordem = $_POST['tipo'];
    // para tipo corretiva
    if ($c_tipo_ordem == 'C') {
        // corretiva
        $c_tipo_preventiva = "";
        $c_tipo_corretiva = $_POST['tipo_corretiva'];
    } else {
        $c_tipo_corretiva = "";
        $c_tipo_preventiva = $_POST['tipopreventiva'];
    }
    // select da tabela de oficinas
    $c_oficina = $_POST['oficina'];
    $c_sql_oficina = "SELECT oficinas.id FROM oficinas where oficinas.descricao='$c_oficina'";
    $result_oficina = $conection->query($c_sql_oficina);
    $c_linha = $result_oficina->fetch_assoc();
    $i_oficina = $c_linha['id'];
    //
    $c_data_entrada =  new DateTime($_POST['data_entrada']);
    $c_data_entrada = $c_data_entrada->format('Y-m-d');
    //
    $c_hora_entrada = new DateTime($_POST['hora_entrada']);
    $c_hora_entrada = $c_hora_entrada->format('H:i');

    $c_data_previsao = new DateTime($_POST['data_previsao']);
    $c_data_previsao = $c_data_previsao->format('Y-m-d');
    //
    $c_hora_previsao = new DateTime($_POST['hora_previsao']);
    $c_hora_previsao = $c_hora_previsao->format('H:i');
    // 
    $c_situacao = $_POST['situacao'];
    if ($c_situacao == 'C') {
        $c_motivo = "";
    } else {
        $c_motivo = $_POST['nao_conforme'];
    }
    //
    $c_data_entrega = new DateTime($_POST['data_entrega']);
    $c_data_entrega = $c_data_entrega->format('Y-m-d');
    //
    $c_hora_entrega = new DateTime($_POST['hora_entrega']);
    $c_hora_entrega = $c_hora_entrega->format('H:i');
    //
    $c_data_saida = new DateTime($_POST['data_saida']);
    $c_data_saida = $c_data_saida->format('Y-m-d');
    //
    $c_data_garantia = new DateTime($_POST['data_garantia']);
    $c_data_garantia = $c_data_garantia->format('Y-m-d');
    $c_nota = $_POST['nota'];
    $c_valor_servico = $_POST['valor_servico'];
    $c_valor_material = $_POST['valor_material'];
    $c_descritivo = $_POST['descritivo'];
    $c_id_ocorrencia = $_POST['ocorrencia'];
    $i_id_executor_responsavel = $_POST['executor_responsavel'];

    if (!is_numeric($c_valor_servico))
        $c_valor_servico = 0;
    if (!is_numeric($c_valor_material))
        $c_valor_material = 0;

    do {
        // sql para atualizar regitro da os
        $i_id = $_SESSION['id_ordem'];
        $c_sql = "Update ordens" .
            " SET data_inicio='$c_data_inicio', hora_inicio='$c_hora_inicio',  id_setor='$i_setor', id_ocorrencia='$c_id_ocorrencia',
             tipo_ordem='$c_tipo_ordem', tipo_corretiva='$c_tipo_corretiva', tipo_preventiva='$c_tipo_preventiva',
            id_oficina='$i_oficina', data_entrada='$c_data_entrada', hora_entrada='$c_hora_entrada',
            data_previsao='$c_data_previsao', hora_previsao='$c_hora_previsao', situacao='$c_situacao', 
            motivo_naoconformidade ='$c_motivo', data_entrega='$c_data_entrega', hora_entrega='$c_hora_entrega',
            data_saida='$c_data_saida', data_garantia='$c_data_garantia', numero_nota='$c_nota',
            valor_servico = '$c_valor_servico', valor_material='$c_valor_material',
            descritivo='$c_descritivo', id_executor_responsavel='$i_id_executor_responsavel'
            where id='$i_id'";


        $result = $conection->query($c_sql);

        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        header('location: /gop/ordens/ordens_gerenciar.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/gop/css/basico.css">
    <title>GOP - Editar Ordem de serviço</title>

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

    function conformidade(value) {
        var input_nao_conforme = document.getElementById("nao_conforme");
        if ((value == 'C') || (value == '')) {
            input_nao_conforme.disabled = true;
            document.getElementById('nao_conforme').value = 'N';
        } else if (value == 'N') {
            input_nao_conforme.disabled = false;
        }
    };
    // funcao para verificar select do conforme e não conforme
</script>

<body>
    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Edição de dados da Ordem de Serviço<h5>
                </div>
            </div>
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
        <div class="container content-box">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

                </div>
                <h4>Edição de Ordem de Serviço no.<b><?php echo ' ' . $i_id ?></b>. Os campos com (*) são obrigatórios</h4>
            </div>
            <form method="post">
                <!-- abas de ediçao de ordem de serviço -->
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#aba_dados" aria-controls="aba_dados" role="tab" data-toggle="tab">Informações de Abertura</a></li>
                    <li role="presentation"><a href="#aba_solicitacao" aria-controls="aba_solicitacao" role="tab" data-toggle="tab">Informação da Solicitação</a></li>
                    <li role="presentation"><a href="#aba_atendimento" aria-controls="aba_atendimento" role="tab" data-toggle="tab">Informações do Atendimento</a></li>
                    <li role="presentation"><a href="#aba_conclusao" aria-controls="aba_conclusao" role="tab" data-toggle="tab">Informações da Conclusão</a></li>
                    <?php
                    if ($registro['status'] == 'X')
                        echo '<li role="presentation"><a href="#aba_cancelamento" aria-controls="aba_cancelamento" role="tab" data-toggle="tab">Cancelamento</a></li>';
                    ?>
                </ul>
                <div class="tab-content">
                    <!-- aba de informações da ordem-->
                    <div role="tabpanel" class="tab-pane active" id="aba_dados">
                        <div style="padding-top:20px;padding-left:20px;">
                            <div class="row mb-8">
                                <label class="col-md-2 form-label">Data da Geração</label>
                                <div class="col-sm-2">
                                    <input readonly type="Date" class="form-control" name="data_geracao" id="data_geracao" value='<?php echo $c_data_geracao; ?>'>
                                </div>
                                <label class="col-md-2 form-label">Hora da Geração</label>
                                <div class="col-sm-2">
                                    <input readonly type="time" class="form-control" name="hora_geracao" id="hora_geracao" value="<?php echo $c_hora_geracao ?>">
                                </div>
                            </div>
                            <br>
                            <!-- verifico se é recurso ou serviço para aparecer. avulso não aparece -->
                            <div class="row mb-8">
                                <?php
                                if ($registro['tipo'] == 'R') {
                                    echo "<label class='col-sm-2 col-form-label'>Recurso Físico</label>
                            <div class='col-sm-6'>
                                <input type='text' readonly  class='form-control' id = 'recurso' name='recurso' value='$c_recurso'>
                            </div>";
                                }
                                if ($registro['tipo'] == 'E') {
                                    echo "<label class='col-sm-2 col-form-label'>Espaço Físico</label>
                            <div class='col-sm-6'>
                                <input type='text' readonly  class='form-control' id = 'espaco' name='espaco' value='$c_espaco'>
                            </div>";
                                }
                                ?>
                            </div>
                            <br>
                            <!-- select da tabela de ocorrencias -->
                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Ocorrência</label>
                                <div class="col-sm-6">
                                    <select class="form-select form-select-lg mb-2" id="ocorrencia" name="ocorrencia">

                                        <?php
                                        // select da tabela de ocorrencias
                                        $c_sql_ocorrencia = "SELECT ocorrencias.id, ocorrencias.descricao FROM ocorrencias 
                                        ORDER BY ocorrencias.descricao";
                                        $result_ocorrencia = $conection->query($c_sql_ocorrencia);
                                        while ($c_linha2 = $result_ocorrencia->fetch_assoc()) {
                                            $op = "";
                                            if ($c_linha2['id'] == $registro['id_ocorrencia']) {
                                                $op = "selected";
                                            }
                                            echo "<option  value='$c_linha2[id]' $op>$c_linha2[descricao]</option>";
                                        }
                                        ?>
                                    </select>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Descritivo</label>
                                <div class="col-sm-6">
                                    <input type="text" <?php echo $c_estado; ?> maxlength="50" class="form-control" name="descritivo" value="<?php echo $c_descritivo; ?>">
                                </div>
                            </div>

                            <!-- executor responsavel -->
                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Executor Responsável </label>
                                <div class="col-sm-6">
                                    <select class="form-select form-select-lg mb-3" id="executor_responsavel" name="executor_responsavel" required>

                                        <?php
                                        // select da tabela de setores
                                        $c_sql_resp = "SELECT executores.id, executores.nome FROM executores  ORDER BY executores.nome";
                                        $result_resp = $conection->query($c_sql_resp);
                                        while ($c_linha = $result_resp->fetch_assoc()) {
                                            $op = "";
                                            if ($c_linha['id'] == $registro['id_executor_responsavel']) {
                                                $op = "selected";
                                            }
                                           echo "  
                                    <option value='$c_linha[id]' $op>$c_linha[nome]</option>";
                                        }
                                        ?>
                                    </select>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Solicitante</label>
                                <div class="col-sm-6">
                                    <input type="text" readonly maxlength="50" class="form-control" name="responsavel" value="<?php echo $c_nome_responsavel; ?>">
                                </div>
                            </div>

                            <div class="row mb-8">
                                <label class="col-md-2 form-label">Data do Inicio</label>
                                <div class="col-sm-2">
                                    <input type="Date" <?php echo $c_estado; ?> class="form-control" name="data_inicio" id="data_inicio" value='<?php echo $c_data_inicio; ?>'>
                                </div>
                                <label class="col-md-2 form-label">Hora do Inicio</label>
                                <div class="col-sm-2">
                                    <input type="time" <?php echo $c_estado; ?> class="form-control" name="hora_inicio" id="hora_geracao" value="<?php echo $c_hora_inicio ?>">
                                </div>
                            </div>
                            <br>

                            <div class="row mb-8">
                                <label class="col-sm-2 col-form-label">Setor </label>
                                <div class="col-sm-3">
                                    <select <?php echo $c_ativa; ?> class="form-select form-select-lg mb-3" id="setor" name="setor" <?php echo $c_estado; ?>>

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
                                <label class="col-sm-1 col-form-label">Solicitação</label>
                                <div class="col-sm-2">
                                    <input type="text" readonly class="form-control" id="solicitacao" name="solicitacao" value="<?php echo $i_solicitacao; ?>">
                                </div>
                            </div>

                            <div class="row mb-8">
                                <label class="col-sm-2 col-form-label">Tipo da Ordem</label>
                                <div class="col-sm-2">
                                    <select <?php echo $c_estado; ?> <?php echo $c_ativa; ?> onchange="verifica(value)" class="form-select form-select-lg mb-3" id="tipo" name="tipo" value="<?php echo $c_tipo; ?>">
                                        <option <?= ($registro['tipo_ordem'] == 'C') ? 'selected' : '' ?> value='C'>Corretiva</option>
                                        <option <?= ($registro['tipo_ordem'] == 'P') ? 'selected' : '' ?> value="P">Preventiva</option>
                                    </select>
                                </div>

                                <label class="col-sm-2 col-form-label">Corretiva</label>
                                <div class="col-sm-2">
                                    <select <?php echo $hab_corretiva ?> <?php echo $c_ativa; ?> class="form-select form-select-lg mb-3" id="tipo_corretiva" name="tipo_corretiva" value="<?php echo $c_tipo_corretiva; ?>">
                                        <option value='P' <?= ($registro['tipo_corretiva'] == 'P') ? 'selected' : '' ?>>Programada</option>
                                        <option value='U' <?= ($registro['tipo_corretiva'] == 'U') ? 'selected' : '' ?>>Urgênte</option>
                                    </select>
                                </div>

                            </div>

                            <div class="row mb-8">
                                <label class="col-sm-2 col-form-label">Tipo da Preventiva</label>
                                <div class="col-sm-2">

                                    <select <?php echo $hab_preventiva ?> <?php echo $c_ativa; ?> class="form-select form-select-lg mb-3" id="tipo_preventiva" name="tipo_preventiva" value="<?php echo $c_tipo_preventiva; ?>">
                                        <option value='R' <?= ($registro['tipo_corretiva'] == 'R') ? 'selected' : '' ?>>Rotina</option>
                                        <option value='P' <?= ($registro['tipo_corretiva'] == 'P') ? 'selected' : '' ?>>Preditiva</option>
                                        <option value='S' <?= ($registro['tipo_corretiva'] == 'S') ? 'selected' : '' ?>>Sistematica</option>
                                    </select>
                                </div>
                                <label class="col-sm-2 col-form-label">Status</label>
                                <div class="col-sm-2">
                                    <input readonly type="text" class="form-control" name="status" id="status" value="<?php echo $c_status ?>">
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
                                    <textarea <?php echo $c_estado; ?> class="form-control" id="descricao" name="descricao" rows="10"><?php echo $c_descricao ?></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- aba de informações do atendimento da ordem-->
                    <div role="tabpanel" class="tab-pane" id="aba_atendimento">
                        <div style="padding-top:15px;padding-left:20px;">
                            <div class="row mb-8">
                                <div class="form-check col-sm-3">
                                    <label class="form-check-label col-form-label">Registro de Mau uso</label>
                                    <div class="col-sm-1">
                                        <input <?php echo $c_estado; ?> <?php echo $c_mau_uso ?> class="form-check-input" type="checkbox" value="S" name="chk_mau_uso" id="chk_mau_uso">
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Oficina </label>
                                <div class="col-sm-3">
                                    <select <?php echo $c_ativa; ?> class="form-select form-select-lg mb-3" id="oficina" name="oficina" <?php echo $c_estado; ?>>

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
                            <div class="row mb-8">
                                <label class="col-md-2 form-label">Data da Entrada</label>
                                <div class="col-sm-2">
                                    <input <?php echo $c_estado; ?> type="Date" class="form-control" name="data_entrada" id="data_entrada" value='<?php echo $c_data_entrada; ?>'>
                                </div>
                                <label class="col-md-2 form-label">Hora da Entrada</label>
                                <div class="col-sm-2">
                                    <input <?php echo $c_estado; ?> type="time" class="form-control" name="hora_entrada" id="hora_entrada" value="<?php echo $c_hora_entrada ?>">
                                </div>
                            </div>
                            <br>
                            <div class="row mb-8">
                                <label class="col-md-2 form-label">Data da Previsão</label>
                                <div class="col-sm-2">
                                    <input <?php echo $c_estado; ?> type="Date" class="form-control" name="data_previsao" id="data_previsao" value='<?php echo $c_data_previsao; ?>'>
                                </div>
                                <label class="col-md-2 form-label">Hora da Previsão</label>
                                <div class="col-sm-2">
                                    <input <?php echo $c_estado; ?> type="time" class="form-control" name="hora_previsao" id="hora_previsao" value="<?php echo $c_hora_previsao ?>">
                                </div>
                            </div>
                            <br>
                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Situação</label>
                                <div class="col-sm-2">
                                    <select <?php echo $c_estado; ?> <?php echo $c_ativa; ?> onchange="conformidade(value)" class="form-select form-select-lg mb-3" id="situacao" name="situacao" value="<?php echo $c_situacao; ?>">
                                        <option <?= ($registro['situacao'] == 'C') ? 'selected' : '' ?> value='C'>Conforme</option>
                                        <option <?= ($registro['situacao'] == 'N') ? 'selected' : '' ?> value="N">Não Conforme</option>
                                    </select>
                                </div>
                                <label class="col-sm-2 col-form-label">Motivo de Não Conformidade</label>
                                <div class="col-sm-2">
                                    <select <?php echo $c_hab_nao_conformidade ?> <?php echo $c_ativa; ?> class="form-select form-select-lg mb-3" id="nao_conforme" name="nao_conforme" value="<?php echo $c_nao_conforme; ?>">
                                        <option value='N'>Não se aplica</option>
                                        <option <?= ($registro['motivo_naoconformidade'] == 'D') ? 'selected' : '' ?> value='D'>Descontinuidade</option>
                                        <option <?= ($registro['motivo_naoconformidade'] == 'R') ? 'selected' : '' ?> value="R">Re-Classificação</option>
                                        <option <?= ($registro['motivo_naoconformidade'] == 'A') ? 'selected' : '' ?> value="A">Ajuste</option>
                                    </select>
                                </div>
                            </div>


                        </div>
                    </div>
                    <!-- aba de informações da conclusão da ordem-->
                    <div role="tabpanel" class="tab-pane" id="aba_conclusao">
                        <div style="padding-top:15px;padding-left:20px;">
                            <div class="row mb-8">
                                <label class="col-md-2 form-label">Data Conclusão</label>
                                <div class="col-sm-2">
                                    <input readonly type="Date" class="form-control" name="data_conclusao" id="data_conclusao" value='<?php echo $c_data_conclusao; ?>'>
                                </div>
                                <label class="col-md-1 form-label">Hora Conclusão</label>
                                <div class="col-sm-2">
                                    <input readonly type="time" class="form-control" name="hora_conclusao" id="hora_conclusao" value="<?php echo $c_hora_conclusao ?>">
                                </div>
                            </div>

                            <div class="row mb-8">
                                <label class="col-md-2 form-label">Data Entrega</label>
                                <div class="col-sm-2">
                                    <input type="Date" class="form-control" name="data_entrega" id="data_entrega" value='<?php echo $c_data_entrega; ?>'>
                                </div>
                                <label class="col-md-1 form-label">Hora Entrega</label>
                                <div class="col-sm-2">
                                    <input type="time" class="form-control" name="hora_entrega" id="hora_entrega" value="<?php echo $c_hora_entrega ?>">
                                </div>
                            </div>

                            <div class="row mb-8">
                                <label class="col-md-2 form-label">Data Saída</label>
                                <div class="col-sm-2">
                                    <input type="Date" class="form-control" name="data_saida" id="data_saida" value='<?php echo $c_data_saida; ?>'>
                                </div>
                                <label class="col-md-1 form-label">Data Garantia</label>
                                <div class="col-sm-2">
                                    <input type="Date" class="form-control" name="data_garantia" id="data_garantia" value='<?php echo $c_data_garantia; ?>'>
                                </div>

                            </div>

                            <div class="row mb-8">
                                <label class="col-sm-2 col-form-label">No. Nota</label>
                                <div class="col-sm-2">
                                    <input type="text" maxlength="20" class="form-control" name="nota" id="nota" value="<?php echo $c_nota; ?>">
                                </div>
                                <label class="col-sm-1 col-form-label">Valor de serviço</label>
                                <div class="col-sm-2">
                                    <input <?php echo $c_estado; ?> type="text" class="form-control" name="valor_servico" id="valor_servico" value="<?php echo $c_valor_servico; ?>">
                                </div>

                            </div>
                            <div class="row mb-8">
                                <label class="col-sm-2 col-form-label">Valor de Material</label>
                                <div class="col-sm-2">
                                    <input <?php echo $c_estado; ?> type="text" class="form-control" name="valor_material" id="valor_material" value="<?php echo $c_valor_material; ?>">
                                </div>
                            </div>
                            <br>
                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Conclusão</label>
                                <div class="col-sm-8">
                                    <textarea readonly class="form-control" id="conclusao" name="conclusao" rows="6"><?php echo $c_conclusao ?></textarea>
                                </div>

                            </div>
                            <br>
                        </div>
                    </div>
                    <!-- aba de informações de cancelamento quando houver-->
                    <?php
                    if ($registro['status'] == 'X') {
                        $i_canc = $registro['id_resp_cancelamento'];
                        $c_sql_canc = "select nome from usuarios where id='$i_canc'";
                        $result_canc = $conection->query($c_sql_canc);
                        $c_linha_canc = $result_canc->fetch_assoc();
                        $c_resp_cancelamento = $c_linha_canc['nome'];
                        //
                        $c_data_cancelamento = $registro['data_cancelamento'];
                        $c_hora_cancelamento = $registro['hora_cancelamento'];
                        $c_motivo_cancelamento = $registro['motivo_cancelamento'];
                    }
                    ?>

                    <div role="tabpanel" class="tab-pane" id="aba_cancelamento">
                        <div style="padding-top:15px;padding-left:20px;">
                            <div class="row mb-8">
                                <label <?php echo $c_estado; ?> class="col-sm-2 col-form-label">Cancelado por</label>
                                <div class="col-sm-6">
                                    <input readonly type="text" class="form-control" name="resp_cancelamento" id="resp_cancelamento" value="<?php echo $c_resp_cancelamento; ?>">
                                </div>
                            </div>
                            <br>
                            <div class="row mb-8">
                                <label class="col-md-2 form-label">Data Cancelamento</label>
                                <div class="col-sm-2">
                                    <input readonly type="Date" class="form-control" name="data_cancelamento" id="hora_cancelamento" value='<?php echo $c_data_cancelamento; ?>'>
                                </div>
                                <label class="col-md-2 form-label">Hora Cancelamento</label>
                                <div class="col-sm-2">
                                    <input readonly type="time" class="form-control" name="hora_cancelamento" id="hora_cancelamento" value="<?php echo $c_hora_cancelamento ?>">
                                </div>
                            </div>
                            <br>
                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Motivo</label>
                                <div class="col-sm-8">
                                    <textarea readonly class="form-control" id="motivo_cancelamento" name="motivo_cancelamento" rows="6"><?php echo $c_motivo_cancelamento ?></textarea>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <?php
                        if ($registro['status'] <> 'X' && $registro['status'] <> 'C' && $_SESSION['ver_os'] == false)
                            echo '<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-saved"></span> Salvar</button>';
                        if ($_SESSION['ver_os'] == false) {
                            echo "
                            <a class='btn btn-danger' href='/gop/ordens/ordens_gerenciar.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>";
                        } else {
                            echo "
                            <a class='btn btn-danger' href='/gop/agenda/agenda_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>";
                        }

                        ?>
                    </div>
                </div>

            </form>
        </div>
    </div>

</body>

</html>