<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

//echo $c_sql_recurso;
include('links2.php');
include('conexao.php');

$i_id = $_GET['id'];
?>

<!-- Front end da página -->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<div class="content">

    <body>
        <div class="container ">
            <div style="padding-left:15px;">
                <div class="panel panel-primary class">
                    <div class="panel-heading text-center">
                        <h4>GOP - Gestão Operacional</h4>
                        <h5>Gerenciamento da Ordem de Serviço<h5>
                    </div>
                </div>
            </div>
            <div style="padding-left:15px;">

                <div class='alert alert-info' role='alert'>

                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
                    <h5>Clique na opção desejada das ações ou itens anexos a Ordem de serviço <?php echo $i_id; ?></h5>
                </div>
               
            </div>
        </div>

</div>
<!-- The sidebar -->
<div class="container -fluid">
    <div class="sidebar">
        <a href="#"></a>
        <a title='Abertura de Solicitação de Serviço' href='/gop/solicitacao.php'><img src="\gop\images\contato.png" alt="" width="30" height="30"><span></span></a>
        <a title='Ordens de Serviço' href='/gop/ordens.php'><img src='\gop\images\ordem.png' alt='' width='30' height='30'><span></span></a>
        <a title='Alterar Senha' href='\gop\alterasenha.php'><img src="\gop\images\trocasenha.png" alt="" width="30" height="30"><span></span></a>
        <a title='Sair do Sistema' href='\gop\index.php'><img src="\gop\images\saida.png" alt="" width="30" height="30"></a><span></span>
    </div>
</div>

</body>




</body>

</html>

<!-- CSS para as barras laterais -->
<style>
    /* Style the sidebar - fixed full height */
    .sidebar {
        height: 100%;
        width: 70px;
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
        font-size: 15px;
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
            font-size: 18px;
        }
    }
</style>