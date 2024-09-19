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
            <h5>Solicitações de Serviços<h5>
        </div>
    </div>

    <div class="container -my5">

        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Escolha o tipo da solicitação entre Recurso Fisico, Espaço Físico ou solicitação avulsa</h5>
        </div>
        <div style="padding-bottom:15px;">
                <a class="btn btn btn-sm" href="\gop\solicitacao.php"><img src="\gop\images\voltar.png" alt="" width="25" height="25"> Voltar</a>
            </div>

        <body class="sb-nav-fixed">
            <main>
                <hr>

                <div class="row mx-auto h-25" style="max-width: 750px;">
                    <div class="col-xl-4 col-md-6">
                        <div class="card  mb-6">
                            <img src="\gop\images\config.png" height="140px" class="card-img-top" alt="...">
                            <div class="card-body">Serviço em Recurso Físico</div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="\gop\solicitacao_nova_recurso_pesquisa.php" class="btn btn-primary">Clique aqui</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-4 col-md-6">
                        <div class="card mb-6">
                            <img src="\gop\images\apartamento.png" height="140px" class="card-img-top" alt="...">
                            <div class="card-body">Serviço em Espaço Físico</div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="\gop\solicitacao_nova_espaco_pesquisa.php" class="btn btn-primary">Clique aqui</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-4 col-md-6">
                        <div class="card mb-6">
                            <img src="\gop\images\ordem.png" height="140px" class="card-img-top" alt="...">
                            <div class="card-body">Solicitação de Serviço Avulsa</div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="solicitacao_conclusao.php" class="btn btn-primary">Clique aqui</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>

                </div>

            </main>
          
        </body>

    </div>


</body>



</html>