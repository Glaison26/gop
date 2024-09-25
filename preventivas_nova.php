<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
$_SESSION['tiposolicitacao'] = 'V';
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
            <h5>Cadastro de Prevêntivas<h5>
        </div>
    </div>

    <div class="container -my5">

        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Escolha o tipo da Preventiva entre Recurso Fisico ou Espaço Físico</h5>
        </div>

        <div style="padding-bottom:45px;">
            <br>
            <p>
            <h4><strong>Opções : </h4></strong></p>
            <br>
            <div class="btn-group btn-group-lg">
                <a type="button" class="btn btn-primary" href="\gop\solicitacao_nova_recurso_pesquisa.php"><img src="\gop\images\config.png" alt="" width="30" height="30">
                    Serviço em Recurso Físico</a>
                <a type="button" class="btn btn-primary" href="\gop\solicitacao_nova_espaco_pesquisa.php"><img src="\gop\images\apartamento.png" alt="" width="30" height="30">
                    Serviço em Espaços Físicos</a>
                <a type="button" class="btn btn-primary" href="#"><img src="\gop\images\ordem.png" alt="" width="30" height="30">
                    Solicitação de Serviço Avulso</a>
                <a type="button" class="btn btn-primary" href="\gop\preventiva.php"><img src="\gop\images\voltar.png" alt="" width="30" height="30"> Voltar as opções</a>
            </div>
        </div>

    </div>


</body>



</html>