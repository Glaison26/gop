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
// session para pegar valor da hora do executor
$_SESSION['nome_executor'] = "";
$_SESSION['valor_executor'] = "";
// session para pegar valor de custo do material na OS
$_SESSION['nome_material'] = "";
$_SESSION['valor_material'] = "";
//
$_SESSION['nome_prestador'] = "";
$_SESSION['valor_prestador'] = "";
$_SESSION['unidade_material'] = "";
// sql para pegar dados da ordem de serviço
$c_sql_ordem = "select status, id_ocorrencia, descritivo, descricao from ordens where id='$i_id'";
$result = $conection->query($c_sql_ordem);
$c_linha_ordem = $result->fetch_assoc();
$_SESSION['id_ocorrencia'] = $c_linha_ordem['id_ocorrencia'];
// capturo o numero de executores na ordem de serviço para mostrar na aba de executores
$c_sql = "SELECT COUNT(*) AS total_executores FROM ordens_executores WHERE id_ordem='$i_id'";
$result_executores = $conection->query($c_sql); 
$registro_executores = $result_executores->fetch_assoc();
$total_executores = $registro_executores['total_executores'];
// capturo o numero de prestadores de serviço na ordem de serviço para mostrar na aba de prestadores
$c_sql = "SELECT COUNT(*) AS total_prestadores FROM ordens_prestadores WHERE id_ordem='$i_id'";
$result_prestadores = $conection->query($c_sql);
$registro_prestadores = $result_prestadores->fetch_assoc();
$total_prestadores = $registro_prestadores['total_prestadores'];
// capturo o numero de materiais na ordem de serviço para mostrar na aba de materiais
$c_sql = "SELECT COUNT(*) AS total_materiais FROM ordens_materiais WHERE id_ordem='$i_id'";
$result_materiais = $conection->query($c_sql);
$registro_materiais = $result_materiais->fetch_assoc();
$total_materiais = $registro_materiais['total_materiais'];
// capturo o numero de imagens na ordem de serviço para mostrar na aba de imagens
$c_sql = "SELECT COUNT(*) AS total_imagens FROM ordens_imagens WHERE id_ordem='$i_id'";
$result_imagens = $conection->query($c_sql);
$registro_imagens = $result_imagens->fetch_assoc();
$total_imagens = $registro_imagens['total_imagens'];
// capturo o numero de checklists na ordem de serviço para mostrar na aba de checklists
$c_sql = "SELECT COUNT(*) AS total_checklists FROM ordens_check WHERE id_ordem='$i_id'";
$result_checklists = $conection->query($c_sql);
$registro_checklists = $result_checklists->fetch_assoc();
$total_checklists = $registro_checklists['total_checklists'];
// capturo o numero de POPs na ordem de serviço para mostrar na aba de POPs
$c_sql = "SELECT COUNT(*) AS total_pops FROM ordens_pop WHERE id_ordem='$i_id'";
$result_pops = $conection->query($c_sql);
$registro_pops = $result_pops->fetch_assoc();
$total_pops = $registro_pops['total_pops'];
// capturo o numero de ferramentas na ordem de serviço para mostrar na aba de ferramentas
$c_sql = "SELECT COUNT(*) AS total_ferramentas FROM ordens_ferramentas WHERE id_ordem='$i_id'";
$result_ferramentas = $conection->query($c_sql);
$registro_ferramentas = $result_ferramentas->fetch_assoc();
$total_ferramentas = $registro_ferramentas['total_ferramentas'];
// cpturo o numero de itens no plano de ação da ordem de serviço para mostrar na aba de plano de ação
$c_sql = "SELECT COUNT(*) AS total_plano FROM ordens_plano WHERE id_ordem='$i_id'";
$result_plano = $conection->query($c_sql);
$registro_plano = $result_plano->fetch_assoc();
$total_plano = $registro_plano['total_plano'];
// capturo o numero de suspensões na ordem de serviço para mostrar na aba de suspensões
$c_sql = "SELECT COUNT(*) AS total_suspensoes FROM ordens_suspensao WHERE id_ordem='$i_id'";
$result_suspensoes = $conection->query($c_sql);
$registro_suspensoes = $result_suspensoes->fetch_assoc();
$total_suspensoes = $registro_suspensoes['total_suspensoes'];







?>

