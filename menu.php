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
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
     <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
     <script src="https://kit.fontawesome.com/yourcode.js"></script>
     <script src="https://kit.fontawesome.com/a076d05399.js"></script>
 </head>

 <body>
     <nav class="navbar navbar-light" style="background-color: #e3f2fd;">
         <div class="container-fluid">
             <div class="navbar-header">
                 <a class="navbar-brand" href="#">Menu Principal</a>
             </div>
             <ul class="nav navbar-nav">

                 <li class="dropdown">
                     <!-- Opções de cadastro do menu -->
                     <a class="dropdown-toggle" data-toggle="dropdown" href="#">Cadastros
                         <span class="caret"></span></a>
                     <ul class="dropdown-menu">
                         <li><a href="/gop/recursos_lista.php"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> Recursos Fisicos</a></li>
                         <li><a href="/gop/espacos_lista.php"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Espaços Fisicos</a></li>
                         <li><a href=""><span class="" aria-hidden="true"></span> _____________________________</a></li>
                         <li><a href="/gop/fornecedores_lista.php"><span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span> Fornecedores </a></li>
                         <li><a href="/gop/fabricantes_lista.php"><span class="glyphicon glyphicon-certificate" aria-hidden="true"></span> Fabricantes</a></li>
                         <li><a href="/gop/executores_lista.php"><span class="glyphicon glyphicon-play" aria-hidden="true"></span> Executores</a></li>
                         <li><a href="/gop/centrodecusto_lista.php"><span class="glyphicon glyphicon-screenshot" aria-hidden="true"></span> Centros de Custos</a></li>
                         <li><a href="/gop/oficinas_lista.php"><i class="material-icons">devices</i> Oficinas</a></li>
                         <li><a href="/gop/setores_lista.php"><i class="material-icons">filter_list</i> Setores</a></li>
                         <li><a href=""><span class="" aria-hidden="true"></span> _____________________________</a></li>
                         <li><a href="/gop/materiais_lista.php"><i class="material-icons">devices_other</i> Materiais</a></li>
                         <li><a href="/gop/ferramentas_lista.php"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Ferramentas</a></li>
                         <li><a href=""><span class="" aria-hidden="true"></span> _____________________________</a></li>
                         <li><a href="/gop/usuarios_lista.php"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Usuários</a></li>
                         <li><a href="/gop/alterasenha.php"><span class="glyphicon glyphicon-transfer" aria-hidden="true"></span> Alterar Senha</a></li>
                     </ul>
                 </li>
                 <li class="dropdown">
                     <!-- Opções de tabelas auxiliares do menu
		-->
                     <a class="dropdown-toggle" data-toggle="dropdown" href="#">Tabelas Auxiliares
                         <span class="caret"></span></a>
                     <ul class="dropdown-menu">
                         <li><a href="/gop/grupos_lista.php"><i class="fas fa-clone"></i> Grupos</a></li>
                         <li><a href="/gop/marcas_lista.php"><i class="far fa-copyright"></i> Marcas</a></li>
                         <li><a href="/gop/unidades_lista.php"><i class="fas fa-calculator"></i> Unidades e Medidas</a></li>
                         <li><a href="/gop/funcoes_lista.php"><i class="glyphicon glyphicon-tags"></i> Funções e Cargos</a></li>
                         <li><a href=""><i class="glyphicon glyphicon-cog"></i> Configurações</a></li>
                     </ul>
                 </li>
                 <li class="dropdown">
                     <!-- Opções de tabelas adiministrativas do menu
		-->
                     <a class="dropdown-toggle" data-toggle="dropdown" href="#">Tabelas Administrativas
                         <span class="caret"></span></a>
                     <ul class="dropdown-menu">
                         <li><a href="/gop/pops_lista.php"><i class="material-icons">assignment</i> Cadstro de POP</a></li>
                         <li><a href="/gop/checklist_lista.php"><i class="material-icons">library_books</i> Cadastro de Cheklist</a></li>
                         <li><a href="/gop/ocorrencias_lista.php"><i class="material-icons">question_answer</i> Ocorrências Padrões</a></li>
                     </ul>
                     <!-- Opções de Serviçoes do menu
		-->
                 </li>
                 <li class="dropdown">
                     <a class="dropdown-toggle" data-toggle="dropdown" href="#">Solicitação de Serviços
                         <span class="caret"></span></a>
                     <ul class="dropdown-menu">
                         <li><a href=""><i class="fa fa-cogs"></i> Equipamentos</a></li>
                         <li><a href=""><i class="far fa fa-building"></i> Instalações</a></li>

                     </ul>

                 </li>

                 <li class="dropdown">
                     <a class="dropdown-toggle" data-toggle="dropdown" href="#">Ordens de Serviços
                         <span class="caret"></span></a>
                     <ul class="dropdown-menu">
                         <li><a href=""><i class="fa  fa-cogs"></i> Equipamentos</a></li>
                         <li><a href=""><i class="far fa fa-building"></i> Instalações</a></li>

                     </ul>

                 </li>

                 <li class="dropdown">
                     <a class="dropdown-toggle" data-toggle="dropdown" href="#">Preventivas
                         <span class="caret"></span></a>
                     <ul class="dropdown-menu">
                         <li><a href=""><i class="fa fa-cogs"></i> Equipamentos</a></li>
                         <li><a href=""><i class="far fa fa-building"></i> Instalações</a></li>

                     </ul>

                 </li>
                 <li class="dropdown">
                     <a class="dropdown-toggle" data-toggle="dropdown" href="#">Almoxarifado
                         <span class="caret"></span></a>
                     <ul class="dropdown-menu">
                         <li><a href=""><i class="far fa-clipboard"></i> Cotações</a></li>
                         <li><a href=""><i class="fas fa-cart-plus"></i> Compras Efetivas</a></li>
                         <li><a href=""><i class="fas fa-boxes"></i> Dispensações</a></li>
                     </ul>


                 </li>
                 <li class="active"><a href="/gop/index.php"><span class="glyphicon glyphicon-log-out" aria-hidden="true"> Sair</a></li>
             </ul>

         </div>
     </nav>

     <div class="container">

         <div class="panel default class">
             <div class="panel-heading">
                 <img class="img-responsive" src="\gop\imagens\img_gop.jpg" style="width:100px">
                 <br>
             </div>
             <div class="alert alert-success">
                 <strong>Login efetuado! - </strong>Bem vindo <?php echo ' ' . $_SESSION['c_usuario']; ?>
                 <label for="usuario"></label>
             </div>
         </div>

     </div>



 </body>

 </html>