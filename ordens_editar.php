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
    // sql para pegar o responsável

    $c_responsavel = $registro['id_responsavel'];
    $c_sql_responsavel = "Select id,nome from usuarios where id='$c_responsavel'";
    $result_responsavel = $conection->query($c_sql_responsavel);
    $registro_responsavel = $result_responsavel->fetch_assoc();
    // capturo dados da tabela para as variaveis
    $c_data_geracao = $registro['data_geracao'];
    $c_hora_geracao = $registro['hora_geracao'];
    $c_nome_responsavel = $registro_responsavel['nome'];
} else {
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

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
        <!-- abas de ediçao de ordem de serviço -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#dados" aria-controls="dados" role="tab" data-toggle="tab">Informações de Abertura</a></li>
            <li role="presentation"><a href="#solicitacao" aria-controls="solicitacao" role="tab" data-toggle="tab">Informação da Solicitação</a></li>
            <li role="presentation"><a href="#atendimento" aria-controls="atendimento" role="tab" data-toggle="tab">Informações do Atendimento</a></li>
            <li role="presentation"><a href="#conclusao" aria-controls="conclusao" role="tab" data-toggle="tab">Informações da Conclusão</a></li>
        </ul>
        <form method="post">
            <div class="tab-content">
                <!-- aba de informações da ordem-->
                <div role="tabpanel" class="tab-pane active" id="dados">
                    <div style="padding-top:20px;padding-left:20px;">
                        <div class="row mb-8">
                            <label class="col-md-2 form-label">Data da Geração</label>
                            <div class="col-sm-2">
                                <input type="Date" class="form-control" name="data1" id="data_inicio" value='<?php echo $c_data_geracao; ?>' onkeypress="mascaraData(this)">
                            </div>
                            <label class="col-md-2 form-label">Hora da Geração</label>
                            <div class="col-sm-2">
                                <input type="time" class="form-control" name="hora_geracao" id="hora_geracao" value="<?php echo $c_hora_geracao ?>">
                            </div>
                        </div>
                        <br>
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Responsável</label>
                            <div class="col-sm-6">
                                <input type="text" readonly maxlength="50" class="form-control" name="responsavel" value="<?php echo $c_nome_responsavel; ?>">
                            </div>
                        </div>

                    </div>
                </div>
                <!-- aba de informações da solicitação da ordem-->
                <div role="tabpanel" class="tab-pane" id="solicitacao">
                    <div style="padding-top:15px;padding-left:20px;">
                        <p>segunda aba</p>
                    </div>
                </div>
                <!-- aba de informações do atendimento da ordem-->
                <div role="tabpanel" class="tab-pane" id="atendimento">
                    <div style="padding-top:15px;padding-left:20px;">
                        <p>terceira aba</p>
                    </div>
                </div>
                <!-- aba de informações da conclusão da ordem-->
                <div role="tabpanel" class="tab-pane" id="conclusao">
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