<!-- Front end da página -->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GOP - Gerenciamento de Ordens de Serviço</title>
    <link rel="stylesheet" href="/gop/css/basico.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

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

                <!-- botões de ação da ordem de serviço -->
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="btn-group" role="group">
                            <div style="padding-bottom :2px;">
                                <a class='btn btn btn-sm' href='/gop/ordens/ordens_emissao.php?id=<?php echo $i_id ?>' target='_blank'>
                                    <img src="\gop\images\printer.png" alt="" width="25" height="25"> Emitir</a>
                                    
                                <?php if ($c_linha_ordem['status'] == 'C' || $c_linha_ordem['status'] == 'S' || $c_linha_ordem['status'] == 'X') { ?>
                                    <a class='btn btn btn-sm' title='Visualizar Ordem de serviço' href='\gop\ordens\ordens_editar.php?id=<?php echo $i_id ?>'><img src='\gop\images\visualizar.png' alt='' width='30' height='20'><span> Visualizar</span></a>
                                <?php } else { ?>
                                    <a class='btn btn btn-sm' title='Editar Ordem de serviço' href='\gop\ordens\ordens_editar.php?id=<?php echo $i_id ?>'><img src='\gop\images\xxxescrever.png' alt='' width='30' height='20'><span> Editar</span></a>
                                <?php } ?>
                                <?php
                                // cabeçalho do gerenciar
                                if ($c_linha_ordem['status'] <> 'C' && $c_linha_ordem['status'] <> 'S' && $c_linha_ordem['status'] <> 'X') {
                                    echo " 
                            <a class='btn btn btn-sm' title='Concluir Ordem de Serviço' href='\gop\ordens\ordens_conclusao.php?id=<?php echo $i_id ?>'><img src='\gop\images\concluir.png' alt='' width='30' height='25'><span> Concluir</span></a>
                            <a class='btn btn btn-sm' title='Suspender Ordem de Serviço' href='\gop\ordens\ordens_suspender.php?id=<?php echo $i_id ?>'><img src='\gop\images\pausa.png' alt='' width='25' height='20'><span> Suspender</span></a>
                            <a class='btn btn btn-sm' title='Cancelar Ordem de Serviço' href='\gop\ordens\ordens_cancelar.php?id=<?php echo $i_id ?>'><img src='\gop\images\cancelar.png' alt='' width='25' height='20'><span> Cancelar</span></a>";
                                }
                                if ($c_linha_ordem['status'] == 'S')
                                    echo "<a class='btn btn btn-sm' title='Tirar Suspensão' href='\gop\ordens\ordens_tirar_suspensao.php?id=<?php echo $i_id ?>'><img src='\gop\images\undo.png' alt='' width='20' height='20'><span> Tirar Suspensão</span></a>";
                                ?>

                                <a class='btn btn btn-sm' title='Voltar' href='\gop\ordens\ordens_lista.php'><img src="\gop\images\saida.png" alt="" width="30" height="20"><span> Voltar</span></a>


                            </div>
                        </div>
                    </div>
                </div>
                <!-- painel com o número da ordem de serviço -->
                <hr>
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h4>Ordem de Serviço Nº <?php echo $i_id ?> - <?php echo $c_linha_ordem['descritivo'] ?></h4>
                    </div>
                </div>
                <hr>

                <!-- abas de itens de os -->
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#descricao" aria-controls="descricao" role="tab" data-toggle="tab">Descrição do Serviço</a></li>
                    <li role="presentation"><a href="#executores" aria-controls="executores" role="tab" data-toggle="tab">Executores <span class="badge"><?php echo $total_executores; ?></span></a></li>
                    <li role="presentation"><a href="#prestadores" aria-controls="prestadores" role="tab" data-toggle="tab">Prestadores de Serviço <span class="badge"><?php echo $total_prestadores; ?></span></a></li>
                    <li role="presentation"><a href="#materiais" aria-controls="materiais" role="tab" data-toggle="tab">Materiais Gastos <span class="badge"><?php echo $total_materiais; ?></span></a></li>
                    <li role="presentation"><a href="#susp" aria-controls="susp" role="tab" data-toggle="tab">Suspensões</a></li>
                    <li role="presentation"><a href="#checklist" aria-controls="checklist" role="tab" data-toggle="tab">Check Lists <span class="badge"><?php echo $total_checklists; ?></span></a></li>
                    <li role="presentation"><a href="#abapop" aria-controls="abapop" role="tab" data-toggle="tab">Procedimentos Operacionais Padrões <span class="badge"><?php echo $total_pops; ?></span></a></li>
                    <li role="presentation"><a href="#imagens" aria-controls="imagens" role="tab" data-toggle="tab">Imagens <span class="badge"><?php echo $total_imagens; ?></span></a></li>
                    <li role="presentation"><a href="#ferramenta" aria-controls="ferramenta" role="tab" data-toggle="tab">Ferramentas <span class="badge"><?php echo $total_ferramentas; ?></span></a></li>
                    <li role="presentation"><a href="#plano" aria-controls="plano" role="tab" data-toggle="tab">Plano de Ação <span class="badge"><?php echo $total_plano; ?></span></a></li>
                </ul>
                <div class="tab-content">
                    <!-- aba com descrição do serviço -->
                    <div role="tabpanel" class="tab-pane active" id="descricao">
                        <div style="padding-top:15px;padding-left:20px;">
                            <?php include('ordens_descricao.php'); ?>

                        </div>
                    </div>
                    <!-- aba da materiais gastos-->
                    <div role="tabpanel" class="tab-pane" id="materiais">
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
                    <!-- aba de prestadores de serviço-->
                    <div role="tabpanel" class="tab-pane" id="prestadores">
                        <div style="padding-top:15px;padding-left:20px;">
                            <?php include('ordens_prestadores.php') ?>
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
                    <!-- aba da materiais imagens-->
                    <div role="tabpanel" class="tab-pane" id="imagens">
                        <div style="padding-top:15px;padding-left:20px;">
                            <?php include('ordens_imagens.php'); ?>

                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="susp">
                        <div style="padding-top:15px;padding-left:20px;">
                            <?php include('ordens_suspensoes_historico.php'); ?>

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