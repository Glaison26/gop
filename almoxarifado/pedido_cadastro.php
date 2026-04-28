<?php
include_once('../conexao.php');
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../links2.php");
// definição de variáveis para preenchimento do formulário
$c_descritivo = "";
$c_nota = "";
$c_condicao = "";
$c_prazo = "";
$c_comprador = "";
$c_observacao = "";
$d_data = date('Y-m-d');
$d_vencimento = "";
$n_frete = 0;
$n_valor = 0;
// grava dados do formulario de pedidos de compra
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $c_descritivo = $_POST['descritivo'];
    $c_nota = $_POST['nota'];
    $c_condicao = $_POST['cond'];
    $c_prazo = $_POST['prazo'];
    $c_comprador = $_POST['comprador'];
    $c_observacao = $_POST['obs'];
    $d_data = $_POST['data'];
    $d_vencimento = $_POST['vencimento'];
    $i_id_fornecedor = $_POST['fornecedor'];
    $n_frete = $_POST['frete'];
    $n_valor = $_POST['valor'];
    $c_tipo_compras = $_POST['tipo_compra'];
    // rotina de inclusão
    $c_sql = "Insert into compras (id_fornecedor, descritivo, data, tipo, nota, condicoes_pag, prazo, comprador, vencimento, valor_frete,
     valor, observacao,status, tipo_compra) 
        Value ('$i_id_fornecedor', '$c_descritivo', '$d_data', '$_POST[tipo]', '$c_nota', '$c_condicao', '$c_prazo', '$c_comprador',
         '$d_vencimento', '$n_frete', '$n_valor', '$c_observacao', 'A', '$c_tipo_compras')";
    $result = $conection->query($c_sql);
    if (!$result) {
        die("Erro ao Executar Sql!!" . $conection->connect_error);
    }
    header('location: /gop/almoxarifado/compras_lista.php');
}

?>

<!-- 
    Página de cadastro de pedido de compra
    - Formulário para cadastro de pedido de compra
    - Campos: Descritivo, Fornecedor, Data, Tipo do pedido, No. da Nota, Cond. Pag., Prazo (dias),
     Comprador, Vencimento, Frete, Valor e Observação 
    - Botão para salvar o pedido de compra e botão para cancelar o cadastro
-->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/gop/css/basico.css">

</head>

<body>
    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Incluir Pedido de Compra<h5>
                </div>
            </div>
        </div>
        <div class="container content-box">
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
                        <input type="text" required maxlength="120" class="form-control" name="descritivo" value="<?php echo $c_descritivo ?>">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Tipo compras</label>
                    <div class="col-sm-4">
                        <select class="form-select form-select-lg mb-3" id="tipo_compra" name="tipo_compra" required>
                            <option value="M">Materiais</option>
                            <option value="S">Serviços</option>
                        </select>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Nome do Fornecedor</label>
                    <div class="col-sm-8">
                        <!-- campo select combobox  para escolher o fornecedor -->
                        <select class="form-select form-select-lg mb-3" id="fornecedor" name="fornecedor" required>

                            <?php
                            // select da tabela de fornecedores
                            $c_sql = "Select id, descricao from fornecedores order by descricao";
                            $result = $conection->query($c_sql);
                            while ($registro_forn = $result->fetch_assoc()) {
                                echo "<option value='" . $registro_forn['id'] . "'>" . $registro_forn['descricao'] . "</option>";
                            }
                            ?>
                        </select>


                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-md-3 form-label">Data</label>
                    <div class="col-sm-2">
                        <input type="Date" required class="form-control" name="data" id="data" value='<?php echo $d_data; ?>'>
                    </div>
                    <label class="col-sm-2 col-form-label">Tipo do pedido</label>
                    <div class="col-sm-4">
                        <select class="form-select form-select-lg mb-3" id="tipo" name="tipo" required>
                            <option>Avulsas Internas</option>
                            <option>Manutenção</option>
                            <option>Operacionais</option>
                        </select>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">No. da Nota</label>
                    <div class="col-sm-2">
                        <input type="text" riquered maxlength="20" class="form-control" name="nota" value="<?php echo $c_nota; ?>">
                    </div>
                    <label class="col-sm-2 col-form-label">Cond. Pag.</label>
                    <div class="col-sm-4">
                        <input type="text" required maxlength="20" class="form-control" name="cond" value="<?php echo $c_condicao; ?>">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Prazo (dias)</label>
                    <div class="col-sm-2">
                        <input type="text" required maxlength="50" class="form-control" name="prazo" value="<?php echo $c_prazo ?>">
                    </div>
                    <label class="col-sm-2 col-form-label">Comprador</label>
                    <div class="col-sm-4">
                        <input type="text" required maxlength="100" class="form-control" name="comprador" value="<?php echo $c_comprador; ?>">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Vencimento</label>
                    <div class="col-sm-2">
                        <input type="date" required class="form-control" name="vencimento" value="<?php echo $d_vencimento; ?>">
                    </div>
                    <label class="col-sm-1 col-form-label">Frete</label>
                    <div class="col-sm-2">
                        <input type="text" required class="form-control" name="frete" value="<?php echo  $n_frete; ?>">
                    </div>
                    <label class="col-sm-1 col-form-label">Valor</label>
                    <div class="col-sm-2">
                        <input type="text" required  class="form-control" name="valor" value="<?php echo  $n_valor; ?>">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Observação</label>
                    <div class="col-sm-8">
                        <textarea class="form-control" id="obs" name="obs" rows="6"><?php echo $c_observacao ?></textarea>
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
    </div>

</body>

</html>