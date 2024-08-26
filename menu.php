 <?php
    // controle de acesso ao formulário
    session_start();
    if (!isset($_SESSION['newsession'])) {
        die('Acesso não autorizado!!!');
    }
    ?>
 <!DOCTYPE html>
 <html lang="en">

 <head>
     <title>GOP - Gestão Operacional</title>
     <meta charset="utf-8">
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
     <link rel="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css">
     <link rel="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css">
     <link href="https://nightly.datatables.net/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
     <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
     <link rel="stylesheet" href="css/style.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
     <link rel="shortcut icon" type="imagex/png" href="./images/smed_icon.ico">
     <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
     <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>

     <script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
     <script type="text/javascript" src="js/jquery.maskedinput-1.1.4.pack.js"></script>
     <script src="js/jquery.min.js"></script>
     <script src="js/popper.js"></script>
     <script src="js/bootstrap.min.js"></script>
     <script src="js/main.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

 </head>
 <!-- barra lateral com opções mais utilizadas -->
 <div class="container -my5">
     <div class="sidebar">
         <a href="#"></a>
         <a title='Solicitação de Serviçõ' href='#'><img src="\smedweb\images\paciente.png" alt="" width="30" height="30"></a>
         <a title='Ordem de Serviço' href='#'><img src="\smedweb\images\agenda.png" alt="" width="30" height="30"></a>
         <a title='Equipamentos' href='#'><img src="\smedweb\images\atestado.png" alt="" width="30" height="30"></a>
         <a title='Alterar Senha' href='#'><img src="\smedweb\images\trocasenha.png" alt="" width="30" height="30"></a>
         <a title='Sair do Sistema' href='#'><img src="\smedweb\images\saida.png" alt="" width="30" height="30"></a>
     </div>
 </div>

 <div class="container -my5">


     <body class="sb-nav-fixed">
         <main>
             <div class="panel">
                 <div class="panel-heading text-center text-info">
                     <br>
                     <h1><img Align="left" style="width:100px" class="img-responsive" src="\gop\imagens\img_gop.jpg">
                         <strong>Gestão Operacional</strong>
                     </h1>
                     <br>
                 </div>

             </div>
             <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-blue ftco-navbar-light" id="ftco-navbar">

                 <div class="navbar-header">
                     <br>
                     <a class="navbar-brand" href="#">Menu Inicial</a>
                 </div>
                 <ul class="navbar-nav ml-auto">

                     <li class="nav-item dropdown">
                         <!-- Opções de cadastro do menu -->
                         <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Cadastros</a>
                         <div class="dropdown-menu" aria-labelledby="dropdown01">

                             <a class="dropdown-item" href="/gop/recursos_lista.php"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> Recursos Fisicos</a>
                             <a class="dropdown-item" href="/gop/espacos_lista.php"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Espaços Fisicos</a>
                             <a class="dropdown-item" href=""><span class="" aria-hidden="true"></span> _____________________________</a>
                             <a class="dropdown-item" href="/gop/fornecedores_lista.php"><span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span> Fornecedores </a>
                             <a class="dropdown-item" href="/gop/fabricantes_lista.php"><span class="glyphicon glyphicon-certificate" aria-hidden="true"></span> Fabricantes</a>
                             <a class="dropdown-item" href="/gop/executores_lista.php"><span class="glyphicon glyphicon-play" aria-hidden="true"></span> Executores</a>
                             <a class="dropdown-item" href="/gop/centrodecusto_lista.php"><span class="glyphicon glyphicon-screenshot" aria-hidden="true"></span> Centros de Custos</a>
                             <a class="dropdown-item" href="/gop/oficinas_lista.php"><i class="material-icons">devices</i> Oficinas</a>
                             <a class="dropdown-item" href="/gop/setores_lista.php"><i class="material-icons">filter_list</i> Setores</a>
                             <a class="dropdown-item" href=""><span class="" aria-hidden="true"></span> _____________________________</a>
                             <a class="dropdown-item" href="/gop/materiais_lista.php"><i class="material-icons">devices_other</i> Materiais</a>
                             <a class="dropdown-item" href="/gop/ferramentas_lista.php"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Ferramentas</a>
                             <a class="dropdown-item" href="/gop/grupos_lista.php"><i class="fas fa-clone"></i> Grupos</a>
                             <a class="dropdown-item" href="/gop/marcas_lista.php"><i class="far fa-copyright"></i> Marcas</a>
                             <a class="dropdown-item" href="/gop/unidades_lista.php"><i class="fas fa-calculator"></i> Unidades e Medidas</a>
                             <a class="dropdown-item" href="/gop/funcoes_lista.php"><i class="glyphicon glyphicon-tags"></i> Funções e Cargos</a>
                             <a class="dropdown-item" href=""><span class="" aria-hidden="true"></span> _____________________________</a>
                             <a href="/gop/pops_lista.php"><i class="material-icons">assignment</i> Cadstro de POP</a>
                             <
                                 <a href="/gop/checklist_lista.php"><i class="material-icons">library_books</i> Cadastro de Cheklist</a>
                                 <a href="/gop/ocorrencias_lista.php"><i class="material-icons">question_answer</i> Ocorrências Padrões</a>
                                 <a class="dropdown-item" href=""><span class="" aria-hidden="true"></span> _____________________________</a>
                                 <a class="dropdown-item" href="/gop/usuarios_lista.php"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Usuários</a>
                                 <a class="dropdown-item" href="/gop/alterasenha.php"><span class="glyphicon glyphicon-transfer" aria-hidden="true"></span> Alterar Senha</a>


                         </div>
                     </li>

                     <li class="nav-item dropdown">
                         <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Solicitação de Serviços</a>

                         <div class="dropdown-menu" aria-labelledby="dropdown01">
                             <a class="dropdown-item" href=""><i class="fa fa-cogs"></i> Equipamentos</a>
                             <a class="dropdown-item" href=""><i class="far fa fa-building"></i> Instalações</a>

                         </div>

                     </li>

                     <li class="nav-item dropdown">
                         <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Ordens de Serviços</a>
                         <div class="dropdown-menu" aria-labelledby="dropdown01">
                             <a class="dropdown-item" href=""><i class="fa  fa-cogs"></i> Equipamentos</a>
                             <a class="dropdown-item" href=""><i class="far fa fa-building"></i> Instalações</a>

                         </div>

                     </li>

                     <li class="nav-item dropdown">
                         <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Preventivas</a>
                         <div class="dropdown-menu" aria-labelledby="dropdown01">
                             <a class="dropdown-item" href=""><i class="fa  fa-cogs"></i> Equipamentos</a>
                             <a class="dropdown-item" href=""><i class="far fa fa-building"></i> Instalações</a>

                         </div>

                     </li>
                     <li class="nav-item dropdown">
                         <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Almoxarifado</a>
                         <div class="dropdown-menu" aria-labelledby="dropdown01">
                             <a class="dropdown-item" href=""><i class="far fa-clipboard"></i> Cotações</a>
                             <a class="dropdown-item" href=""><i class="fas fa-cart-plus"></i> Compras Efetivas</a>
                             <a class="dropdown-item" href=""><i class="fas fa-boxes"></i> Dispensações</a>
                         </div>


                     </li>

                 </ul>


             </nav>

             <div class="container">

                 <div class="panel default class">

                     <div class="alert alert-success">
                         <?php
                            date_default_timezone_set('America/Sao_Paulo');
                            $agora = date('d/m/Y H:i');
                            ?>
                         <strong>Login efetuado! - </strong>Bem vindo <?php echo ' ' . $_SESSION['c_usuario'] . ' - ' . $agora . ' '; ?>
                         <label for="usuario"></label>
                     </div>
                 </div>

             </div>
         </main>


     </body>
 </div>

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
         font-size: 20px;
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