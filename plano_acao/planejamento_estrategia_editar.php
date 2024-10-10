<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
include("../links2.php");
include_once "../lib_gop.php";


$i_id = $_GET["id"];


if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/plano_acao/planejamento_estrategia.php');
        exit;
    }

    // leitura do registro através de sql usando id passada
    $c_sql = "select * from planejamento_diretrizes where id=$i_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/plano_acao/planejamento_estrategia.php');
        exit;
    }

    // carrego variaveis do banco de dados
    $c_prazo = $registro['prazo'];
    $c_local = $registro['local'];
    $c_custo = $registro['custo'];
    $c_responsavel = $registro['responsavel'];
    $c_situacao = $registro['situacao'];
    $c_chk_situacao = "";
    if ($c_situacao == 'C')
        $c_chk_situacao = "checked";

    $c_motivo = $registro['motivo'];
    $c_metodologia = $registro['metodologia'];
    $c_observacao = $registro['observacao'];
}
// metodo post para gravação dos dados dos materiais
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $c_prazo = $_POST['prazo'];
    $c_local = $_POST['local'];
    $c_custo = $_POST['custo'];
    $c_responsavel = $_POST['responsavel'];
    if (!isset($_POST['situacao'])) {
        $c_concluido = 'C';
    } else {
        $c_concluido = 'N';
    }
    $c_motivo = $_POST['motivo'];
    $c_metodologia = $_POST['metodologia'];
    $c_observacao = $_POST['observacao'];
    // Altera as informações
    $c_sql = "update planejamento_diretrizes set prazo='$c_prazo', local='$c_local', responsavel='$c_responsavel'
    , custo='$c_custo', situacao='$c_concluido', motivo='$c_motivo', metodologia='$c_metodologia', observacao='$c_observacao' where id='$c_id'";
    $result = $conection->query($c_sql);
    header('location: /gop/plano_acao/planejamento_estrategia.php');
}
?>
<!--
/////////////////////////////////////////////////
//  front end do formulario
////////////////////////////////////////////////
-->

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
                    <h5>Edição da Diretriz do Planejamento<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Edite os dados da Diretriz selecionada para o Planejamento</h5>
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
            <div style='padding-left:35px; padding-bottom:25px;'>
                <div class="row mb-8">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="situacao" name="situacao" <?php echo $c_chk_situacao ?>>
                        <label class="form-check-label" for="flexSwitchCheckChecked">Concluída</label>
                    </div>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Prazo</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="prazo" value="<?php echo $c_prazo; ?>">
                </div>
                <label class="col-sm-1 col-form-label">Local</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="local" value="<?php echo $c_local; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Responsável</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="responsavel" value="<?php echo $c_responsavel; ?>">
                </div>
                <label class="col-sm-1 col-form-label">Custo</label>
                <div class="col-sm-2">
                    <input placeholder="valor em Real" type="text" data-thousands="." data-decimal=","
                        data-prefix="R$ " class="form-control" id="custo" name="custo" value="<?php echo $c_custo ?>">
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Motivo</label>
                <div class="col-sm-7">
                    <textarea class="form-control" id="anc" name="anc" rows="5"><?php echo $c_motivo ?></textarea>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Metodologia</label>
                <div class="col-sm-7">
                    <textarea class="form-control" id="anc" name="anc" rows="5"><?php echo $c_metodologia ?></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Observacao</label>
                <div class="col-sm-7">
                    <textarea class="form-control" id="anc" name="anc" rows="5"><?php echo $c_observacao ?></textarea>
                </div>
            </div>


            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/ordens/ordens_gerenciar.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>
            </div>
        </form>
    </div>

</body>

</html>