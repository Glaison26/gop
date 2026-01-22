<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("..\conexao.php");
include("..\links2.php");

include_once "..\lib_gop.php";

// rotina de post dos dados do formuário
$c_id = "";


// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/almoxarifado/cotacao_fornecedores.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura através de sql usando id passada
    $c_sql = "select * from cotacao_fornecedor where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/almoxarifado/cotacao_fornecedores.php');
        exit;
    }

    $i_id_fornecedor = $registro['id_fornecedor'];
    $n_frete = $registro['frete'];
    $c_prazo = $registro['prazo'];
    $c_forma_pagamento = $registro['forma_pagamento'];
    $c_vendedor = $registro['vendedor'];
    $c_observacao = $registro['observacao'];
} else {
    // metodo post para atualizar dados
    $c_id = $_POST["id"];
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

        // sql para pegar o id do fornecedor
        $c_sql = "select id, descricao from fornecedores where descricao = '$c_fornecedor'";
        $result = $conection->query($c_sql);
        $c_registro = $result->fetch_assoc();
        $i_id_fornecedor = $c_registro['id'];

        // grava dados no banco
        // faço a Leitura da tabela com sql
        $c_sql = "update cotacao_fornecedor set  id_fornecedor='$i_id_fornecedor', prazo='$c_prazo', frete='$n_frete',
        forma_pagamento = '$c_forma_pagamento', vendedor='$c_vendedor', observacao='$c_observacao' where id='$c_id'";

        $result = $conection->query($c_sql);
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        header('location: /gop/almoxarifado/cotacao_fornecedores.php');
    } while (false);
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>GOP - Edição Fornecedor Cotação</title>
    <link rel="stylesheet" href="/gop/css/basico.css">

</head>

<body>

    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Editar dados de Fornecedor para Cotação de Serviço<h5>
                </div>
            </div>
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
        <div class="container content-box">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

                </div>
                <h5>Campos com (*) são obrigatórios</h5>
            </div>
            <form method="post">
                <input type="hidden" name="id" value="<?php echo $c_id; ?>">
                <br>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Fornecedor (*)</label>
                    <div class="col-sm-6">
                        <select class="form-select form-select-lg mb-3" id="fornecedor" name="fornecedor" required>

                            <?php
                            if ($c_indice == '')
                                echo "<option></option>";
                            // select da tabela de fornecedores
                            $c_sql_fornecedor = "SELECT fornecedores.id, fornecedores.descricao FROM fornecedores ORDER BY fornecedores.descricao";
                            $result_fornecedor = $conection->query($c_sql_fornecedor);
                            while ($c_linha = $result_fornecedor->fetch_assoc()) {
                                $op = "";
                                if ($c_linha['id'] == $i_id_fornecedor)
                                    $op = "selected";
                                echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                            }
                            ?>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Valor Frete</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" id="frete" name="frete" value='<?php echo $n_frete ?>'>
                    </div>

                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Prazo de entrega</label>
                    <div class="col-sm-2">
                        <input type="number" placeholder="em no. de dias " class="form-control" id="prazo" name="prazo" value='<?php echo $c_prazo ?>'>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Forma de Pagamento</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="forma_pagamento" name="forma_pagamento" value='<?php echo $c_forma_pagamento ?>'>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Vendedor (*)</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="vendedor" name="vendedor" value='<?php echo $c_vendedor ?>' required>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Observação</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" id="observacao" name="observacao" rows="06"><?php echo $c_observacao ?></textarea>
                    </div>
                </div>

                <br>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                        <a class='btn btn-danger' href='/gop/almoxarifado/cotacao_fornecedores.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                    </div>
                </div>

            </form>
        </div>
    </div>

</body>

</html>