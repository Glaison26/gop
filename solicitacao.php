<?php // controle de acesso ao formulário
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
            <h5>Solicitações de Serviços<h5>
        </div>
    </div>

    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Clique em nova solitação para abrir uma nova solicitação de serviço ou realize uma pesquisa com as opções abaixo</h5>
        </div>
        <a class="btn btn btn-sm" href="solicitacao_nova.php"><img src="\gop\images\contato.png" alt="" width="25" height="25"> Nova Solicitação</a>
        <a class="btn btn btn-sm" href="#"><img src="\gop\images\lupa.png" alt="" width="25" height="25"> Pesquisar</a>
        <a class="btn btn btn-sm" href="#"><img src="\gop\images\eraser.png" alt="" width="25" height="25"> Limpar pesquisa</a>
        <a class="btn btn btn-sm" href="\gop\menu.php"><img src="\gop\images\voltar.png" alt="" width="25" height="25"> Voltar</a>
        <hr>
    <p><h5>Opções para pesquisa</h5></p>
    </div>
    
   

</body>

</html>