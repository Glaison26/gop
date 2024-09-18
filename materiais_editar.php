<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include_once "lib_gop.php";
include("conexao.php");
include("links2.php");

// rotina de post dos dados do formuário
$c_id = "";
$c_descricao = '';
$n_custo = 0.0;
$n_qtdmin = 0;
$n_qtdmax = 0;
$d_ultimasaida = 'dd/mm/yyyy';
$d_ultimaentrada = 'dd/mm/yyyy';
$n_quantidadeatual = 0;
$d_validade = 'dd/mm/yyyy';
$c_fator = "1";
$c_obs = '';

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/materiais_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from materiais where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/materiais_lista.php');
        exit;
    }
    $c_descricao = $registro['descricao'];
    $i_marca = $registro['id_marca'];
    $i_grupo = $registro['id_grupo'];
    $i_unidadesaida = $registro['id_unidadeSaida'];
    $i_unidadeentrada = $registro['id_unidadeEntrada'];
    $n_custo = $registro['custo'];
    $n_qtdmin = $registro['qtdmin'];
    $n_qtdmax = $registro['qtdmax'];
    $d_ultimasaida = new DateTime($registro['ultimasaida']);
    $d_ultimasaida = $d_ultimasaida->format('y-m-d');
    $d_ultimaentrada = new DateTime($registro['ultimaentrada']);
    $d_ultimaentrada = $d_ultimaentrada->format('y-m-d');
    $n_quantidadeatual = $registro['quantidadeatual'];
    $d_validade = new DateTime($registro['data_validade']);
    $d_validade = $d_validade->format('y-m-d');
    $c_fator = $registro['fator'];
    $c_obs = $registro['obs'];
} else {
    // metodo post para atualizar dados
    $c_id = $_POST["id"];
    $c_descricao = $_POST['descricao'];
    $c_marca = $_POST['marca'];
    $c_grupo = $_POST['grupo'];
    $c_unidadesaida = $_POST['unidadesaida'];
    $c_unidadeentrada = $_POST['unidadeentrada'];
    $n_custo = $_POST['custo'];
    $n_qtdmin = $_POST['qtdmin'];
    $n_qtdmax = $_POST['qtdmax'];
    $d_ultimasaida = new DateTime($_POST['ultimasaida']);
    $d_ultimasaida = $d_ultimasaida->format('Y-m-d');
    $d_ultimaentrada = new DateTime($_POST['ultimaentrada']);
    $d_ultimaentrada = $d_ultimaentrada->format('Y-m-d');
    $n_quantidadeatual = $_POST['quantidadeatual'];
    $d_validade = new DateTime($_POST['validade']);
    $d_validade = $d_validade->format('Y-m-d');
    $c_fator = $_POST['fator'];
    $c_obs = $_POST['obs'];

    do {
        if (empty($c_descricao)) {
            $msg_erro = "Campos descrição deve ser preenchidos!!";
            break;
        }
        if (($d_ultimaentrada == null)) {
            $msg_erro = "Campos data da ultima entrada deve ser informado!!";
            break;
        }

        if (($d_ultimasaida == null)) {
            $msg_erro = "Campos data da ultima saida deve ser informado!!";
            break;
        }

        if (($d_validade == null)) {
            $msg_erro = "Campos data de validade deve ser informado!!";
            break;
        }
        // monto sql para atabelas primarias para pegar a id
        // localizo o id do valor do combobox de centro de custos
        // select da tabela de GRUPO para pegar codigo
        $c_sql_secundario = "SELECT grupos.id FROM grupos where grupos.descricao='$c_grupo' ORDER BY grupos.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_grupo = $registro_secundario['id'];
        // select da tabela de marcas para pegar codigo
        $c_sql_secundario2 = "SELECT marcas.id FROM marcas where marcas.descricao='$c_marca' ORDER BY marcas.descricao";
        $result_secundario2 = $conection->query($c_sql_secundario2);
        $registro_secundario2 = $result_secundario2->fetch_assoc();
        $i_marca = $registro_secundario2['id'];
        // select da tabela de unidade de saida para pegar codigo
        $c_sql_secundario = "SELECT unidades.id FROM unidades where unidades.descricao='$c_unidadesaida' ORDER BY unidades.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_unidadesaida = $registro_secundario['id'];
        // select da tabela de unidades de entrada para pegar codigo
        $c_sql_secundario = "SELECT unidades.id FROM unidades where unidades.descricao='$c_unidadeentrada' ORDER BY unidades.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_unidadeentrada = $registro_secundario['id'];
        // grava dados no banco
        // faço a Leitura da tabela com sql
        $c_sql = "Update materiais" .
            " SET descricao = '$c_descricao',  custo='$n_custo', qtdmin='$n_qtdmin', qtdmax='$n_qtdmax', fator='$c_fator', ultimasaida='$d_ultimasaida', ultimaentrada='$d_ultimaentrada'," .
            " data_validade = '$d_validade', quantidadeatual = '$n_quantidadeatual', obs='$c_obs ', id_marca='$i_marca'," .
            " id_grupo='$i_grupo', id_unidadesaida='$i_unidadesaida', id_unidadeentrada='$i_unidadeentrada' " .
            " where id=$c_id";
        echo $c_sql;
        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/materiais_lista.php');
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

    <div class="container  -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Editar dados do Material<h5>
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
                <label class="col-sm-3 col-form-label">Grupo </label>
                <div class="col-sm-6">
                    <select class="form-select form-select-lg mb-3" id="grupo" name="grupo">
                        <?php
                        // select da tabela de grupos
                        $c_sql_grupo = "SELECT grupos.id, grupos.descricao FROM grupos ORDER BY grupos.descricao";
                        $result_grupo = $conection->query($c_sql_grupo);
                        while ($c_linha = $result_grupo->fetch_assoc()) {
                            if ($c_linha['id'] == $i_grupo) {
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
            <hr>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Saldo Atual</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="quantidadeatual" value="<?php echo $n_quantidadeatual; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Valor de Custo</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="custo" value="<?php echo $n_custo; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Unidade de Entrada </label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="unidadeentrada" name="unidadeentrada">
                        <?php
                        // select da tabela de unidades
                        $c_sql_unidades = "SELECT unidades.id, unidades.descricao FROM unidades ORDER BY unidades.descricao";
                        $result_unidades = $conection->query($c_sql_unidades);
                        while ($c_linha = $result_unidades->fetch_assoc()) {
                            if ($c_linha['id'] == $i_unidadeentrada) {
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

                <label class="col-sm-2 col-form-label">Unidade de Saida </label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="unidadesaida" name="unidadesaida">
                        <?php
                        // select da tabela de unidades
                        $c_sql_unidades = "SELECT unidades.id, unidades.descricao FROM unidades ORDER BY unidades.descricao";
                        $result_unidades = $conection->query($c_sql_unidades);
                        while ($c_linha = $result_unidades->fetch_assoc()) {
                            if ($c_linha['id'] == $i_unidadesaida) {
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
                <label class="col-sm-3 col-form-label">Estoque Mínimo</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="qtdmin" value="<?php echo $n_qtdmin; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Estoque Máximo</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="qtdmax" value="<?php echo $n_qtdmax; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Ultima Saida</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="ultimasaida" value="<?php echo $d_ultimasaida; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Ultima Entrada</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="ultimaentrada" value="<?php echo $d_ultimaentrada; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Data de Validade</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="20" class="form-control" name="validade" value="<?php echo $d_validade; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Fator Conversão</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="5" class="form-control" name="fator" value="<?php echo $c_fator; ?>">
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Observação</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="obs" name="obs" rows="3"><?php echo $c_obs ?></textarea>
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
                    <a class='btn btn-danger' href='/gop/materiais_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>

        </form>
    </div>

</body>

</html>