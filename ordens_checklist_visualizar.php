<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("conexao.php");
include("links2.php");
$c_id = $_GET["id"];

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/pops_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do pop
    $c_sql = " SELECT checklist.id, checklist.descricao, checklist.descritivo FROM checklist where checklist.id='$c_id'";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/ordens_gerenciar.php');
        exit;
    }
    $c_descricao = $registro['descricao'];
    $c_descritivo = $registro['descritivo'];
    
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
                    <h5>Visualizar Checklist da Ordem de serviço<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Visualização do checklist selecionado da Ordem de serviço No.<?php echo $_SESSION['id_ordem']; ?></h5>
        </div>
        <hr>
       
        <div class="row mb-3">
            <p>
            <h5><strong>Descrição :</strong></h5>
            </p>
            <div class="col-sm-6">

                <p><?php echo $c_descricao; ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <h5><strong>Descritivo do checklist :</strong></h5>
            <div class="col-sm-7">
                <p><?php echo $c_descritivo ?></p>
            </div>
        </div>
   


    </div>


</body>

</html>