<?php

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("conexao.php");
include("links2.php");

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>

    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Cadastro de Preventivas<h5>
        </div>
    </div>
    <div class="content">

        <div class="container -my5">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

                </div>
                <h5><?php $_SESSION['c_usuario'] ?>Clique em nova preventiva um novo registro de preventiva ou realize uma pesquisa com as opções de pesquisa abaixo</h5>
            </div>


            <form method="post">
                <div style="padding-top:5px;padding-bottom:15px">
                    <a class="btn btn btn-sm" href="solicitacao_nova.php"><img src="\gop\images\contato.png" alt="" width="25" height="25"> Nova Solicitação</a>
                    <button type="submit" name='btnpesquisa' id='btnpesquisa' class="btn btn btn-sm"><img src="\gop\images\lupa.png" alt="" width="20" height="20"></span> Pesquisar</button>

                    <!--<a class="btn btn btn-sm" href="#"><img src="\gop\images\eraser.png" alt="" width="25" height="25"> Limpar pesquisa</a> -->
                    <a class="btn btn btn-sm" href="\gop\menu.php"><img src="\gop\images\voltar.png" alt="" width="25" height="25"> Voltar</a>
                </div>
                <div class="panel panel-light class">
                    <div class="panel-heading text-center">
                        <h5>Opções de Consulta<h5>
                    </div>
                </div>
                <div class="row mb-3">

                    <label class="col-md-2 form-label">No. da Solicitação</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" name="numero" id="numero">
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
                <br>

                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Status</label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="status" name="status" value="<?php echo $c_status; ?>">
                            <option>Todos</option>
                            <option>Aberta</option>
                            <option>Em Andamento</option>
                            <option>Concluída</option>
                        </select>
                    </div>
                    <label class="col-sm-1 col-form-label">Tipo</label>
                    <div class="col-sm-2">
                        <select class="form-select form-select-lg mb-3" id="tipo" name="tipo" value="<?php echo $c_tipo; ?>">
                            <option>Todos</option>
                            <option>Programada</option>
                            <option>Urgência</option>
                        </select>
                    </div>


                </div>
                <div class="row mb-3">

                    <label class="col-sm-2 col-form-label">Solicitante </label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="solicitante" name="solicitante">
                            <?php
                            if ($_SESSION['tipo'] <> 'Solicitante') {
                                echo "<option>Todos</option>";
                            }

                            // select da tabela de solicitantes
                            if ($_SESSION['tipo'] <> 'Solicitante') {
                                $c_sql_sol = "SELECT usuarios.id, usuarios.nome FROM usuarios ORDER BY usuarios.nome";
                            } else {
                                $c_login = $_SESSION['c_usuario'];
                                $c_sql_sol = "SELECT usuarios.id, usuarios.nome FROM usuarios where usuarios.login='$c_login'
                                 ORDER BY usuarios.nome";
                            }

                            $result_sol = $conection->query($c_sql_sol);
                            while ($c_linha = $result_sol->fetch_assoc()) {
                                echo "  
                          <option>$c_linha[nome]</option>
                        ";
                            }
                            ?>
                        </select>
                    </div>
                    <label class="col-sm-1 col-form-label">Setor </label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="setor" name="setor">
                            <option>Todos</option>
                            <?php
                            // select da tabela de setores
                            $c_sql_setor = "SELECT setores.id, setores.descricao FROM setores ORDER BY setores.descricao";
                            $result_setor = $conection->query($c_sql_setor);
                            while ($c_linha = $result_setor->fetch_assoc()) {
                                echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                            }
                            ?>
                        </select>
                    </div>
                </div>


                <div class="row mb-3">
                    <label class="col-md-2 form-label">Descritivo</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" name="descritivo" id="descritivo">
                    </div>
                </div>


            </form>
        </div>

</body>

</html>