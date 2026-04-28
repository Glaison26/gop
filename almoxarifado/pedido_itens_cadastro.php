<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
// definição de variáveis para preenchimento do formulário
$c_material = "";
$c_unidade = "";
$c_quantidade = "0";
// grava dados do formulario de pedidos de compra
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $item = $_POST['material'];
    // pego o id do material com sql
    // pego o id, unidade de entrada do material com sql
    $c_sql = "select id, id_unidadeEntrada from materiais where id = '$item'";
    echo $c_sql;
    $result = $conection->query($c_sql);
    $c_registro = $result->fetch_assoc();
    $c_material = $c_registro['id'];

    $c_unidade = $c_registro['id_unidadeEntrada'];
    $c_quantidade = $_POST['quantidade'];

    // rotina de inclusão
    $c_sql = "Insert into compras_materiais (id_compra, id_material, id_unidade, quantidade, valor_unitario, valor_total, fator_conversao, receber, recebido) 
        Value ('$_SESSION[id_compra]', '$c_material', '$c_unidade', '$c_quantidade', '$_POST[valor_unitario]','$_POST[valor_total]', 
        '$_POST[fator_conversao]', 'S', 'N')";
    $result = $conection->query($c_sql);
    if (!$result) {
        die("Erro ao Executar Sql!!" . $conection->connect_error);
    }
    header('location: /gop/almoxarifado/compras_materiais_lista.php');
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
                    <h5>Novo Material para Pedido de Compra<h5>
                </div>
            </div>
        </div>


        <br>

        <div class="container content-box">
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
                                <option value='" . $c_linha['id'] . "'>" . $c_linha['descricao'] . "</option>
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
                <!-- valor unitário -->
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Valor Unitário</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" id="valor_unitario" name="valor_unitario" required>
                    </div>
                </div>
                <!-- valor total -->
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Valor Total</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" id="valor_total" name="valor_total" required>
                    </div>
                </div>
                <!-- fator de conversão -->
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Fator de Conversão</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" id="fator_conversao" name="fator_conversao" required>
                    </div>
                </div>


                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                        <a class='btn btn-danger' href='/gop/almoxarifado/compras_materiais_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                    </div>

                </div>
            </form>
        </div>
    </div>

</body>

</html>