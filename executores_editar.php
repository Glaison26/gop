<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("conexao.php");
include("links2.php");

include_once "lib_gop.php";

// rotina de post dos dados do formuário
$c_id = "";
$c_nome = '';
$c_tipo = '';
$c_endereco = '';
$c_bairro = '';
$c_cidade = '';
$c_estado = '';
$c_cep = '';
$c_email = '';
$c_url = '';
$c_formacao = '';
$c_contato = '';
$c_fone1 = '';
$c_fone2 = '';
$c_fone3 = '';
$n_salario = '0.00';
$c_cnpj_cpf = '';
$i_horastrab = '0.00';
$n_valorhora = '0.00';
$c_escolaridade = '';
$c_obs = '';

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/executores_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from executores where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/executores_lista.php');
        exit;
    }

    $c_nome = $registro["nome"];
    $c_tipo = $registro["tipo"];
    $c_endereco = $registro["endereco"];
    $c_bairro = $registro["bairro"];
    $c_cidade = $registro["cidade"];
    $c_estado = $registro["uf"];
    $c_cep = $registro["cep"];
    $c_email = $registro["email"];
    $c_url = $registro["url"];
    $c_formacao = $registro["formacao"];
    $c_contato = $registro["contato"];
    $c_fone1 = $registro["fone1"];
    $c_fone2 = $registro["fone2"];
    $c_fone3 = $registro["fone3"];
    $n_salario = $registro["salario"];;
    $c_cnpj_cpf = $registro["cpf_cnpj"];
    $i_horastrab = $registro["horastrab"];
    $n_valorhora = $registro["valorhora"];
    $c_escolaridade = $registro["escolaridade"];
    $c_obs = $registro["obs"];
} else {
    // metodo post para atualizar dados
    $c_id = $_POST["id"];
    $c_nome = $_POST['nome'];
    $c_tipo = $_POST['tipo'];
    $c_endereco = $_POST['endereco'];
    $c_bairro = $_POST['bairro'];
    $c_cidade = $_POST['cidade'];
    $c_estado = $_POST['estado'];
    $c_cep = $_POST['cep'];
    $c_email = $_POST['email'];
    $c_url = $_POST['url'];
    $c_formacao = $_POST['formacao'];
    $c_contato = $_POST['contato'];
    $c_fone1 = $_POST['fone1'];
    $c_fone2 = $_POST['fone2'];
    $c_fone3 = $_POST['fone3'];
    $n_salario = $_POST['salario'];
    $c_cnpj_cpf = $_POST['cpfcnpj'];
    $i_horastrab = $_POST['horastrab'];
    $n_valorhora = $_POST['valorhora'];
    $c_escolaridade = $_POST['escolaridade'];
    $c_obs = $_POST['obs'];
    $c_funcao = $_POST['funcao'];
    $c_oficina = $_POST['oficina'];
    if ($i_horastrab == '') {
        $i_horastrab = 0;
    }
    if ($n_valorhora == '') {
        $n_valorhora = 0;
    }
    do {
        if (empty($c_nome) || empty($c_endereco) || empty($c_cnpj_cpf) || empty($c_bairro) || empty($c_cidade) || empty($c_cep)) {
            $msg_erro = "Campos Nome, endereco, bairro, cidade, cep e CPF/CNPJ devem ser preenchidos!!";
            break;
        }
        // mascara e validação para cpf ou cnpj

        if ($c_tipo == "Física") {
            //$c_cnpj_cpf = mask($c_cnpj_cpf, "###.###.###-##");
            $c_tipo = 'F';
            if (!validaCPF($c_cnpj_cpf)) {
                $msg_erro = "CPF informado inválido!!";
                break;
            }
        } else {
            //$c_cnpj_cpf = mask($c_cnpj_cpf, "##.###.###/####-##");
            $c_tipo = 'J';
            if (!valida_cnpj($c_cnpj_cpf)) {
                $msg_erro = "CNPJ informado inválido!!";
                break;
            }
        }
        // select da tabela de oficinas para pegar codigo
        $c_sql_secundario = "SELECT oficinas.id FROM oficinas where oficinas.descricao='$c_oficina' ORDER BY oficinas.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_oficina = $registro_secundario['id'];
        // select da tabela de FUNCOES para pegar codigo
        $c_sql_secundario = "SELECT funcoes.id FROM funcoes where funcoes.descricao='$c_funcao' ORDER BY funcoes.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_funcao = $registro_secundario['id'];
        // grava dados no banco
        // faço a Leitura da tabela com sql
        $c_sql = "Update executores" .
            " SET id_oficina= '$i_oficina', id_funcao='$i_funcao', nome='$c_nome', endereco='$c_endereco'," .
            " bairro='$c_bairro',cep='$c_cep',cidade='$c_cidade',uf='$c_estado'," .
            " contato='$c_contato',tipo='$c_tipo',cpf_cnpj='$c_cnpj_cpf',email='$c_email',url='$c_url'," .
            " fone1='$c_fone1',fone2='$c_fone2',fone3='$c_fone3',salario='$n_salario',horastrab='$i_horastrab'," .
            " valorhora='$n_valorhora',escolaridade='$c_escolaridade',formacao='$c_formacao',obs='$c_obs'" .
            " where id=$c_id";
        echo $c_sql;
        $result = $conection->query($c_sql);

        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/executores_lista.php');
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
                    <h5>Editar dados de Executor de Serviço<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Campos com (*) são obrigatórios</h5>
        </div>
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <h4>$msg_erro</h4>
            </div>
                ";
        }
        ?>

        <form method="post">
            <input type="hidden" name="id" value="<?php echo $c_id; ?>">
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Nome </label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="nome" value="<?php echo $c_nome; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Tipo Executor </label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="tipo" name="tipo">
                        <option <?= ($c_tipo == 'J') ? 'selected' : '' ?>>Juridica</option>
                        <option <?= ($c_tipo == 'F') ? 'selected' : '' ?>>Física</option>
                    </select>
                </div>
                <label class="col-sm-2 col-form-label">CNPJ/CPF</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="18" class="form-control" name="cpfcnpj" placeholder="somente números" value="<?php echo $c_cnpj_cpf; ?>">
                </div>
            </div>
           
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Contato</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" class="form-control" name="contato" value="<?php echo $c_contato; ?>">
                </div>
            </div>
            

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Função/Cargo </label>
                <div class="col-sm-3">
                    <select class="form-select form-select-lg mb-3" id="funcao" name="funcao">
                        <?php
                        // select da tabela de funções
                        $c_sql_secundario = "SELECT funcoes.id, funcoes.descricao FROM funcoes ORDER BY funcoes.descricao";
                        $result_secundario = $conection->query($c_sql_secundario);
                        while ($c_linha = $result_secundario->fetch_assoc()) {
                            if ($c_linha['id'] == $i_funcao) {
                                $op =  'Selected';
                            } else {
                                $op = '';
                            }
                            echo "
                               <option $op>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
                <label class="col-sm-1 col-form-label">Oficina </label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="oficina" name="oficina">
                        <?php
                        // select da tabela de oficinas
                        $c_sql_oficina = "SELECT oficinas.id, oficinas.descricao FROM oficinas ORDER BY oficinas.descricao";
                        $result_oficina = $conection->query($c_sql_oficina);
                        while ($c_linha = $result_oficina->fetch_assoc()) {
                            if ($c_linha['id'] == $i_oficina) {
                                $op = 'selected';
                            } else {
                                $op = '';
                            }
                            echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fone I</label>
                <div class="col-sm-2">
                    <input type="tel" maxlength="20" onkeyup="handlePhone(event)" id="fone1" class="form-control" name="fone1" value="<?php echo $c_fone1; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Fone II</label>
                <div class="col-sm-2">
                    <input type="tel" maxlength="20" onkeyup="handlePhone(event)" id="fone2" class="form-control" name="fone2" value="<?php echo $c_fone2; ?>">
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

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">E-mail</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" id="email" class="form-control" name="email" placeholder="E-mail" value="<?php echo $c_email; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Site</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" id="url" class="form-control col-xs-12" name="url" value="<?php echo $c_url; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Formação</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="formacao" id="formacao" value="<?php echo $c_formacao; ?>">
                </div>
            </div>


            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Escolaridade</label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="escolaridade" name="escolaridade">
                        <option <?= ($c_escolaridade == 'Primário') ? 'selected' : '' ?>>Primário</option>
                        <option <?= ($c_escolaridade == '1o. Grau') ? 'selected' : '' ?>>1o. Grau</option>
                        <option <?= ($c_escolaridade == '2o. Grau') ? 'selected' : '' ?>>2o. Grau</option>
                        <option <?= ($c_escolaridade == 'Curso Superior') ? 'selected' : '' ?>>Curso Superior</option>
                    </select>
                </div>

                <label class="col-sm-2 col-form-label">Salário</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="salario" id="salario" value="<?php echo $n_salario; ?>">
                </div>

            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Valor da hora</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="valorhora" id="valorhora" value="<?php echo $n_valorhora; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Horas Trabalhadas dia</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="horastrab" id="horastrab" value="<?php echo $i_horastrab; ?>">
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
                    <a class='btn btn-danger' href='/gop/executores_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>

        </form>
    </div>

</body>

</html>