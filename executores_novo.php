<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// funções 

function carregadados()
{
    $c_nome = $_POST['nome'];
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
    $c_cnpj_cpf = $_POST['cpf_cnpj'];
    $i_horastrab = $_POST['horastrab'];
    $n_valorhora = $_POST['valorhora'];
    $c_escolaridade = $_POST['escolaridade'];
    $c_obs = $_POST['obs'];
}

include_once "lib_gop.php";

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

// conexão dom o banco de dados
$servername = $_SESSION['local'];
$username = $_SESSION['usuario'];
$password =  $_SESSION['senha'];
$database = $_SESSION['banco'];
// criando a conexão com banco de dados
$conection = new mysqli($servername, $username, $password, $database);
// checo erro na conexão
if ($conection->connect_error) {
    die("Erro na Conexão com o Banco de Dados!! " . $conection->connect_error);
}

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $c_nome = $_POST['nome'];
    $c_tipo = $_POST['tipo'];
    $c_cnpj_cpf = $_POST['cpfcnpj'];
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
    $i_horastrab = $_POST['horastrab'];
    $n_valorhora = $_POST['valorhora'];
    $c_funcao = $_POST['funcao'];
    $c_oficina = $_POST['oficina'];
    $c_escolaridade = $_POST['escolaridade'];
    $c_obs = $_POST['obs'];

    do {
        if (empty($c_nome) || empty($c_endereco) || empty($c_cnpj_cpf) || empty($c_bairro) || empty($c_cidade) || empty($c_cep)) {
            $msg_erro = "Campos Nome, endereco, bairro, cidade, cep e CPF/CNPJ devem ser preenchidos!!";
            break;
        }
        // mascara e validação para cpf ou cnpj

        if ($c_tipo == "Física") {
            $c_cnpj_cpf = mask($c_cnpj_cpf, "###.###.###-##");
            $c_tipo = 'F';
            if (!validaCPF($c_cnpj_cpf)) {
                $msg_erro = "CPF informado inválido!!";
                break;
            }
        } else {
            $c_cnpj_cpf = mask($c_cnpj_cpf, "##.###.###/####-##");
            $c_tipo = 'J';
            if (!valida_cnpj($c_cnpj_cpf)) {
                $msg_erro = "CNPJ informado inválido!!";
                break;
            }
        }
        // verifico a id da função selecionado no combo
        $c_sql_secundario = "SELECT funcoes.id FROM funcoes where funcoes.descricao='$c_funcao' ORDER BY funcoes.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_funcao = $registro_secundario['id'];
        // verifico o id da oficina
        // verifico a id da função selecionado no combo
        $c_sql_secundario = "SELECT oficinas.id FROM oficinas where oficinas.descricao='$c_oficina' ORDER BY oficinas.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_oficina = $registro_secundario['id'];
        // grava dados no banco

        // faço a inclusão da tabela com sql
        $c_sql = "Insert into executores (id_oficina,id_funcao, nome,endereco,bairro,cep,cidade,uf,contato,tipo,cpf_cnpj,email,url," .
            " fone1,fone2,fone3,salario,horastrab,valorhora,escolaridade,formacao,obs)" .
            " Value ('$i_oficina', '$i_funcao', '$c_nome', '$c_endereco', '$c_bairro','$c_cep', '$c_cidade', '$c_estado'," .
            " '$c_contato', '$c_tipo', '$c_cnpj_cpf', '$c_email', '$c_url','$c_fone1', '$c_fone2', '$c_fone3'," .
            " '$n_salario', '$i_horastrab', '$n_valorhora', '$c_escolaridade', '$c_formacao', '$c_obs')";
        echo $c_sql;
        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

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
        $c_salrio = '0.00';
        $c_cnpj_cpf = '';
        $i_horastrab = '0.00';
        $n_valorhora = '0.00';
        $c_escolaridade = '';
        $c_obs = '';


        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/executores_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>GOP</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css">
    <link rel="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css">
    <link href="https://nightly.datatables.net/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
    <script type="text/javascript" src="js/jquery.maskedinput-1.1.4.pack.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#fone1").mask("(99)9999-9999");
            $("#fone2").mask("(99)9999-9999");
            $('#fone3').mask("(99)9999-9999");
            $("#cnpj_cpf").mask("999999999999999999");
            $("#cep").mask("99.999-999");
        });
    </script>

</head>
<div class="panel panel-light" style="background-color: #e3f2fd;">
    <div class="panel-heading text-center">
        <h2>Novo registro de Executor</h2>
    </div>
</div>
<br>

<body>
    <div class="container -my5">
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <h3>$msg_erro</h3>
            </div>
            ";
        }
        ?>
        <form method="post">
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Nome </label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="nome" value="<?php echo $c_nome; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Tipo Executor </label>
                <div class="col-sm-2">
                    <select class="form-control form-control-lg" id="tipo" name="tipo">
                        <option>Juridica</option>
                        <option>Física</option>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">CNPJ/CPF</label>
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
            <hr>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Função/Cargo </label>
                <div class="col-sm-4">
                    <select class="form-control form-control-lg" id="funcao" name="funcao">
                        <?php
                        // select da tabela de funções
                        $c_sql_secundario = "SELECT funcoes.id, funcoes.descricao FROM funcoes ORDER BY funcoes.descricao";
                        $result_secundario = $conection->query($c_sql_secundario);
                        while ($c_linha = $result_secundario->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Oficina </label>
                <div class="col-sm-3">
                    <select class="form-control form-control-lg" id="oficina" name="oficina">
                        <?php
                        // select da tabela de oficinas
                        $c_sql_oficina = "SELECT oficinas.id, oficinas.descricao FROM oficinas ORDER BY oficinas.descricao";
                        $result_oficina = $conection->query($c_sql_oficina);
                        while ($c_linha = $result_oficina->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fone I</label>
                <div class="col-sm-4">
                    <input type="text" maxlength="20" id="fone1" class="form-control" name="fone1" value="<?php echo $c_fone1; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fone II</label>
                <div class="col-sm-4">
                    <input type="text" maxlength="20" id="fone2" class="form-control" name="fone2" value="<?php echo $c_fone2; ?>">
                </div>
            </div>


            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fone III</label>
                <div class="col-sm-4">
                    <input type="text" maxlength="20" id="fone3" class="form-control" name="fone3" value="<?php echo $c_fone3; ?>">
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
                <label class="col-sm-3 col-form-label">CEP</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="10" id="cep" class="form-control" name="cep" value="<?php echo $c_cep; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Estado</label>
                <div class="col-sm-3">
                    <select class="form-control form-control-lg" id="estado" name="estado">
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
                        <option value="MG">Minas Gerais</option>
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
                <div class="col-sm-3">
                    <select class="form-control form-control-lg" id="escolaridade" name="escolaridade">
                        <option>Primário</option>
                        <option>1o. Grau</option>
                        <option>2o. Grau</option>
                        <option>Curso Superior</option>
                    </select>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Salário</label>
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
            <hr>
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
                    <a class='btn btn-danger' href='/gop/executores_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>