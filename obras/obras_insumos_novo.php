<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include_once "../lib_gop.php";
include("../conexao.php");
include("../links2.php");

$_SESSION['insumo_crud'] = 'I';

$c_item = '';
$c_grupo = '';
$n_maodeobra = '';
$n_material = '';
$c_unidade = '';
$n_quantidade = 1;

$c_id_obra = $_SESSION['id_obra'];  // capturo o id da obra
// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $c_item = $_POST['item'];
    $c_grupo = $_POST['grupo'];
    $c_unidade = $_POST['unidade'];
    $n_quantidade = $_POST['quantidade'];
    $n_maodeobra = $_POST['maodeobra'];
    $n_material = $_POST['material'];

    do {
        if (!is_numeric($n_maodeobra) || !is_numeric($n_material)) {

            $msg_erro = "Valor de Mão de Obra ou Material Inválido !!";
            break;
        }
        // localizo o id do grupo do combobox de grupos
        $c_sql_itens = "SELECT obras_itens.id, obras_itens.descricao FROM obras_itens
        where obras_itens.descricao='$c_item'";
        $result_itens = $conection->query($c_sql_itens);
        $registro_itens = $result_itens->fetch_assoc();
        $i_item = $registro_itens['id'];
        // localizo unidade selecionada
        $c_sql_unidade = "SELECT unidades.id, unidades.descricao FROM unidades
        where unidades.descricao='$c_unidade'";
        $result_unidade = $conection->query($c_sql_unidade);
        $registro_unidade = $result_unidade->fetch_assoc();
        $i_unidade = $registro_unidade['id'];
        // grava dados no banco
        // faço a Leitura da tabela com sql
        $c_sql = "Insert into obras_insumos (id_obra, id_item, id_unidade, quantidade, valor_maodeobra, valor_material)" .
            "Value ('$c_id_obra', '$i_item', '$i_unidade','$n_quantidade','$n_maodeobra','$n_material')";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        header('location: /gop/obras/obras_insumos_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
</head>

<body>
    <!-- script para verificação e filtro do grupo selecionado -->
    <script>
        // chama arquivo para pegar grupo
        function verifica(value) {
            window.location.href = "/gop/obras/obras_verifica_grupo.php?id=" + value;
        }
    </script>

    <div class="container -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo insumo para Obra<h5>
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
                <label class="col-sm-3 col-form-label">Grupo</label>
                <div class="col-sm-6">
                    <select onchange="verifica(value)" class="form-select form-select-lg mb-3" id="grupo" name="grupo" required>
                        <option></option>
                        <?php
                        // select da tabela de grupos
                        $c_sql_grupo = "SELECT obras_grupo.id, obras_grupo.descricao FROM obras_grupo ORDER BY obras_grupo.descricao";
                        $result_grupo = $conection->query($c_sql_grupo);
                        while ($c_linha = $result_grupo->fetch_assoc()) {
                            $op = '';
                            if ($_SESSION['id_grupo_select'] > 0) {

                                if ($c_linha['id'] == $_SESSION['id_grupo_select']) {
                                    $op = 'selected';
                                }
                                echo "<option $op>$c_linha[descricao]</option>";
                            } else
                                echo "<option $op>$c_linha[descricao]</option>";
                        }
                        ?>
                    </select>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Item (*) </label>
                <div class="col-sm-6">
                    <select class="form-select form-select-lg mb-3" id="item" name="item" required>
                        <option></option>
                        <?php
                        // select da tabela de grupos
                        if ($_SESSION['id_grupo_select'] == 0)
                            $c_sql_item = "SELECT obras_itens.id, obras_itens.descricao FROM obras_itens ORDER BY obras_itens.descricao";
                        else
                            $c_sql_item = "SELECT obras_itens.id, obras_itens.descricao FROM obras_itens where obras_itens.id_grupo='$_SESSION[id_grupo_select]' ORDER BY obras_itens.descricao";
                        $result_item = $conection->query($c_sql_item);
                        while ($c_linha = $result_item->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Quantidade</label>
                <div class="col-sm-2">
                    <input type="number" class="form-control" name="quantidade" value="<?php echo $n_quantidade; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Unidade (*) </label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="unidade" name="unidade" required>
                        <option></option>
                        <?php
                        // select da tabela de unidades
                        $c_sql_unidades = "SELECT unidades.id, unidades.descricao FROM unidades ORDER BY unidades.descricao";
                        $result_unidades = $conection->query($c_sql_unidades);
                        while ($c_linha = $result_unidades->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="mb-3 row">
                <label class="col-sm-3 col-form-label">Valor Mão de Obra</label>
                <div class="col-sm-2">
                    <input placeholder="0.00" type="text" data-thousands="." data-decimal=","
                        data-prefix="R$ " class="form-control" id="maodeobra" name="maodeobra" value="<?php echo $n_maodeobra ?>">
                </div>
                <label class="col-sm-2 col-form-label">Valor de Material</label>
                <div class="col-sm-2">
                    <input placeholder="0.00" type="text" data-thousands="." data-decimal=","
                        data-prefix="R$ " class="form-control" id="material" name="material" value="<?php echo $n_material ?>">
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
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/obras/obras_insumos_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>