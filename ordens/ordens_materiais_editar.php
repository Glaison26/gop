<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
include("../links2.php");
include_once "../lib_gop.php";

$c_id = $_SESSION['id_ordem'];
$i_id = $_GET["id"];

if (isset($_POST['btncusto'])) {  // pegar custo do material

    $c_sql =  "select id,custo from materiais where materiais.descricao='$_POST[material]'";
    $result = $conection->query($c_sql);
    $c_linha = $result->fetch_assoc();
    $c_valor = $c_linha['custo'];
    $c_indice = $_POST['material'];
}

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/ordens_gerenciar.php');
        exit;
    }

    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from ordens_materiais where id=$i_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/ordens/ordens_gerenciar.php');
        exit;
    }

    // carrego variaveis do banco de dados
    $i_id_material = $registro['id_material'];
    $i_id_unidade = $registro['id_unidade'];
    $n_quantidade = $registro['quantidade'];
    $c_valor = $registro['valor'];
}
// metodo post para gravação dos dados dos materiais
if ($_SERVER['REQUEST_METHOD'] == 'POST' && !isset($_POST['btncusto'])) {
    $c_custo = $_POST['valorunitario'];
    $c_quantidade = $_POST['quantidade'];
    $c_unidade = $_POST['unidade'];
    $c_material = $_POST['material'];

    do {
        if (empty($c_material) || empty($_POST['unidade']) || empty($_POST['quantidade'])) {
            $msg_erro = "Todos os campos devem ser preencidos !!";
            break;
        }

        if (!is_numeric($c_custo) || !is_numeric($c_quantidade)) {

            $msg_erro = "Valor de quantidade ou custo inválido !!";
            break;
        }

        // sql para unidade
        $c_sql_unidade = "SELECT unidades.id, unidades.abreviatura FROM unidades 
    where unidades.abreviatura='$c_unidade' ORDER BY unidades.abreviatura";
        $result_unidade = $conection->query($c_sql_unidade);
        $c_linha = $result_unidade->fetch_assoc();
        $i_id_unidade = $c_linha['id'];
        $c_material = $_POST['material'];
        // sql para pegar codigo do material
        $c_sql_material = "SELECT materiais.id, materiais.descricao FROM materiais
     where materiais.descricao = '$c_material' ORDER BY materiais.descricao";
        $result_material = $conection->query($c_sql_material);
        $c_linha = $result_material->fetch_assoc();
        $i_id_material = $c_linha['id'];
        //

        $c_sql = "update ordens_materiais set id_material='$i_id_material', id_unidade='$i_id_unidade',
                  quantidade='$c_quantidade', valor='$c_custo'  where id=$i_id";;
        echo $c_sql;
        $result = $conection->query($c_sql);
        // somatório dos valores de custo de material
        $c_sql = "SELECT SUM(ordens_materiais.quantidade * ordens_materiais.valor) AS total
         FROM ordens_materiais
         WHERE ordens_materiais.id_ordem='$c_id'";
        $result = $conection->query($c_sql);
        $c_linha = $result->fetch_assoc();
        $c_custo_total = $c_linha['total'];
        $c_custo_total = number_format($c_custo_total, 2, '.', ' ');
        // edito o valor de materiais gastos na ordem de serviço
        $c_sql = "update ordens set valor_material='$c_custo_total' where id='$c_id'";
        $result = $conection->query($c_sql);
        header('location: /gop/ordens/ordens_gerenciar.php');
    } while (false);
}
?>
<!--
/////////////////////////////////////////////////
//  front end do formulario
////////////////////////////////////////////////
-->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="container -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Edição do Material para Ordem de Serviço<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Edite os dados do material a ser anexado a Ordem de Serviço No. <?php echo $c_id ?> Campos com (*) são obrigatórios</h5>
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
                <label class="col-sm-2 col-form-label">Material</label>
                <div class="col-sm-5">
                    <select class="form-select form-select-lg mb-3" id="material" name="material">

                        <?php

                        // select da tabela de Material
                        $c_sql_material = "SELECT materiais.id, materiais.descricao FROM materiais ORDER BY materiais.descricao";
                        $result_material = $conection->query($c_sql_material);
                        while ($c_linha = $result_material->fetch_assoc()) {
                            $op = " ";
                            if ($c_linha['id'] == $registro['id_material']) {
                                $op = 'selected';
                            }

                            echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>


                </div>

                <div class="col-sm-2">
                    <button type="submit" name="btncusto" id="btncusto" class="btn btn-primary btn-sm"><span class='glyphicon glyphicon-usd'></span> Capturar Custo</button>
                </div>

            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Quantidade</label>
                <div class="col-sm-2">
                    <input type="number" class="form-control" name="quantidade" value="<?php echo $n_quantidade; ?>">
                </div>
                <label class="col-sm-1 col-form-label">Unidade</label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="unidade" name="unidade">

                        <?php

                        // select da tabela de Unidades
                        $c_sql_unidade = "SELECT unidades.id, unidades.abreviatura FROM unidades ORDER BY unidades.abreviatura";
                        $result_unidade = $conection->query($c_sql_unidade);
                        while ($c_linha = $result_unidade->fetch_assoc()) {
                            $op = " ";
                            if ($c_linha['id'] == $registro['id_unidade']) {
                                $op = "selected";
                            }
                            echo "  
                          <option $op>$c_linha[abreviatura]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">Valor Unitário</label>
                <div class="col-sm-3">
                    <input placeholder="valor em Real" type="text" data-thousands="." data-decimal=","
                        data-prefix="R$ " class="form-control" id="valorunitario" name="valorunitario" value="<?php echo $c_valor ?>">
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/ordens/ordens_gerenciar.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>
            </div>
        </form>
    </div>

</body>

</html>