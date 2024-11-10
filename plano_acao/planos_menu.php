<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
date_default_timezone_set('America/Sao_Paulo');

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
            <h5>Itens de Planos de Ação<h5>
        </div>
    </div>
    <div class="content">

        <div class="container -my5">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

                </div>
                <h5><?php $_SESSION['c_usuario'] ?>Selecione a opção abaixo desejada do plano de Ação</div>
            <form method="post">
                <div style="padding-top:5px;padding-bottom:5px">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <a class="btn btn btn-sm" href='/gop/plano_acao/diretriz_lista.php'><img src='\gop\images\diretrizes.png' alt='25' width='25' height='25'> Diretrizes</a>
                            <a class="btn btn btn-sm" href='/gop/plano_acao/estrategias_lista.php'><img src='\gop\images\iconeestrategia.png' alt='25' width='25' height='25'> Estratégias</a>
                            <a class="btn btn btn-sm" href='/gop/plano_acao/planejamento_lista.php'><img src='\gop\images\planejamento.png' alt='25' width='25' height='25'> Planejamento</a>
                            <a class="btn btn btn-sm" href="\gop\menu.php"><img src="\gop\images\saida.png" alt="" width="25" height="25"> Voltar</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>



</body>

</html>