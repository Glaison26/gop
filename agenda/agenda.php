<?php
session_start(); // controle de acesso ao formulário
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agenda de Executores</title>
    <link rel="stylesheet" href="/gop/css/basico.css">

</head>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Agenda de Executores<h5>
        </div>
    </div>
    <div class="content">
        <div class="container -my5">
            <div class="container content-box">
                <form action="processa_agenda.php" method="post">
                    <div style="padding-top:5px;padding-bottom:5px">
                        <div class="panel panel-primary">
                            <div class="panel-heading">

                                <button type="submit" name='btnpesquisa' id='btnpesquisa' class="btn btn btn-sm"><img src="\gop\images\lupa.png" alt="" width="20" height="20"></span> Pesquisar</button>
                                <!--<a class="btn btn btn-sm" href="#"><img src="\gop\images\eraser.png" alt="" width="25" height="25"> Limpar pesquisa</a> -->
                                <a class="btn btn btn-sm" href="\gop\menu.php"><img src="\gop\images\saida.png" alt="" width="25" height="25"> Voltar</a>
                            </div>
                        </div>
                    </div>
                    <div class='alert alert-info' role='alert'>
                        <div style="padding-left:15px;">
                            <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

                        </div>
                        <h5><?php echo "Informe o Executor e o periodo para visualizar a agenda e clique em pesquisar" ?> </h5>
                    </div>
                    <div class="panel panel-light class">
                        <div class="panel-heading text-center">
                            <h5>Opções de pesquisa<h5>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">Executor</label>
                        <!--combobox para selecionar responsável pela tabela de executores-->
                        <div class="col-sm-7">
                            <select class="form-select form-select-lg mb-3" id="executor" name="executor" required>
                                <option></option>
                                <?php
                                // select da tabela de executores
                                $c_sql_exec = "SELECT executores.id, executores.nome FROM executores ORDER BY executores.nome";
                                $result_exec = $conection->query($c_sql_exec);
                                while ($c_linha = $result_exec->fetch_assoc()) {
                                   echo "<option value='" . $c_linha['id'] . "'>" . $c_linha['nome'] . "</option>";
                                }
                                ?>
                            </select>
                        </div>

                    </div>
                    <br>
                    <div class="row mb-3">
                        <label class="col-md-2 form-label">De</label>
                        <div class="col-sm-3">
                            <input type="Date" class="form-control" name="data1" id="data1" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                        </div>
                        <label class="col-md-1 form-label">até</label>
                        <div class="col-sm-3">
                            <input type="Date" class="form-control" name="data2" id="data2" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>

</html>