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
        header('location: /gop/almoxarifado/cotacao_materiais_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura através de sql usando id passada
    $c_sql = "select * from cotacao_materiais where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/almoxarifado/cotacao_materiais_lista.php');
        exit;
    }

    $c_material = $registro['id_material'];
    $c_unidade = $registro['id_unidade'];
    $c_quantidade = $registro['quantidade'];
} else {
    // metodo post para atualizar dados
    $c_id = $_POST["id"];
    $c_material = $_POST['material'];
    $c_unidade = $_POST['unidade'];
    $c_quantidade = $_POST['quantidade'];

    do {
        if (empty($c_material) || empty($c_unidade) || empty($c_quantidade)) {
            $msg_erro = "Todos os campos devem ser preenchidos!!";
            break;
        }

        // sql para pegar o id do material
        $c_sql = "select id, descricao from materiais where descricao = '$c_material'";
        $result = $conection->query($c_sql);
        $c_registro = $result->fetch_assoc();
        $i_id_material = $c_registro['id'];
        // pego o id da unidade de medida com sql
        $c_sql = "select id, descricao from unidades where descricao = '$c_unidade'";
        $result = $conection->query($c_sql);
        $c_registro = $result->fetch_assoc();
        $i_id_unidade = $c_registro['id'];
        // grava dados no banco
        // faço a Leitura da tabela com sql
        $c_sql = "update cotacao_materiais set  id_material='$i_id_material', id_unidade='$i_id_unidade', quantidade='$c_quantidade' where cotacao_materiais.id='$c_id'";
        $result = $conection->query($c_sql);
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        header('location: /gop/almoxarifado/cotacao_materiais_lista.php');
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
                    <h5>Editar dados de Material para Cotação de Serviço<h5>
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
            <br>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Material</label>
                <div class="col-sm-6">
                    <select class="form-select form-select-lg mb-3" id="material" name="material">

                        <?php
                        if ($c_indice == '')
                            echo "<option></option>";
                        // select da tabela de Material
                        $c_sql_material = "SELECT materiais.id, materiais.descricao FROM materiais ORDER BY materiais.descricao";
                        $result_material = $conection->query($c_sql_material);
                        while ($c_linha = $result_material->fetch_assoc()) {
                                $op="";
                                if ($c_linha['id']==$c_material)
                                  $op="selected";
                            echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Quantidade</label>
                <div class="col-sm-2">
                    <input type="number" class="form-control" id="quantidade" name="quantidade" value="<?php echo $c_quantidade?>">
                </div>

            </div>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Unidade</label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="unidade" name="unidade">

                        <?php

                        // select da tabela de Unidades
                        $c_sql_unidade = "SELECT unidades.id, unidades.descricao FROM unidades ORDER BY unidades.descricao";
                        $result_unidade = $conection->query($c_sql_unidade);
                        while ($c_linha = $result_unidade->fetch_assoc()) {
                            $op = "";
                            if ($c_linha['id']==$c_unidade)
                              $op="selected";

                            echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>








            <br>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/almoxarifado/cotacao_materiais_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>

        </form>
    </div>

</body>

</html>