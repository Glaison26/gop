<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
$c_id = $_GET["id"];

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/almoxarifado/compras_lista.php');
        exit;
    }


    // sql para pegar os campos
    $c_sql = "SELECT *, fornecedores.descricao AS fornecedor FROM compras
    JOIN fornecedores ON compras.id_fornecedor=fornecedores.id where compras.id='$c_id'";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();
    $formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Gravo informações editadas
    $c_sql_up = "update compras set tipo='$_POST[tipo]', nota= '$_POST[nota]', 
   vencimento = '$_POST[vencimento]', prazo='$_POST[prazo]', condicoes_pag='$_POST[cond]', comprador='$_POST[comprador]', observacao='$_POST[obs]'
   where id='$c_id'";
    $result_up = $conection->query($c_sql_up);
    header('location: /gop/almoxarifado/compras_lista.php');
}


?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="container  -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Editar dados de Pedido de Compra<h5>
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
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Descritivo</label>
                <div class="col-sm-8">
                    <input type="text" maxlength="120" class="form-control" name="descritivo" readonly value="<?php echo $registro['descritivo']; ?>">
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Nome do Fornecedor</label>
                <div class="col-sm-8">
                    <input type="text" maxlength="120" class="form-control" name="fornecedor" readonly value="<?php echo $registro['fornecedor']; ?>">
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-md-3 form-label">Data </label>
                <div class="col-sm-2">
                    <input readonly type="Date" readonly class="form-control" name="data" id="data" value='<?php echo $registro['data']; ?>'>
                </div>
                <label class="col-sm-2 col-form-label">Tipo do pedido</label>
                <div class="col-sm-4">
                    <select class="form-select form-select-lg mb-3" id="tipo" name="tipo" required>
                        <option <?= ($registro['tipo'] == 'Avulsa Interna') ? 'selected' : '' ?>>Avulsas Internas</option>
                        <option <?= ($registro['tipo'] == 'Manutenção') ? 'selected' : '' ?>>Manutenção</option>
                        <option <?= ($registro['tipo'] == 'Operacionais') ? 'selected' : '' ?>>Operacionais</option>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">No. da Nota</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="nota" value="<?php echo $registro['nota']; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Cond. Pag.</label>
                <div class="col-sm-4">
                    <input type="text" maxlength="20" class="form-control" name="cond" value="<?php echo $registro['condicoes_pag']; ?>">
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Prazo (dias)</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="50" class="form-control" name="prazo" value="<?php echo $registro['prazo']; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Comprador</label>
                <div class="col-sm-4">
                    <input type="text" maxlength="100" class="form-control" name="comprador" value="<?php echo $registro['comprador']; ?>">
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Vencimento</label>
                <div class="col-sm-2">
                    <input type="date" class="form-control" name="vencimento" value="<?php echo $registro['vencimento']; ?>">
                </div>
                <label class="col-sm-1 col-form-label">Frete</label>
                <div class="col-sm-2">
                    <input type="text" readonly class="form-control" name="frete" value="<?php echo  $formatter->formatCurrency($registro['valor_frete'], 'BRL'); ?>">
                </div>
                <label class="col-sm-1 col-form-label">Valor</label>
                <div class="col-sm-2">
                    <input type="text" readonly class="form-control" name="valor" value="<?php echo  $formatter->formatCurrency($registro['valor'], 'BRL'); ?>">
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Observação</label>
                <div class="col-sm-8">
                    <textarea class="form-control" id="obs" name="obs" rows="6"><?php echo $registro['observacao']; ?></textarea>
                </div>
            </div>
            <br>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/almoxarifado/compras_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>



        </form>
    </div>

</body>

</html>