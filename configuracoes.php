<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include('links2.php');
include('conexao.php');
include_once "lib_gop.php";
// verifico se tabela de configurações já possui registro
$msg_erro = "";
$msg_gravou = "";
$c_sql = "select count(*) as registros from configuracoes";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
if ($registro['registros'] == 0) { // tabela vazia crio o registro unico em branco
    $c_sql = "insert into configuracoes (empresa,cnpj,responsavel,fone1,fone2,url, email_manutencao, emailcc_manutencao, emailco_manutencao) 
  values ('','','','','','','','','')";
    $result = $conection->query($c_sql);
    //
    $c_empresa = '';
    $c_cnpj = '';
    $c_responsavel = '';
    $c_fone1 = '';
    $c_fone2 = '';
    $c_url = '';
    $c_email = '';
    $c_emailcc = '';
    $c_emailco = '';
    $c_email_envio = '';
    $c_host_email = '';
    $c_porta_email = '';
    $c_senha_emailnotificacoes = '';
} else {
    $c_sql = "select * from configuracoes";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();
    $c_empresa = $registro['empresa'];
    $c_cnpj = $registro['cnpj'];
    $c_responsavel = $registro['responsavel'];
    $c_fone1 = $registro['fone1'];
    $c_fone2 = $registro['fone2'];
    $c_url = $registro['url'];
    $c_email = $registro['email_manutencao'];
    $c_emailcc = $registro['emailcc_manutencao'];
    $c_emailco = $registro['emailco_manutencao'];
    $c_email_envio = $registro['email_envio'];
    $c_host_email = $registro['email_host'];
    $c_porta_email = $registro['porta_smtp'];
    $c_senha_email = $registro['senha_email'];
    //checks
    if ($registro['solicitacao_recursos'] == 'S') {
        $c_chkrecursosfisicos = 'checked';
    } else {
        $c_chkrecursosfisicos = 'N';
    }
    if ($registro['solicitacao_espacos'] == 'S') {
        $c_chkespacosfisicos = 'checked';
    } else {
        $c_chkespacosfisicos = 'N';
    }
    if ($registro['solicitacao_avulsa'] == 'S') {
        $c_chkavulsa = 'checked';
    } else {
        $c_chkavulsa = 'N';
    }
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {  // metodo POST para gravar alterações de configurações
    $c_empresa = $_POST['empresa'];
    $c_cnpj =  $_POST['cnpj'];
    $c_responsavel =  $_POST['responsavel'];
    $c_fone1 =  $_POST['fone1'];
    $c_fone2 =  $_POST['fone2'];
    $c_url =  $_POST['url'];
    $c_email =  $_POST['email'];
    $c_emailcc =  $_POST['emailcc'];
    // $c_emailco =  $_POST['emailco'];
    $c_email_envio =  $_POST['email_envio'];
    $c_host_email =  $_POST['host_email'];
    $c_porta_email =  $_POST['porta_email'];
    $c_senha_email =  $_POST['senha_email'];
    // checks
    if (isset($_POST['chkrecursosfisicos'])) {
        $c_chkrecursosfisicos = 'S';
    } else {
        $c_chkrecursosfisicos = 'N';
    }
    if (isset($_POST['chkespacosfisicos'])) {
        $c_chkespacosfisicos = 'S';
    } else {
        $c_chkespacosfisicos = 'N';
    }
    if (isset($_POST['chkavulsas'])) {
        $c_chkavulsas = 'S';
    } else {
        $c_chkavulsas = 'N';
    }
    do {
        if (!valida_cnpj($c_cnpj)) {
            $msg_erro = "Campo CNPJ inválido, favor verificar!!";
            break;
        }
        // verificos se todos as opções de solicitações estão desmarcadas. Se sim não deixar. tem que haver pelo menos uma
        if ($c_chkrecursosfisicos=='N'&&$c_chkespacosfisicos=='N'&&$c_chkavulsas=='N'){
            $msg_erro = "Pelo menos uma opção de solicitação deve estar marcada! Favor verifica!";
            break;
        }
        $c_sql_up = "update configuracoes set empresa='$c_empresa', cnpj = '$c_cnpj', responsavel='$c_responsavel', fone1='$c_fone1',
                    fone2='$c_fone2', url='$c_url', email_manutencao='$c_email', emailcc_manutencao='$c_emailcc', 
                    emailco_manutencao='$c_emailco', email_envio='$c_email_envio',
                    email_host='$c_host_email', porta_smtp='$c_porta_email',
                    senha_email='$c_senha_email', solicitacao_recursos='$c_chkrecursosfisicos'
                    ,solicitacao_espacos='$c_chkespacosfisicos', solicitacao_avulsa='$c_chkavulsas'";
        $result = $conection->query($c_sql_up);
        //header('location: /gop/menu.php');
    } while (false);
    $c_sql = "select * from configuracoes";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();
    $c_empresa = $registro['empresa'];
    $c_cnpj = $registro['cnpj'];
    $c_responsavel = $registro['responsavel'];
    $c_fone1 = $registro['fone1'];
    $c_fone2 = $registro['fone2'];
    $c_url = $registro['url'];
    $c_email = $registro['email_manutencao'];
    $c_emailcc = $registro['emailcc_manutencao'];
    $c_emailco = $registro['emailco_manutencao'];
    $c_email_envio = $registro['email_envio'];
    $c_host_email = $registro['email_host'];
    $c_porta_email = $registro['porta_smtp'];
    $c_senha_email = $registro['senha_email'];
    //checks
    if ($registro['solicitacao_recursos'] == 'S') {
        $c_chkrecursosfisicos = 'checked';
    } else {
        $c_chkrecursosfisicos = 'N';
    }
    if ($registro['solicitacao_espacos'] == 'S') {
        $c_chkespacosfisicos = 'checked';
    } else {
        $c_chkespacosfisicos = 'N';
    }
    if ($registro['solicitacao_avulsa'] == 'S') {
        $c_chkavulsa = 'checked';
    } else {
        $c_chkavulsa = 'N';
    }
    $msg_gravou = "Configurações gravadas com sucesso!";
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/gop/css/basico.css">

</head>

<body>
    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Configurações e Parâmetros do Sistema<h5>
                </div>
            </div>
        </div>

        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <div style='padding-left:15px;'>
                    <h5><img Align='left' src='\gop\images\aviso.png' alt='30' height='35'> $msg_erro</h5>
                </div>
                
            </div>
            ";
        }
        ?>
        <div class="container content-box">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
                </div>
                <h5>Preencha os campos com as configuração do Sistema. Campos com (*) são obrigatórios</h5>
            </div>
            <form method="post">
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Nome da Empresa (*)</label>
                    <div class="col-sm-8">
                        <input type="text" maxlength="200" class="form-control" name="empresa" value="<?php echo $c_empresa; ?>" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">CNPJ (*)</label>
                    <div class="col-sm-2">
                        <input type="text" maxlength="18" class="form-control" name="cnpj" value="<?php echo $c_cnpj; ?>" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Responsável (*)</label>
                    <div class="col-sm-5">
                        <input type="text" maxlength="100" class="form-control" name="responsavel" value="<?php echo $c_responsavel; ?>" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Fone 1 (*)</label>
                    <div class="col-sm-2">
                        <input type="text" maxlength="20" class="form-control" name="fone1" value="<?php echo $c_fone1; ?>" required>
                    </div>
                    <label class="col-sm-1 col-form-label">Fone 2</label>
                    <div class="col-sm-2">
                        <input type="text" maxlength="20" class="form-control" name="fone2" value="<?php echo $c_fone2; ?>">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">URL</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="200" class="form-control" name="url" value="<?php echo $c_url; ?>" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">e-mail Manutenção</label>
                    <div class="col-sm-6">
                        <input type="email" maxlength="150" class="form-control" name="email" value="<?php echo $c_email; ?>" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">e-mail Manutenção Cc.</label>
                    <div class="col-sm-6">
                        <input type="email" maxlength="150" class="form-control" name="emailcc" value="<?php echo $c_emailcc; ?>">
                    </div>
                </div>
                <hr>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">e-mail de envio </label>
                    <div class="col-sm-6">
                        <input type="email" maxlength="150" class="form-control" name="email_envio" value="<?php echo $c_email_envio; ?>">
                    </div>
                </div>
                <!-- host do servidor de email -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Host do Servidor de e-mail</label>
                    <div class="col-sm-2">
                        <input type="text" maxlength="150" class="form-control" name="host_email" value="<?php echo $c_host_email; ?>">
                    </div>
                </div>
                <!-- porta do servidor de email -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Porta do Servidor de e-mail</label>
                    <div class="col-sm-1">
                        <input type="text" maxlength="10" class="form-control" name="porta_email" value="<?php echo $c_porta_email; ?>">
                    </div>
                </div>
                <!-- senha do email utilizado para envio de notificações automáticas -->
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Senha do e-mail de envio</label>
                    <div class="col-sm-3">
                        <input type="text" maxlength="150" class="form-control" name="senha_email" value="<?php echo $c_senha_email; ?>">
                    </div>
                </div>
                <hr>
                <div class="row mb-3">
                    <p><strong>Opções de solicitação de serviço</strong></p>
                </div>

                <div class="row mb-3">
                    <!-- opções de check com opções de solicitações de serviço -->
                    <div class="form-check col-sm-3">
                        <label class="form-check-label col-form-label">Recursos Físicos</label>
                        <div class="col-sm-2">
                            <input class="form-check-input" type="checkbox" value="S" name="chkrecursosfisicos" id="chkrecursosfisicos" <?php echo $c_chkrecursosfisicos ?>>
                        </div>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="form-check col-sm-3">
                        <label class="form-check-label col-form-label">Espaços Físicos</label>
                        <div class="col-sm-2">
                            <input class="form-check-input" type="checkbox" value="S" name="chkespacosfisicos" id="chkespacosfisicos" <?php echo $c_chkespacosfisicos ?>>
                        </div>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="form-check col-sm-3">
                        <label class="form-check-label col-form-label">Avulsas</label>
                        <div class="col-sm-2">
                            <input class="form-check-input" type="checkbox" value="S" name="chkavulsas" id="chkavulsas" <?php echo $c_chkavulsa ?>>
                        </div>
                    </div>
                </div>

                <hr>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                        <a class='btn btn-danger' href='/gop/menu.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                    </div>
                </div>
                <?php
                if (!empty($msg_gravou)) {
                    echo "
                    <div class='row mb-3'>
                        <div class='offset-sm-3 col-sm-6'>
                             <div class='alert alert-success alert-dismissible fade show' role='alert'>
                                <strong>$msg_gravou</strong>

                             </div>
                        </div>     
                    </div>    
                ";
                }
                ?>
            </form>
        </div>
    </div>

</body>

</html>