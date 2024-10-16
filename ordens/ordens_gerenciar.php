<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

//echo $c_sql_recurso;
include('../links.php');
include('../conexao.php');
if (isset($_GET['id'])) {
    $i_id = $_GET['id'];
    $_SESSION['id_ordem'] = $i_id;
} else {
    $i_id = $_SESSION['id_ordem'];
}
$c_sql_ordem = "select status from ordens where id='$i_id'";
$result = $conection->query($c_sql_ordem);
$c_linha_ordem = $result->fetch_assoc();


?>

<!-- Front end da página -->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>


<body>
    <div class="content">
        <div class="container-fluid">
            <div style="padding-top :20px;">
                <div class="panel panel-primary class">
                    <div class="panel-heading text-center">
                        <h4>GOP - Gestão Operacional</h4>
                        <h5>Gerenciamento da Ordem de Serviço<h5>
                    </div>
                </div>
                <div>
                    <div style="padding-bottom :2px;">
                        <div class="topnav">
                                                     
                            <a title='Concluir Ordem de Serviço' href='\gop\ordens\ordens_conclusao.php?id=<?php echo $i_id ?>'><img src="\gop\images\concluir.png" alt="" width="30" height="25"><span> Concluir</span></a>
                            <a title='Suspender Ordem de Serviço' href='#'><img src='\gop\images\aguardado.png' alt='' width='30' height='25'><span> Suspender</span></a>
                            <a title='Cancelar Ordem de Serviço' href='#'><img src="\gop\images\cancelar.png" alt="" width="30" height="25"><span> Cancelar</span></a>
                            <a title='Voltar' href='\gop\ordens\ordens_lista.php'><img src="\gop\images\saida.png" alt="" width="30" height="25"><span> Voltar</span></a>
                        </div>
                    </div>
                    <br>
                    <div class='alert alert-info' role='alert'>
                        <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
                        <h5>Clique na opção desejada das ações ou itens anexos a Ordem de serviço <?php echo $i_id; ?></h5>
                    </div>
                    <!-- abas de itens de os -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#materiais" aria-controls="materiais" role="tab" data-toggle="tab">Materiais Gastos</a></li>
                        <li role="presentation"><a href="#executores" aria-controls="executores" role="tab" data-toggle="tab">Executores</a></li>
                        <li role="presentation"><a href="#abapop" aria-controls="abapop" role="tab" data-toggle="tab">POP</a></li>
                        <li role="presentation"><a href="#checklist" aria-controls="checklist" role="tab" data-toggle="tab">Check Lists</a></li>
                        <li role="presentation"><a href="#plano" aria-controls="plano" role="tab" data-toggle="tab">Plano de Ação</a></li>
                        <li role="presentation"><a href="#ferramenta" aria-controls="ferramenta" role="tab" data-toggle="tab">Ferramentas</a></li>
                        <li role="presentation"><a href="#imagens" aria-controls="imagens" role="tab" data-toggle="tab">Imagens</a></li>

                    </ul>
                    <div class="tab-content">
                        <!-- aba da materiais gastos-->
                        <div role="tabpanel" class="tab-pane active" id="materiais">
                            <div style="padding-top:15px;padding-left:20px;">
                                <?php include('ordens_materiais.php'); ?>

                            </div>
                        </div>
                        <!-- aba de executores-->
                        <div role="tabpanel" class="tab-pane" id="executores">
                            <div style="padding-top:15px;padding-left:20px;">
                                <?php include('ordens_executores.php') ?>
                            </div>
                        </div>
                        <!-- aba de POP-->
                        <div role="tabpanel" class="tab-pane" id="abapop">
                            <div style="padding-top:15px;padding-left:20px;">
                                <?php include('ordens_pop.php'); ?>
                            </div>
                        </div>
                        <!-- aba de checklist-->
                        <div role="tabpanel" class="tab-pane" id="checklist">
                            <div style="padding-top:15px;padding-left:20px;">
                                <?php include('ordens_check.php'); ?>
                            </div>
                        </div>
                        <!-- aba de plano de ação-->
                        <div role="tabpanel" class="tab-pane" id="plano">
                            <div style="padding-top:15px;padding-left:20px;">
                                <?php include('ordens_plano.php') ?>
                            </div>
                        </div>
                        <!-- aba de plano de ação-->
                        <div role="tabpanel" class="tab-pane" id="ferramenta">
                            <div style="padding-top:15px;padding-left:20px;">
                                <?php include('ordens_ferramentas.php');
                                ?>
                            </div>
                        </div>
                        <!-- aba de imagens da ordem de serviço -->
                        <!-- aba da materiais gastos-->
                        <div role="tabpanel" class="tab-pane" id="imagens">
                            <div style="padding-top:15px;padding-left:20px;">
                                <?php include('ordens_imagens.php'); ?>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</body>




</html>

<!-- CSS para as barras laterais -->
<style>
    /* Style the sidebar - fixed full height */
    .sidebar {
        height: 100%;
        width: 110px;
        position: fixed;
        z-index: 1;
        top: 0;
        left: 0;
        background-color: #4682B4;
        overflow-x: hidden;
        padding-top: 16px;
    }

    /* Style sidebar links */
    .sidebar a {
        padding: 6px 8px 6px 16px;
        text-decoration: none;
        font-size: 12px;
        color: #F5F5F5;
        display: block;
    }

    /* Style links on mouse-over */
    .sidebar a:hover {
        color: #f1f1f1;
    }

    /* Style the main content */
    .main {
        margin-left: 160px;
        /* Same as the width of the sidenav */
        padding: 0px 10px;
    }

    /* Add media queries for small screens (when the height of the screen is less than 450px, add a smaller padding and font-size) */
    @media screen and (max-height: 450px) {
        .sidebar {
            padding-top: 15px;
        }

        .sidebar a {
            font-size: 12px;
        }
    }
</style>

<style>
    /* Add a black background color to the top navigation */
    .topnav {
        background-color: #4682B4;
        overflow: hidden;
    }

    /* Style the links inside the navigation bar */
    .topnav a {
        float: left;
        color: #f2f2f2;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
        font-size: 17px;
    }

    /* Change the color of links on hover */
    .topnav a:hover {
        background-color: #4682B4;
        color: black;
    }

    /* Add a color to the active/current link */
    .topnav a.active {
        background-color: #4682B4;
        color: white;
    }
</style>