<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// funções 

function carregadados()
{
    $c_descricao = $_POST['descricao'];
    $c_patrimonio = $_POST['patrimonio'];
    $c_serie = $_POST['serie'];
    $c_notafiscal = $_POST['notafiscal'];
    $d_dataaquisicao = $_POST['dataaquisicao'];
    $n_valoraquisicao = $_POST['valoraquisicao'];
    $d_datagarantia = $_POST['datagarantia'];
    $c_conservacao = $_POST['conservacao'];
    $c_obs = $_POST['obs'];
}

include_once "lib_gop.php";

$c_descricao = "";
$c_patrimonio = "";
$c_serie = "";
$c_notafiscal = "";
$d_dataaquisicao = null;
$n_valoraquisicao = 0;
$d_datagarantia = null;
$c_conservacao = "";
$c_obs = "";

// conexão dom o banco de dados
$servername = $_SESSION['local'];
$username = $_SESSION['usuario'];
$password =  $_SESSION['senha'];
$database = $_SESSION['banco'];
// criando a conexão com banco de dados
$conection = new mysqli($servername, $username, $password, $database);
// checo erro na conexão
if ($conection->connect_error) {
    die("Erro na Conexão com o Banco de Dados!! " . $conection->connect_error);
}
// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

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

    do {
        if (empty($c_descricao)  || empty($c_patrimonio)) {
            $msg_erro = "Campos descrição , patrimônio e data da aquisição devem ser preenchidos!!";
            carregadados();
            break;
        }

        $d_dataaquisicao = new DateTime($_POST['dataaquisicao']);
        $d_dataaquisicao = $d_dataaquisicao->format('Y-m-d');
        $d_datagarantia = new DateTime($_POST['datagarantia']);
        $d_datagarantia = $d_datagarantia->format('Y-m-d');
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
        $c_sql = "Insert into ferramentas (descricao,  patrimonio, serie, notafiscal, valor_aquisicao, data_garantia, data_aquisicao, conservacao, obs," .
            " id_oficina, id_marca, id_fornecedor, id_fabricante)" .
            "Value ('$c_descricao', '$c_patrimonio', '$c_serie', '$c_notafiscal', '$n_valoraquisicao', '$d_datagarantia', '$d_dataaquisicao', '$c_conservacao'," .
            " '$c_obs', '$i_oficina', '$i_marca', '$i_fornecedor', '$i_fabricante')";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $c_descricao = "";
        $c_patrimonio = "";
        $c_serie = "";
        $c_notafiscal = "";
        $d_dataaquisicao = null;
        $n_valoraquisicao = 0.00;
        $d_datagarantia = null;
        $c_conservacao = "";
        $c_obs = "";


        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/ferramentas_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Novo Setor</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css">
    <link rel="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css">
    <link href="https://nightly.datatables.net/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
    <script type="text/javascript" src="js/jquery.maskedinput-1.1.4.pack.js"></script>


</head>
<div class="panel panel-light" style="background-color: #e3f2fd;">
    <div class="panel-heading text-center">
        <h2>Nova Ferramenta</h2>
    </div>
</div>
<br>

<body>
    <div class="container -my5">
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <h3>$msg_erro</h3>
            </div>
                ";
        }
        ?>

        <form method="post">

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
                    <select class="form-control form-control-lg" id="fornecedor" name="fornecedor">
                        <?php
                        // select da tabela de fornecedores
                        $c_sql_fornecedores = "SELECT fornecedores.id, fornecedores.descricao FROM fornecedores ORDER BY fornecedores.descricao";
                        $result_fornecedores = $conection->query($c_sql_fornecedores);
                        while ($c_linha = $result_fornecedores->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fabricante </label>
                <div class="col-sm-6">
                    <select class="form-control form-control-lg" id="fabricante" name="fabricante">
                        <?php
                        // select da tabela de fabricantes
                        $c_sql_fabricante = "SELECT fabricantes.id, fabricantes.descricao FROM fabricantes ORDER BY fabricantes.descricao";
                        $result_fabricante = $conection->query($c_sql_fabricante);
                        while ($c_linha = $result_fabricante->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Marca </label>
                <div class="col-sm-6">
                    <select class="form-control form-control-lg" id="marca" name="marca">
                        <?php
                        // select da tabela de Marcas
                        $c_sql_marca = "SELECT marcas.id, marcas.descricao FROM marcas ORDER BY marcas.descricao";
                        $result_marca = $conection->query($c_sql_marca);
                        while ($c_linha = $result_marca->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Oficina </label>
                <div class="col-sm-2">
                    <select class="form-control form-control-lg" id="oficina" name="oficina">
                        <?php
                        // select da tabela de oficinas
                        $c_sql_oficina = "SELECT oficinas.id, oficinas.descricao FROM oficinas ORDER BY oficinas.descricao";
                        $result_oficina = $conection->query($c_sql_oficina);
                        while ($c_linha = $result_oficina->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>

                <label class="col-sm-2 col-form-label">Conservação</label>
                <div class="col-sm-2">
                    <select class="form-control form-control-lg" id="conservacao" name="conservacao">
                        <option>Péssimo</option>
                        <option>Ruim</option>
                        <option>Razoável</option>
                        <option>Bom</option>
                        <option>Muito Bom</option>
                        <option>Ótimo</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Data da Aquisição</label>
                <div class="col-sm-2">
                    <input type="date" maxlength="10" class="form-control" id="dataaquisicao" name="dataaquisicao" value="<?php echo $d_dataaquisicao; ?>">
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
                    <input type="date" maxlength="10" class="form-control" id="datagarantia" name="datagarantia" value="<?php echo $d_datagarantia; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Observação</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="obs" name="obs" rows="3"></textarea>
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
                    <a class='btn btn-danger' href='/gop/ferramentas_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>