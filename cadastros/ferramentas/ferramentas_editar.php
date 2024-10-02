<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include_once "../../lib_gop.php";
include("../../conexao.php");
include("../../links2.php");

// rotina de post dos dados do formuário
$c_id = "";
$c_descricao = "";
$c_patrimonio = "";
$c_serie = "";
$c_notafiscal = "";
$d_dataaquisicao = null;
$n_valoraquisicao = 0;
$d_datagarantia = null;
$c_conservacao = "";
$c_obs = "";
// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/cadastros/ferramentas/ferramentas_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from ferramentas where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/cadastros/ferramentas/ferramentas_lista.php');
        exit;
    }

    $c_descricao = $registro['descricao'];
    $c_patrimonio = $registro['patrimonio'];
    $c_serie = $registro['serie'];
    $c_notafiscal = $registro['notafiscal'];
    $n_valoraquisicao = $registro['valor_aquisicao'];
    $c_conservacao = $registro['conservacao'];
    $c_obs = $registro['obs'];
    $d_dataaquisicao = new DateTime($registro['data_aquisicao']);
    $d_datagarantia = new DateTime($registro['data_garantia']);
    $d_dataaquisicao = $d_dataaquisicao->format('y-m-d');
    $d_datagarantia = $d_datagarantia->format('y-m-d');
    $i_marca = $registro['id_marca'];
    $i_fornecedor = $registro['id_fornecedor'];
    $i_fabricante = $registro['id_fabricante'];
    $i_oficina = $registro['id_oficina'];
} else {
    // metodo post para atualizar dados
    $c_id = $_POST["id"];
    $c_descricao = $_POST['descricao'];
    $c_patrimonio = $_POST['patrimonio'];
    $c_serie = $_POST['serie'];
    $c_notafiscal = $_POST['notafiscal'];
    $n_valoraquisicao = $_POST['valoraquisicao'];
    $c_conservacao = $_POST['conservacao'];
    $c_obs = $_POST['obs'];
    $c_marca = $_POST['marca'];
    $c_fabricante = $_POST['fabricante'];
    $c_fornecedor = $_POST['fornecedor'];
    $c_oficina = $_POST['oficina'];
    $d_dataaquisicao = new DateTime($_POST['dataaquisicao']);
    $d_dataaquisicao = $d_dataaquisicao->format('Y-m-d');
    $d_datagarantia = new DateTime($_POST['datagarantia']);
    $d_datagarantia = $d_datagarantia->format('Y-m-d');

    do {
        if (empty($c_descricao)  || empty($c_patrimonio)) {
            $msg_erro = "Campos descrição , patrimônio e data da aquisição devem ser preenchidos!!";
            break;
        }
        // monto sql para atabelas primarias para pegar a id
        // localizo o id do valor do combobox de centro de custos
        // select da tabela de oficinas para pegar codigo
        $c_sql_secundario = "SELECT oficinas.id FROM oficinas where oficinas.descricao='$c_oficina' ORDER BY oficinas.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_oficina = $registro_secundario['id'];
        // select da tabela de marcas para pegar codigo
        $c_sql_secundario2 = "SELECT marcas.id FROM marcas where marcas.descricao='$c_marca' ORDER BY marcas.descricao";
        $result_secundario2 = $conection->query($c_sql_secundario2);
        $registro_secundario2 = $result_secundario2->fetch_assoc();
        $i_marca = $registro_secundario2['id'];
        // select da tabela de forecedores para pegar codigo
        $c_sql_secundario = "SELECT fornecedores.id FROM fornecedores where fornecedores.descricao='$c_fornecedor' ORDER BY fornecedores.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_fornecedor = $registro_secundario['id'];
        // select da tabela de fabricantes para pegar codigo
        $c_sql_secundario = "SELECT fabricantes.id FROM fabricantes where fabricantes.descricao='$c_fabricante' ORDER BY fabricantes.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_fabricante = $registro_secundario['id'];
        // grava dados no banco
        // faço a Leitura da tabela com sql
        $c_sql = "Update ferramentas" .
            " SET descricao='$c_descricao', patrimonio='$c_patrimonio', serie='$c_serie', notafiscal='$c_notafiscal'," .
            " valor_aquisicao='$n_valoraquisicao', data_garantia='$d_datagarantia', data_aquisicao='$d_dataaquisicao'," .
            " conservacao='$c_conservacao', obs='$c_obs'," .
            " id_oficina='$i_oficina', id_marca='$i_marca', id_fornecedor='$i_fornecedor', id_fabricante='$i_fabricante'" .
            " where id=$c_id";
        echo $c_sql;
        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/cadastros/ferramentas/ferramentas_lista.php');
    } while (false);
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>

    <div class="container -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Editar dados da Ferramenta<h5>
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
            <input type="hidden" name="id" value="<?php echo $c_id; ?>">

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Descrição</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Patrimônio</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="15" class="form-control" name="patrimonio" value="<?php echo $c_patrimonio; ?>">
                </div>
                <label class="col-sm-2 col-form-label">No. de Série</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="15" class="form-control" name="serie" value="<?php echo $c_serie; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fornecedor </label>
                <div class="col-sm-6">
                    <select class="form-select form-select-lg mb-3" id="fornecedor" name="fornecedor">
                        <?php
                        // select da tabela de fornecedores
                        $c_sql_fornecedores = "SELECT fornecedores.id, fornecedores.descricao FROM fornecedores ORDER BY fornecedores.descricao";
                        $result_fornecedores = $conection->query($c_sql_fornecedores);
                        while ($c_linha = $result_fornecedores->fetch_assoc()) {
                            if ($c_linha['id'] == $i_fornecedor) {
                                $op = 'selected';
                            } else {
                                $op = '';
                            }
                            echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fabricante </label>
                <div class="col-sm-6">
                    <select class="form-select form-select-lg mb-3" id="fabricante" name="fabricante">
                        <?php
                        // select da tabela de fabricantes
                        $c_sql_fabricante = "SELECT fabricantes.id, fabricantes.descricao FROM fabricantes ORDER BY fabricantes.descricao";
                        $result_fabricante = $conection->query($c_sql_fabricante);
                        while ($c_linha = $result_fabricante->fetch_assoc()) {
                            if ($c_linha['id'] == $i_fabricante) {
                                $op = 'selected';
                            } else {
                                $op = '';
                            }
                            echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Marca </label>
                <div class="col-sm-6">
                    <select class="form-select form-select-lg mb-3" id="marca" name="marca">
                        <?php
                        // select da tabela de Marcas
                        $c_sql_marca = "SELECT marcas.id, marcas.descricao FROM marcas ORDER BY marcas.descricao";
                        $result_marca = $conection->query($c_sql_marca);
                        while ($c_linha = $result_marca->fetch_assoc()) {
                            if ($c_linha['id'] == $i_marca) {
                                $op = 'selected';
                            } else {
                                $op = '';
                            }
                            echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Oficina </label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="oficina" name="oficina">
                        <?php
                        // select da tabela de oficinas
                        $c_sql_oficina = "SELECT oficinas.id, oficinas.descricao FROM oficinas ORDER BY oficinas.descricao";
                        $result_oficina = $conection->query($c_sql_oficina);
                        while ($c_linha = $result_oficina->fetch_assoc()) {
                            if ($c_linha['id'] == $i_oficina) {
                                $op = 'selected';
                            } else {
                                $op = '';
                            }
                            echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>

                <label class="col-sm-2 col-form-label">Conservação</label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="conservacao" name="conservacao">
                        <option <?= ($c_conservacao == 'Péssimo') ? 'selected' : '' ?>>Péssimo</option>
                        <option <?= ($c_conservacao == 'Ruim') ? 'selected' : '' ?>>Ruim</option>
                        <option <?= ($c_conservacao == 'Razoável') ? 'selected' : '' ?>>Razoável</option>
                        <option <?= ($c_conservacao == 'Bom') ? 'selected' : '' ?>>Bom</option>
                        <option <?= ($c_conservacao == 'Muito Bom') ? 'selected' : '' ?>>Muito Bom</option>
                        <option <?= ($c_conservacao == 'Ótimo') ? 'selected' : '' ?>>Ótimo</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Data da Aquisição</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="10" class="form-control" id="dataaquisicao" name="dataaquisicao" value="<?php echo $d_dataaquisicao; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Valor da Aquisição</label>
                <div class="col-sm-2">
                    <input type="text" placeholder="0,00" class="form-control" name="valoraquisicao" value="<?php echo $n_valoraquisicao; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Nota Fiscal</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" name="notafiscal" value="<?php echo $c_notafiscal; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Data Fim da Garantia</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="10" class="form-control" id="datagarantia" name="datagarantia" value="<?php echo $d_datagarantia; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Observação</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="obs" name="obs" rows="3"><?php echo $c_obs; ?></textarea>
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
                <div class="offset-sm-3 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/cadastros/ferramentas/ferramentas_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>

        </form>
    </div>

</body>

</html>