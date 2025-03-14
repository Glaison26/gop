<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
include("../../links2.php");
include_once "../../lib_gop.php";

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

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
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
        // mascara para cpf ou cnpj
        if ($c_tipo == "Física") {
            $c_cnpj_cpf = mask($c_cnpj_cpf, "###.###.###-##");
        } else {
            $c_cnpj_cpf = mask($c_cnpj_cpf, "##.###.###/####-##");
        }
        // grava dados no banco

        // faço a inclusão da tabela com sql
        $c_sql = "Insert into fabricantes (descricao, razaosocial, contato, fone1, fone2, endereco," .
            "bairro, cep, estado, email, cidade,  tipo, cnpj_cpf, insc_estad, insc_munic, url, obs  )" .
            "Value ('$c_descricao', '$c_razao', '$c_contato', '$c_fone1', '$c_fone2', '$c_endereco', '$c_bairro'," .
            " '$c_cep', '$c_estado', '$c_email' ,'$c_cidade', '$c_tipo', '$c_cnpj_cpf', '$c_insc_estad', '$c_insc_munic', '$c_url', '$c_obs')";
        echo $c_sql;
        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

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

        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/cadastros/fabricantes/fabricantes_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">


    <script type="text/javascript">
        $(document).ready(function() {
            $("#fone1").mask("(99)9999-9999");
            $("#fone2").mask("(99)9999-9999");
            $("#cnpj_cpf").mask("999999999999999999");
            $("#cep").mask("99.999-999");
        });
    </script>

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
                    <h5>Novo Fabricante<h5>
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
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Nome do Fabricante (*)</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>" required>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Razão Social (*)</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="razaosocial" value="<?php echo $c_razao; ?>" required>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Tipo Fornecedor (*)</label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="tipo" name="tipo" required>
                        <option></option>
                        <option>Juridica</option>
                        <option>Física</option>
                    </select>
                </div>
                <label class="col-sm-2 col-form-label">CNPJ/CPF (*)</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="18" class="form-control" name="cnpj_cpf" placeholder="somente números" value="<?php echo $c_cnpj_cpf; ?>" required>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Contato (*)</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" class="form-control" name="contato" value="<?php echo $c_contato; ?>" required>
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
                <label class="col-sm-3 col-form-label">Endereço</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" id="endereco" class="form-control" name="endereco" value="<?php echo $c_endereco; ?>">
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
                <div class="col-sm-3">
                    <select class="form-select form-select-lg mb-3" id="estado" name="estado">
                        <option></option>
                        <option value="AC">Acre</option>
                        <option value="AL">Alagoas</option>
                        <option value="AP">Amapa</option>
                        <option value="AM">Amazonas</option>
                        <option value="BA">Bahia</option>
                        <option value="CE">Ceara</option>
                        <option value="DF">Distrito Federal</option>
                        <option value="ES">Espirito Santo</option>
                        <option value="GO">Goias</option>
                        <option value="MA">Maranhão</option>
                        <option value="MT">Mato Grosso</option>
                        <option value="MS">Mato Grosso do Sul</option>
                        <option selected value="MG">Minas Gerais</option>
                        <option value="PA">Para</option>
                        <option value="PB">Paraiba</option>
                        <option value="PR">Parana</option>
                        <option value="PE">Pernambuco</option>
                        <option value="PI">Piaui</option>
                        <option value="RJ">Rio de Janeiro</option>
                        <option value="RN">Rio Grande do Norte</option>
                        <option value="RS">Rio Grande do Sul</option>
                        <option value="RO">Rondonia</option>
                        <option value="RR">Roraima</option>
                        <option value="SC">Santa Catarina</option>
                        <option value="SP">São Paulo</option>
                        <option value="SE">Sergipe</option>
                        <option value="TO">Tocantis</option>
                    </select>
                </div>
                <label class="col-sm-1 col-form-label">CEP</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="10" id="cep" class="form-control" name="cep" value="<?php echo $c_cep; ?>">
                </div>
            </div>

            <div class="row mb-3">
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
                    <textarea class="form-control" id="obs" name="obs" rows="3"></textarea>
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