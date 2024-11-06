<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include('links2.php');
include('conexao.php');
include_once "lib_gop.php";
// verifico se tabela de configurações já possui registro
$msg_erro="";
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
    $c_emailco =  $_POST['emailco'];
    //
    do {
        if (!valida_cnpj($c_cnpj))
        {
            $msg_erro = "Campo CNPJ inválido, favor verificar!!";
            break;  
        }
        $c_sql_up = "update configuracoes set empresa='$c_empresa', cnpj = '$c_cnpj', responsavel='$c_responsavel', fone1='$c_fone1', fone2='$c_fone2',
                    url='$c_url', email_manutencao='$c_email', emailcc_manutencao='$c_emailcc', emailco_manutencao='$c_emailco'";
        $result = $conection->query($c_sql_up);
        header('location: /gop/menu.php');
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
    <div class="container  -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Configurações e Parâmetros do Sistema<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Preencha os campos com as configuração do Sistema. Campos com (*) são obrigatórios</h5>
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
        <br>
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
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">e-mail Manutenção Co.</label>
                <div class="col-sm-6">
                    <input type="email" maxlength="150" class="form-control" name="emailco" value="<?php echo $c_emailco; ?>">
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/menu.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>
            </div>
        </form>
    </div>

</body>

</html>