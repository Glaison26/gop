<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
include("../../links2.php");
include_once "lib_gop.php";

// rotina de post dos dados do formuário
$c_id = "";
$c_descricao = "";
$c_razao =  "";
$c_contato =  "";
$c_fone1 =  "";
$c_fone2 =  "";
$c_endereco =  "";
$c_bairro =  "";
$c_cidade =  "";
$c_estado =  "";
$c_cep =  "";
$c_email =  "";
$c_tipo =  "";
$c_cnpj_cpf =  "";
$c_insc_estad = "";
$c_insc_munic =  "";
$c_email =  "";
$c_url =  "";
$c_obs =  "";
// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/cadastros/fabricantes/fabricantes_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from fabricantes where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/cadastros/fabricantes/fabricantes_lista.php');
        exit;
    }
    $c_descricao = $registro['descricao'];
    $c_razao = $registro['razaosocial'];
    $c_contato = $registro['contato'];
    $c_fone1 = $registro['fone1'];
    $c_fone2 = $registro['fone2'];
    $c_endereco = $registro['endereco'];
    $c_bairro = $registro['bairro'];
    $c_cidade = $registro['cidade'];
    $c_estado = $registro['estado'];
    $c_cep = $registro['cep'];
    $c_email = $registro['email'];
    $c_tipo = $registro['tipo'];
    $c_cnpj_cpf = $registro['cnpj_cpf'];
    $c_insc_estad = $registro['insc_estad'];
    $c_insc_munic = $registro['insc_munic'];
    $c_email = $registro['email'];
    $c_url = $registro['url'];
    $c_obs = $registro['obs'];
} else {
    // metodo post para atualizar dados
    $c_id = $_POST["id"];
    $c_descricao = rtrim($_POST['descricao']);
    $c_razao = $_POST['razaosocial'];
    $c_contato = $_POST['contato'];
    $c_fone1 = $_POST['fone1'];
    $c_fone2 = $_POST['fone2'];
    $c_endereco = $_POST['endereco'];
    $c_bairro = $_POST['bairro'];
    $c_cidade = $_POST['cidade'];
    $c_estado = $_POST['estado'];
    $c_cep = $_POST['cep'];
    $c_email = $_POST['email'];
    $c_tipo = $_POST['tipo'];
    $c_cnpj_cpf = $_POST['cnpj_cpf'];
    $c_insc_estad = $_POST['insc_estad'];
    $c_insc_munic = $_POST['insc_munic'];
    $c_email = $_POST['email'];
    $c_url = $_POST['url'];
    $c_obs = $_POST['obs'];

    do {
        if (empty($c_descricao) || empty($c_razao) || empty($c_cnpj_cpf) || empty($c_tipo) || empty($c_contato)) {
            $msg_erro = "Campos Fabricante, razão social, cnpj/cpf, tipo e contato devem ser preenchidos!!";
            break;
        }
        // grava dados no banco
        // faço a Leitura da tabela com sql
        $c_sql = "Update fabricantes" .
            " SET descricao = '$c_descricao', razaosocial='$c_razao', contato='$c_contato', fone1='$c_fone1', fone2='$c_fone2', endereco='$c_endereco'," .
            "bairro='$c_bairro', cep='$c_cep', estado='$c_estado', email='$c_email', cidade='$c_cidade', tipo='$c_tipo', cnpj_cpf='$c_cnpj_cpf'," .
            "insc_estad='$c_insc_estad', insc_munic='$c_insc_munic', url='$c_url', obs='$c_obs'" .
            " where id=$c_id";
        echo $c_sql;
        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/cadastros/fabricantes/fabricantes_lista.php');
    } while (false);
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <script>
        const handlePhone = (event) => {
            let input = event.target
            input.value = phoneMask(input.value)
        }

        const phoneMask = (value) => {
            if (!value) return ""
            value = value.replace(/\D/g, '')
            value = value.replace(/(\d{2})(\d)/, "($1) $2")
            value = value.replace(/(\d)(\d{4})$/, "$1-$2")
            return value
        }
    </script>
</head>

<body>

    <div class="container  -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Editar Fabricante<h5>
                </div>
            </div>
        </div>

        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Campos com (*) são obrigatórios</h5>
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
            <input type="hidden" name="id" value="<?php echo $c_id; ?>">

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Nome do Fabricante (*)</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>" required>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Razão Social</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="razaosocial" value="<?php echo $c_razao; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Tipo Fabricante </label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="tipo" name="tipo">
                        <option <?= ($c_tipo == 'Juridica') ? 'selected' : '' ?>>Juridica</option>
                        <option <?= ($c_tipo == 'Física') ? 'selected' : '' ?>>Física</option>
                    </select>
                </div>
                <label class="col-sm-2 col-form-label">CNPJ/CPF (*)</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="18" class="form-control" name="cnpj_cpf" placeholder="somente números" value="<?php echo $c_cnpj_cpf; ?>" required>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Contato</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" class="form-control" name="contato" value="<?php echo $c_contato; ?>">
                </div>
            </div>
          
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Insc. Estadual</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="16" class="form-control" name="insc_estad" value="<?php echo $c_insc_estad; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Insc. Municipal</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="16" class="form-control" name="insc_munic" value="<?php echo $c_insc_munic; ?>">
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fone I</label>
                <div class="col-sm-2">
                    <input type="tel" onkeyup="handlePhone(event)" maxlength="20" id="fone1" class="form-control" name="fone1" value="<?php echo $c_fone1; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Fone II</label>
                <div class="col-sm-2">
                    <input type="tel" onkeyup="handlePhone(event)" maxlength="20" id="fone2" class="form-control" name="fone2" value="<?php echo $c_fone2; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Bairro</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" id="bairro" class="form-control" name="bairro" value="<?php echo $c_bairro; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Cidade</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" id="cidade" class="form-control" name="cidade" value="<?php echo $c_cidade; ?>">
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Estado</label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="estado" name="estado" value="<?php echo $c_estado; ?>">
                        <option value="AC" <?= ($c_estado == 'AC') ? 'selected' : '' ?>>Acre</option>
                        <option value="AL" <?= ($c_estado == 'AL') ? 'selected' : '' ?>>Alagoas</option>
                        <option value="AP" <?= ($c_estado == 'AP') ? 'selected' : '' ?>>Amapa</option>
                        <option value="AM" <?= ($c_estado == 'AM') ? 'selected' : '' ?>>Amazonas</option>
                        <option value="BA" <?= ($c_estado == 'BA') ? 'selected' : '' ?>>Bahia</option>
                        <option value="CE" <?= ($c_estado == 'CE') ? 'selected' : '' ?>>Ceara</option>
                        <option value="DF" <?= ($c_estado == 'DF') ? 'selected' : '' ?>>Distrito Federal</option>
                        <option value="ES" <?= ($c_estado == 'ES') ? 'selected' : '' ?>>Espirito Santo</option>
                        <option value="GO" <?= ($c_estado == 'GO') ? 'selected' : '' ?>>Goias</option>
                        <option value="MA" <?= ($c_estado == 'MA') ? 'selected' : '' ?>>Maranhão</option>
                        <option value="MT" <?= ($c_estado == 'MT') ? 'selected' : '' ?>>Mato Grosso</option>
                        <option value="MS" <?= ($c_estado == 'MS') ? 'selected' : '' ?>>Mato Grosso do Sul</option>
                        <option value="MG" <?= ($c_estado == 'MG') ? 'selected' : '' ?>>Minas Gerais</option>
                        <option value="PA" <?= ($c_estado == 'PA') ? 'selected' : '' ?>>Para</option>
                        <option value="PB" <?= ($c_estado == 'PB') ? 'selected' : '' ?>>Paraiba</option>
                        <option value="PR" <?= ($c_estado == 'PR') ? 'selected' : '' ?>>Parana</option>
                        <option value="PE" <?= ($c_estado == 'PE') ? 'selected' : '' ?>>Pernambuco</option>
                        <option value="PI" <?= ($c_estado == 'PI') ? 'selected' : '' ?>>Piaui</option>
                        <option value="RJ" <?= ($c_estado == 'RJ') ? 'selected' : '' ?>>Rio de Janeiro</option>
                        <option value="RN" <?= ($c_estado == 'RN') ? 'selected' : '' ?>>Rio Grande do Norte</option>
                        <option value="RS" <?= ($c_estado == 'RS') ? 'selected' : '' ?>>Rio Grande do Sul</option>
                        <option value="RO" <?= ($c_estado == 'RO') ? 'selected' : '' ?>>Rondonia</option>
                        <option value="RR" <?= ($c_estado == 'RR') ? 'selected' : '' ?>>Roraima</option>
                        <option value="SC" <?= ($c_estado == 'SC') ? 'selected' : '' ?>>Santa Catarina</option>
                        <option value="SP" <?= ($c_estado == 'SP') ? 'selected' : '' ?>>São Paulo</option>
                        <option value="SE" <?= ($c_estado == 'SE') ? 'selected' : '' ?>>Sergipe</option>
                        <option value="TO" <?= ($c_estado == 'TO') ? 'selected' : '' ?>>Tocantis</option>
                    </select>
                </div>
                
                <label class="col-sm-2 col-form-label">CEP</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="10" id="cep" class="form-control" name="cep" value="<?php echo $c_cep; ?>">
                </div>
            </div>
           

            <div class=" row mb-3">
                <label class="col-sm-3 col-form-label">E-mail</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" id="email" class="form-control" name="email" placeholder="E-mail" value="<?php echo $c_email; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Site</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" id="url" class="form-control col-xs-12" name="url">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Observação</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="obs" name="obs" rows="3"><?php echo $c_obs ?></textarea>
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
            <br>
            <div class="row mb-3">
                <div class="offset-sm-3 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/cadastros/fabricantes/fabricantes_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>

        </form>
    </div>

</body>

</html>