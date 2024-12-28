<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}


include_once "../lib_gop.php";
include("../conexao.php");
include("../links2.php");

$c_descricao = '';
$c_grupo = '';
$n_maodeobra = '';
$n_material = '';
$c_unidade = '';

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $c_descricao = $_POST['descricao'];
    $c_grupo = $_POST['grupo'];
    $c_unidade = $_POST['unidade'];
    $n_maodeobra = $_POST['maodeobra'];
    $n_material = $_POST['material'];

    do {
        if (!is_numeric($n_maodeobra) || !is_numeric($n_material)) {

            $msg_erro = "Valor de Mão de Obra ou Material Inválido !!";
            break;
        }
        // localizo o id do grupo do combobox de grupos
        $c_sql_grupo = "SELECT obras_grupo.id, obras_grupo.descricao FROM obras_grupo
        where obras_grupo.descricao='$c_grupo'";
        $result_grupo = $conection->query($c_sql_grupo);
        $registro_grupo = $result_grupo->fetch_assoc();
        $i_grupo = $registro_grupo['id'];
        // localizo unidade selecionada
        $c_sql_unidade = "SELECT unidades.id, unidades.descricao FROM unidades
        where unidades.descricao='$c_unidade'";
        $result_unidade = $conection->query($c_sql_unidade);
        $registro_unidade = $result_unidade->fetch_assoc();
        $i_unidade = $registro_unidade['id'];
        // grava dados no banco

        // faço a Leitura da tabela com sql
        $c_sql = "Insert into obras_itens (descricao,  id_grupo, id_unidade, valor_maodeobra, valor_material)" .
            "Value ('$c_descricao', '$i_grupo', '$i_unidade', '$n_maodeobra', '$n_material')";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
     
        header('location: /gop/obras/obras_itens_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
</head>

<body>
    <div class="container -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo Item de Obra<h5>
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
                <label class="col-sm-3 col-form-label">Grupo (*) </label>
                <div class="col-sm-6">
                    <select class="form-select form-select-lg mb-3" id="grupo" name="grupo" required>
                        <option></option>
                        <?php
                        // select da tabela de grupos
                        $c_sql_grupo = "SELECT obras_grupo.id, obras_grupo.descricao FROM obras_grupo ORDER BY obras_grupo.descricao";
                        $result_grupo = $conection->query($c_sql_grupo);
                        while ($c_linha = $result_grupo->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Descrição (*)</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>" required>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Unidade (*) </label>
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
            </div>
            <div class="mb-3 row">
                <label class="col-sm-3 col-form-label">Valor de Material</label>
                <div class="col-sm-2">
                    <input placeholder="0.00" type="text" data-thousands="." data-decimal=","
                        data-prefix="R$ " class="form-control"  id="material" name="material" value="<?php echo $n_material ?>">
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
                    <a class='btn btn-danger' href='/gop/obras/obras_itens_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>