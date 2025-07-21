<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include_once "../../lib_gop.php";
include("../../conexao.php");
include("../../links2.php");

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";
$c_id = $_GET["id"];

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/cadastros/contratos/lancamentos_lista.php');
        exit;
    }

    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from contratos_lancamentos where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/cadastros/contratos/lancamentos_lista.php');
        exit;
    }
    // carrega variáveis com os registros a serem editados
    $c_data = $registro["data"];
    $i_quantidade = $registro["quantidade"];
    $n_valor = $registro["valor"];
    $c_unidade = $registro["unidade"];
    $c_nota = $registro["nota"];
    $d_emissao = $registro["emissao"];
    $d_vencimento = $registro["vencimento"];
    $c_condpag = $registro["cond_pagamento"];
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // faço post para as variáveis que vão gravar no sql
    $c_data = $_POST["data"];
    $i_quantidade = $_POST["quantidade"];
    $n_valor = $_POST["valor"];
    $c_unidade = $_POST["unidade"];
    $c_nota = $_POST["nota"];
    $d_emissao = $_POST["emissao"];
    $d_vencimento = $_POST["vencimento"];
    $c_condpag = $_POST["cond_pagamento"];

    do {

        if (!is_numeric($n_valor) || !is_numeric($i_quantidade)) {

            $msg_erro = "Valor de contrato ou quantidade inválido !!";
            break;
        }

        // grava dados do contrato no banco de dados
        // faço a Leitura da tabela com sql
        $c_sql = "update contratos_lancamentos set  data='$c_data', quantidade='$i_quantidade', valor='$n_valor', unidade='$c_unidade',
        nota='$c_nota', emissao='$d_emissao', vencimento='$d_vencimento', cond_pagamento='$c_condpag' where id=$c_id";
        echo $c_sql;
        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        header('location: /gop/cadastros/contratos/lancamentos_lista.php');
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
                    <h5>Editar Dados do Lançamento Contrato<h5>
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
                    <input type="text" class="form-control" name="quantidade" required value="<?php echo $i_quantidade; ?>">
                </div>

            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Valor</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" name="valor" required value="<?php echo $n_valor; ?>">
                </div>
                <label class="col-sm-1 col-form-label">Unidade</label>
                <div class="col-sm-3">
                    <input type="text" maxlength="80" class="form-control" name="unidade" required value="<?php echo $c_unidade; ?>">
                </div>
            </div>


            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Nota</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="30" class="form-control" required name="nota" value="<?php echo $c_nota; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Emissão</label>
                <div class="col-sm-2">
                    <input type="date" class="form-control" required name="emissao" value="<?php echo $d_emissao; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Vencimento</label>
                <div class="col-sm-2">
                    <input type="date" class="form-control" required name="vencimento" value="<?php echo $d_vencimento; ?>">
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
                    <a class='btn btn-danger' href='/gop/cadastros/contratos/lancamentos_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>
            </div>
        </form>
    </div>

    </div>

</body>

</html>