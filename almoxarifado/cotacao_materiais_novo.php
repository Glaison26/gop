<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
include("../links2.php");
include_once "../lib_gop.php";

$c_material = "";
$c_unidade = "";
$c_quantidade = "0";

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $c_material = $_POST['material'];
   // $c_unidade = $_POST['unidade'];
    $c_quantidade = $_POST['quantidade'];


    do {
        if (empty($c_material)  || empty($c_quantidade)) {
            $msg_erro = "Todos os campos devem ser preenchidos!!";
            break;
        }

        // sql para pegar o id do material
        $c_sql = "select id, descricao, id_unidadeEntrada from materiais where descricao = '$c_material'";
        $result = $conection->query($c_sql);
        $c_registro = $result->fetch_assoc();
        $i_id_material = $c_registro['id'];
        $i_id_unidade_entrada = $c_registro['id_unidadeEntrada'];
        // pego o id da unidade de medida com sql
        $c_sql = "select id, descricao  from unidades where id = '$i_id_unidade_entrada'";
        $result = $conection->query($c_sql);
        $c_registro = $result->fetch_assoc();
        $i_id_unidade = $c_registro['id'];

        // rotina de inclusão

        $i_id_cotacao = $_SESSION['id_cotacao']; // pego o id da cotação
        $c_sql = "Insert into cotacao_materiais (id_cotacao, id_material, id_unidade, quantidade) 
        Value ('$i_id_cotacao', '$i_id_material','$i_id_unidade','$c_quantidade' )";
        $result = $conection->query($c_sql);

        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/almoxarifado/cotacao_materiais_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>GOP - Novo Material da Cotação</title>
    <link rel="stylesheet" href="/gop/css/basico.css">
</head>


<body>
    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo Material para Cotação<h5>
                </div>
            </div>
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
        <div class="container content-box">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

                </div>
                <h5>Campos com (*) são obrigatórios</h5>
            </div>
            <form method="post">
                <br>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Material</label>
                    <div class="col-sm-6">
                        <select class="form-select form-select-lg mb-3" id="material" name="material" required>
                            <?php
                            if ($c_indice == '')
                                echo "<option></option>";
                            // select da tabela de Material
                            $c_sql_material = "SELECT materiais.id, materiais.descricao FROM materiais ORDER BY materiais.descricao";
                            $result_material = $conection->query($c_sql_material);
                            while ($c_linha = $result_material->fetch_assoc()) {

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
                        <input type="number" class="form-control" id="quantidade" name="quantidade" required>
                    </div>

                </div>
               

                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                        <a class='btn btn-danger' href='/gop/almoxarifado/cotacao_materiais_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                    </div>

                </div>
            </form>
        </div>
    </div>

</body>

</html>