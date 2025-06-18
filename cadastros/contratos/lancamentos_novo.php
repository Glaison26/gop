<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include_once "../../lib_gop.php";
include("../../conexao.php");
include("../../links2.php");

$c_descricao = '';
$n_custo = 0.0;
$n_qtdmin = 0;
$n_qtdmax = 0;
$d_ultimasaida = 'dd/mm/yyyy';
$d_ultimaentrada = 'dd/mm/yyyy';
$n_quantidadeatual = 0;
$d_validade = 'dd/mm/yyyy';
$c_fator = "1";
$c_obs = '';

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $c_descricao = rtrim($_POST['descricao']);
    $c_marca = $_POST['marca'];
    $c_grupo = $_POST['grupo'];
    $c_unidadesaida = $_POST['unidadesaida'];
    $c_unidadeentrada = $_POST['unidadeentrada'];
    $n_custo = $_POST['custo'];
    $n_qtdmin = $_POST['qtdmin'];
    $n_qtdmax = $_POST['qtdmax'];
    $d_ultimasaida = $_POST['ultimasaida'];
    $d_ultimaentrada = $_POST['ultimaentrada'];
    $n_quantidadeatual = $_POST['quantidadeatual'];
    $d_validade = $_POST['validade'];
    $c_fator = $_POST['fator'];
    $c_obs = $_POST['obs'];

    do {


        // grava dados no banco

        // faço a Leitura da tabela com sql
        $c_sql = "Insert into materiais (descricao,  custo, qtdmin, qtdmax, fator, ultimasaida, ultimaentrada, data_validade, quantidadeatual, obs, id_marca, id_grupo, id_unidadesaida, id_unidadeentrada)" .
            "Value ('$c_descricao', '$n_custo', '$n_qtdmin', '$n_qtdmax', '$c_fator', '$d_ultimasaida', '$d_ultimaentrada', '$d_validade', '$n_quantidadeatual', '$c_obs', '$i_marca', '$i_grupo', '$i_unidadesaida', '$i_unidadeentrada')";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $c_descricao = '';
        $n_custo = 0.0;
        $n_qtdmin = 0;
        $n_qtdmax = 0;
        $d_ultimasaida = 'dd/mm/yyyy';
        $d_ultimaentrada = 'dd/mm/yyyy';
        $n_quantidadeatual = 0;
        $d_validade = 'dd/mm/yyyy';
        $c_obs = '';


        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/cadastros/materiais/materiais_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>


<body>
    <div class="container -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo Lançamento de Contrato<h5>
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
                <label class="col-sm-2 col-form-label">Data (*)</label>
                <div class="col-sm-2">
                    <input type="date" class="form-control" name="data" value="<?php echo $c_data; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Quantidade (*)</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" name="quantidade" value="<?php echo $c_quantidade; ?>">
                </div>

            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Valor</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" name="valor" value="<?php echo $n_valor; ?>">
                </div>
                <label class="col-sm-1 col-form-label">Unidade</label>
                <div class="col-sm-3">
                    <input type="text" maxlength="80" class="form-control" name="unidade" value="<?php echo $c_unidade; ?>">
                </div>
            </div>


            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Nota</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="30" class="form-control" name="nota" value="<?php echo $c_nota; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Emissão</label>
                <div class="col-sm-2">
                    <input type="date" class="form-control" name="emissao" value="<?php echo $c_emissao; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Vencimento</label>
                <div class="col-sm-2">
                    <input type="date" class="form-control" name="vencimento" value="<?php echo $d_vencimento; ?>">
                </div>
                <label class="col-sm-1 col-form-label">Cond. Pagto.</label>
                <div class="col-sm-3">
                    <input type="text" maxlength="100" class="form-control" name="cond_pag" value="<?php echo $c_condpag; ?>">
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
            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/cadastros/contratos/contratos_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>