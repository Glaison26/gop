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
$c_espaco = "";
$c_responsavel = "";
$c_fone1 = "";
$c_fone2 = "";
$c_endereco = "";
$c_bairro = "";
$c_cidade = "";
$c_cep = "";
$c_email = "";
$c_rateio = "";
// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $c_descricao = $_POST['descricao'];
    $c_espaco = $_POST['espaco'];
    $c_responsavel = $_POST['responsavel'];
    $c_fone1 = $_POST['fone1'];
    $c_fone2 = $_POST['fone2'];
    $c_endereco = $_POST['endereco'];
    $c_bairro = $_POST['bairro'];
    $c_cidade = $_POST['cidade'];
    $c_cep = $_POST['cep'];
    $c_email = $_POST['email'];
    $c_rateio = $_POST['rateio'];

    do {
        if (empty($c_descricao) || empty($c_espaco) || empty($c_responsavel)) {
            $msg_erro = "Campos descrição Espaço Físico e responsável devem ser preenchidos!!";
            break;
        }
        // localizo o id do valor do combobox de espacos fisicos
        // select da tabela de espacos fisicos
        $c_sql_espacos = "SELECT espacos.id FROM espacos where espacos.descricao='$c_espaco' ORDER BY espacos.descricao";
        $result_espaco = $conection->query($c_sql_espacos);
        $registro_espaco = $result_espaco->fetch_assoc();
        $i_espaco = $registro_espaco['id'];
        if (empty($c_rateio)) {
            $c_rateio = '0.00';
        }
        // grava dados no banco

        // faço a inclusão da tabela com sql
        $c_sql = "Insert into centrodecusto (descricao, id_espacofisico, responsavel, fone1, fone2, endereco, bairro, cep, email, cidade, rateio)" .
            "Value ('$c_descricao', '$i_espaco', '$c_responsavel', '$c_fone1', '$c_fone2', '$c_endereco', '$c_bairro', '$c_cep', '$c_email' ,'$c_cidade', '$c_rateio')";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $c_descricao = "";
        $c_espaco = "";
        $c_responsavel = "";
        $c_fone1 = "";
        $c_fone2 = "";
        $c_endereco = "";
        $c_bairro = "";
        $c_cidade = "";
        $c_cep = "";
        $c_email = "";
        $c_rateio = "";

        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/cadastros/centrodecustos/centrodecusto_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <script type="text/javascript">
        $(document).ready(function() {
            $("#fone1").mask("(99)9999-9999");
            $("#fone2").mask("(99)9999-9999");
            $("#rateio").mask("99.99");
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
    <div class="container -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo Centro de Custo<h5>
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
                <h3>$msg_erro</h3>
            </div>
            ";
        }
        ?>
        <form method="post">
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Descrição</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Espaço Físico </label>
                <div class="col-sm-6">
                    <select class="form-select form-select-lg mb-3" id="espaco" name="espaco">
                        <?php
                        // select da tabela de espacos fisicos
                        $c_sql_espacos = "SELECT espacos.id, espacos.descricao FROM espacos ORDER BY espacos.descricao";
                        $result_espaco = $conection->query($c_sql_espacos);
                        while ($c_linha = $result_espaco->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Responsável</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" class="form-control" name="responsavel" value="<?php echo $c_responsavel; ?>">
                </div>
            </div>

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
                <div class="col-sm-3">
                    <input type="text" maxlength="100" id="cidade" class="form-control" name="cidade" value="<?php echo $c_cidade; ?>">
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
                <label class="col-sm-3 col-form-label">Rateio (%)</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="3" id="rateio" class="form-control col-xs-12" name="rateio" value="0.00">
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
                    <a class='btn btn-danger' href='/gop/cadastros/centrodecustos/centrodecusto_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>