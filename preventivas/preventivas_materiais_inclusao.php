<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('../links2.php');
include('../conexao.php');

$c_id = $_SESSION['id_preventiva'];

$c_indice = '';
$msg_erro = "";

// inclusão do material no banco de dados
if ($_SERVER['REQUEST_METHOD'] == 'POST' && !isset($_POST['btncusto'])) {
   
    $c_quantidade = $_POST['quantidade'];
    $c_unidade = $_POST['unidade'];
    $c_material = $_POST['material'];


    //
    do {
        if (empty($c_material) || empty($_POST['unidade']) || empty($_POST['quantidade'])) {
            $msg_erro = "Todos os campos devem ser preencidos !!";
            break;
        }

        if (!is_numeric($c_quantidade)) {

            $msg_erro = "Valor de quantidade inválido !!";
            break;
        }

        // sql para unidade
        $c_sql_unidade = "SELECT unidades.id, unidades.abreviatura FROM unidades
    where unidades.abreviatura='$c_unidade'  ORDER BY unidades.abreviatura";
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

        $c_sql = "Insert into preventivas_materiais (id_material, id_unidade, quantidade,id_preventiva)
                 Value ('$i_id_material', '$i_id_unidade', '$c_quantidade', '$c_id')";
        $result = $conection->query($c_sql);
        
        header('location: /gop/preventivas/preventivas_anexos.php');
    } while (false);
}


?>

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
                    <h5>Novo Material para Preventiva<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Entre com os dados do material a ser anexado a Preventiva. Campos com (*) são obrigatórios</h5>
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

                            echo "  
                          <option>$c_linha[abreviatura]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/preventivas/preventivas_anexos.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>
            </div>
        </form>
    </div>

</body>

</html>