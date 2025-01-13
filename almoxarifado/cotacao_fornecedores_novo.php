<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
include("../links2.php");
include_once "../lib_gop.php";

$c_fornecedor = "";
$c_observacao = "";
$c_prazo = "";
$c_forma_pagamento = "";
$c_vendedor = "";
$n_frete = 0;

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $c_fornecedor = $_POST['fornecedor'];
    $c_observacao = $_POST["observacao"];
    $c_prazo = $_POST['prazo'];
    $c_forma_pagamento = $_POST['forma_pagamento'];
    $c_vendedor = $_POST['vendedor'];
    $n_frete = $_POST['frete'];

    do {
        if (empty($c_fornecedor) || empty($c_vendedor)) {
            $msg_erro = "Todos os campos  com (*) devem ser preenchidos!!";
            break;
        }
        // consistencia de valor de frete
        if (!is_numeric($n_frete)) {

            $msg_erro = "Valor de frete inválido inválido !!";
            break;
        }

        // sql para pegar o id do fornecedor
        $c_sql = "select id, descricao from fornecedores where descricao = '$c_fornecedor'";
        $result = $conection->query($c_sql);
        $c_registro = $result->fetch_assoc();
        $i_id_fornecedor = $c_registro['id'];

        // rotina de inclusão

        $i_id_cotacao = $_SESSION['id_cotacao']; // pego o id da cotação
        $c_sql = "Insert into cotacao_fornecedor (id_cotacao, id_fornecedor, prazo, frete, forma_pagamento, 
        vendedor, status, observacao) 
        Value ('$i_id_cotacao', '$i_id_fornecedor', '$c_prazo', '$n_frete', '$c_forma_pagamento', '$c_vendedor', 'P', '$c_observacao' )";
        $result = $conection->query($c_sql);


        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/almoxarifado/cotacao_fornecedores.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

</head>


<body>
    <div class="container  -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo Fornecedor para Cotação de Material<h5>
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
                    <h5><img Align='left' src='\gop\images\aviso.png' alt='30' height='35'> $msg_erro</h5>
                </div>
                
            </div>
            ";
        }
        ?>
        <form method="post">
            <br>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Fornecedor (*)</label>
                <div class="col-sm-6">
                    <select class="form-select form-select-lg mb-3" id="fornecedor" name="fornecedor">

                        <?php
                        if ($c_indice == '')
                            echo "<option></option>";
                        // select da tabela de fornecedores
                        $c_sql_fornecedor = "SELECT fornecedores.id, fornecedores.descricao FROM fornecedores ORDER BY fornecedores.descricao";
                        $result_fornecedor = $conection->query($c_sql_fornecedor);
                        while ($c_linha = $result_fornecedor->fetch_assoc()) {

                            echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Valor do Frete</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" id="frete" name="frete">
                </div>

            </div>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Prazo de entrega</label>
                <div class="col-sm-2">
                    <input type="number"  placeholder="em no. de dias " class="form-control" id="prazo" name="prazo" required>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Forma de Pagamento</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="forma_pagamento" name="forma_pagamento">
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Vendedor (*)</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="vendedor" name="vendedor" required>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Observação</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="observacao" name="observacao" rows="06"></textarea>
                </div>
            </div>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/almoxarifado/cotacao_fornecedores.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>