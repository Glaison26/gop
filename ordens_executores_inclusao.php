<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('links2.php');
include('conexao.php');

$c_id = $_SESSION['id_ordem'];

$c_valor = "0";
$c_indice = '';
$msg_erro = "";


// inclusão do material no banco de dados
if ($_SERVER['REQUEST_METHOD'] == 'POST' && !isset($_POST['btncusto'])) {
    $c_custo = $_POST['valor_hora'];
    $c_tempo_horas = $_POST['tempo_horas'];
    $c_tempo_minutos = $_POST['tempo_minutos'];
    $c_executor = $_POST['executor'];


    //
    do {
        if (empty($c_executor)) {
            $msg_erro = "Todos os campos devem ser preencidos !!";
            break;
        }

        if (!is_numeric($c_tempo_horas) || !is_numeric($c_tempo_minutos)) {

            $msg_erro = "Valores de tempo Inválidos !!";
            break;
        }

        if ($c_tempo_minutos > 60) {
            $msg_erro = "Valor de minutos inválido !!";
            break;
        }
        if (!is_numeric($c_custo) || ($c_custo <= 0)) {

            $msg_erro = "Valor de hora Inválido !!";
            break;
        }

        // sql para pegar codigo do executor
        $c_sql_executor = "SELECT executores.id, executores.nome FROM executores
    where executores.nome = '$c_executor' ORDER BY executores.nome";
        $result_executor = $conection->query($c_sql_executor);
        $c_linha = $result_executor->fetch_assoc();
        $i_id_executor = $c_linha['id'];
        // calculo de valor total
        $custo_horas = $c_tempo_horas * $c_custo;
        $fracao = $c_tempo_minutos / 60;
        $custo_minuto = $fracao * $c_custo;
        $valor_total = $custo_horas + $custo_minuto;

        //
        $c_sql = "Insert into ordens_executores (id_executor, tempo_horas, tempo_minutos, valor_hora, valor_total, id_ordem)
                 Value ('$i_id_executor', '$c_tempo_horas', '$c_tempo_minutos','$c_custo',' $valor_total','$c_id')";
        $result = $conection->query($c_sql);

        header('location: /gop/ordens_gerenciar.php');
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
                    <h5>Novo registro de executor para Ordem de Serviço<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Entre com os dados do Executor a ser anexado a Ordem de Serviço No. <?php echo $c_id ?> Todos os campos são obrigatórios</h5>
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
                <label class="col-sm-2 col-form-label">Executor</label>
                <div class="col-sm-5">
                    <select class="form-select form-select-lg mb-3" id="executor" name="executor">

                        <?php
                        if ($c_indice == '')
                            echo "<option></option>";
                        // select da tabela de Material
                        $c_sql_executor = "SELECT executores.id, executores.nome FROM executores ORDER BY executores.nome";
                        $result_executor = $conection->query($c_sql_executor);
                        while ($c_linha = $result_executor->fetch_assoc()) {

                            echo "  
                          <option $op>$c_linha[nome]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Tempo em horas</label>
                <div class="col-sm-2">
                    <input type="number" class="form-control" name="tempo_horas" value="<?php echo $n_tempo_horas; ?>">
                </div>
                <label class="col-sm-1 col-form-label">Tempo em Min.</label>
                <div class="col-sm-2">
                    <input type="number" class="form-control" name="tempo_minutos" value="<?php echo $n_tempo_minutos; ?>">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">Valor hora</label>
                <div class="col-sm-3">
                    <input placeholder="valor em Real" type="text" data-thousands="." data-decimal=","
                        data-prefix="R$ " class="form-control" id="valor_hora" name="valor_hora" value="<?php echo $c_valor ?>">
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/ordens_gerenciar.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>
            </div>
        </form>
    </div>

</body>

</html>