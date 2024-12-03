 <?php
    // controle de acesso ao formulário
    session_start();
    if (!isset($_SESSION['newsession'])) {
        die('Acesso não autorizado!!!');
    }
    include('conexao.php');
    $_SESSION['voltadiretriz'] = 'N';
    $_SESSION['consulta_solicitacao'] = "";
    $_SESSION['consulta_ordem'] = "";
    // verifico numero de solicitações em aberto
    $c_sql = "select COUNT(*) AS aberta_solicitacao FROM solicitacao WHERE STATUS = 'A'";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();
    $c_solicitacao_aberta = $registro['aberta_solicitacao'];
    $c_ordens_sla = 0;
    date_default_timezone_set('America/Sao_Paulo');
    $agora = date('d/m/Y H:i');
    $c_data = date('Y-m-d');

    $c_sql = "select COUNT(*) AS preventivas FROM preventivas WHERE data_prox_realizacao<='$c_data'";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();
    $c_preventivas = $registro['preventivas'];

    ?>
 <!DOCTYPE html>
 <html lang="en">

 <head>
     <title>GOP - Gestão Operacional</title>
     <meta charset="utf-8">
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <link rel="shortcut icon" type="imagex/png" href="./imagens/img_gop.ico">
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

 <div class="content">
     <main>
         <div class="container-fluid">

             <body class="sb-nav-fixed">

                 <div style="padding-top :2px;">
                     <div class="panel">
                         <div class="panel-heading text-center text-primary">
                             <br>
                             <h1><img Align="left" style="width:120px" class="img-responsive" src="\gop\imagens\img_gop.jpg">
                                 <strong>Gestão Operacional</strong>
                             </h1>

                         </div>
                     </div>
                 </div>

                 <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-blue ftco-navbar-light" id="ftco-navbar">
                     <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                         <span class="fa fa-bars">Menu</span>
                     </button>
                     <div class="collapse navbar-collapse" id="ftco-nav">
                         <div class="navbar-header">
                             <br>
                             <div style="padding-left:15px;">
                                 <!--<img Align="left" src="\gop\images\inicio.png" alt="" width="40" height="40">-->
                             </div>
                         </div>

                         <ul class="navbar-nav ml-auto">
                             <?php
                                if ($_SESSION['tipo'] <> 'Solicitante') {
                                    echo "<li class='nav-item dropdown'>
                             <!-- Opções de cadastro do menu -->
                             <a class='nav-link dropdown-toggle' href='#' id='dropdown01' data-toggle='dropdown' aria-haspopup= true' aria-expanded='false'>Cadastros</a>
                             <div class='dropdown-menu' aria-labelledby='dropdown01'>

                                 <a class='dropdown-item' href='/gop/cadastros/recursos/recursos_lista.php'><img src='\gop\images\config.png' alt='25' width='25' height='25'> Recursos Fisicos</a>
                                 <a class='dropdown-item' href='/gop/cadastros/espacos/espacos_lista.php'><img src='\gop\images\apartamento.png' alt='25' width='25' height='25'> Espaços Fisicos</a>
                                 
                                 <a class='dropdown-item' href='/gop/cadastros/fornecedores/fornecedores_lista.php'><img src='\gop\images\ofornecedor.png' alt='25' width='25' height='25'> Fornecedores </a>
                                 <a class='dropdown-item' href='/gop/cadastros/fabricantes/fabricantes_lista.php'><img src='\gop\images\ofabricante.png' alt='25' width='25' height='25'> Fabricantes</a>
                                 <a class='dropdown-item' href='/gop/cadastros/executores/executores_lista.php'><img src='\gop\images\operario.png' alt='25' width='25' height='25'> Executores</a>
                                 <a class='dropdown-item' href='/gop/cadastros/funcoes/funcoes_lista.php'><img src='\gop\images\profissao.png' alt='25' width='25' height='25'> Funções e Cargos</a>
                                 <a class='dropdown-item' href='/gop/cadastros/oficinas/oficinas_lista.php'><img src='\gop\images\oficina.png' alt='25' width='25' height='25'> Oficinas</a>
                                 <a class='dropdown-item' href='/gop/cadastros/centrodecustos/centrodecusto_lista.php'><img src='\gop\images\centrodecusto.png' alt='25' width='25' height='25'> Centros de Custos</a>
                                 <a class='dropdown-item' href='/gop/cadastros/setores/setores_lista.php'><img src='\gop\images\setores.png' alt='25' width='25' height='25'> Setores</a>
                                 <a class='dropdown-item' href='/gop/cadastros/ferramentas/ferramentas_lista.php'><img src='\gop\images\caixa_ferramentas.png' alt='25' width='25' height='25'> Ferramentas</a>
                                 <a class='dropdown-item' href='/gop/cadastros/tipos/tipos_lista.php'><img src='\gop\images\grupo.png' alt='25' width='25' height='25'> Tipos de Recurso</a>
                                 <a class='dropdown-item' href='/gop/cadastros/marcas/marcas_lista.php'><img src='\gop\images\marca.png' alt='25' width='25' height='25'> Marcas de Recursos</a>
                                                                 
                                 <a class='dropdown-item' href='/gop/cadastros/pop/pops_lista.php'><img src='\gop\images\degraus.png' alt='25' width='25' height='25'> Cadastro de POP</a>
                                 <a class='dropdown-item' href='/gop/cadastros/checklist/checklist_lista.php'><img src='\gop\images\checklist.png' alt='25' width='25' height='25'> Cadastro de Cheklist</a>
                                 
                             </div>
                         </li>";
                                }
                                ?>

                             <li class="nav-item dropdown">
                                 <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Serviços</a>
                                 <div class="dropdown-menu" aria-labelledby="dropdown01">
                                     <a class="dropdown-item" href="/gop/solicitacao/solicitacao.php"><img src="\gop\images\contato.png" alt="20" height="20"> Solicitações de Serviços</a>
                                     <?php
                                        if ($_SESSION['tipo'] <> 'Solicitante') {
                                            echo "<a class='dropdown-item' href='/gop/ordens/ordens.php'><img src='\gop\images\ordem.png' alt='25' width='25' height='25'> Ordens de Serviços</a>
                                  <a class='dropdown-item' href='/gop/preventivas/preventivas.php'><img src='\gop\images\preventivo.png' alt='25' width='25' height='25'> Preventivas </a>
                                  <a class='dropdown-item' href='/gop/cadastros/ocorrencias/ocorrencias_lista.php'><img src='\gop\images\incidente.png' alt='25' width='25' height='25'> Ocorrências Padrões</a>
                                  <a class='dropdown-item' href='/gop/plano_acao/planos_menu.php'><img src='\gop\images\plano.png' alt='25' width='25' height='25'> Planos de Ação</a>
                                  </div>
                         </li>

                         <li class='nav-item dropdown'>
                             <a class='nav-link dropdown-toggle' href='#' id='dropdown01' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>Almoxarifado</a>
                             <div class='dropdown-menu' aria-labelledby='dropdown01'>
                                 
                                 <a class='dropdown-item' href='/gop/almoxarifado/cotacao_lista.php'><img src='\gop\images\cotacao.png' alt='25' width='25' height='25'> Cadastro de Cotações</a>
                                 <a class='dropdown-item' href='/gop/almoxarifado/compras_lista.php'><img src='\gop\images\compras.png' alt='25' width='25' height='25'> Pedidos de Compra</a>
                                 <a class='dropdown-item' href='/gop/cadastros/materiais/materiais_lista.php'><img src='\gop\images\materiais.png' alt='25' width='25' height='25'>Cadastro de Materiais</a>
                                <a class='dropdown-item' href='/gop/cadastros/unidades/unidades_lista.php'><img src='\gop\images\grupomaterial.png' alt='25' width='25' height='25'> Grupos de Materiais</a>
                                 <a class='dropdown-item' href='/gop/cadastros/unidades/unidades_lista.php'><img src='\gop\images\peso.png' alt='25' width='25' height='25'> Unidades e Medidas</a>
                             </div>
                         </li>
                          <li class='nav-item dropdown'>
                             <a class='nav-link dropdown-toggle' href='#' id='dropdown01' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>Indicadores</a>
                             <div class='dropdown-menu' aria-labelledby='dropdown01'>
                                 <a class='dropdown-item' href='/gop/relatorios/ocorrencias_query.php'>1. Ocorrências Padrões</a>
                                 <a class='dropdown-item' href='/gop/relatorios/oficinas_query.php'>2. Ocorrências por Oficinas</a>
                                 <a class='dropdown-item' href='/gop/relatorios/solicitantes_query.php'>3. Ocorrências por Solicitantes</a>
                                 <a class='dropdown-item' href='/gop/relatorios/setores_query.php'>4. Ocorrências por Setor</a>
                                 <a class='dropdown-item' href='/gop/relatorios/centrodecusto_query.php'>5. Ocorrências por Centro de Custo</a>
                                 <a class='dropdown-item' href='/gop/relatorios/executores_query.php'>6. Horas Trabalhadas por Executor</a>
                                 <a class='dropdown-item' href='/gop/indicadores_mensais/ocorrencias_mensais_query.php'>7. Comparativo Mensal de Ocorrências Padrões</a>
                                 <a class='dropdown-item' href='/gop/indicadores_mensais/oficinas_mensais_query.php'>8. Comparativo Mensal por Oficina</a>
                                 <a class='dropdown-item' href='/gop/indicadores_mensais/solicitantes_mensais_query.php'>9. Comparativo Mensal por Solicitante</a>
                                 <a class='dropdown-item' href='/gop/indicadores_mensais/setores_mensais_query.php'>10. Comparativo Mensal por Setor</a>
                                 <a class='dropdown-item' href='/gop/indicadores_mensais/centrodecusto_mensais_query.php'>11. Comparativo Mensal por Centro de Custo</a>
                                 <a class='dropdown-item' href='/gop/indicadores_mensais/executores_mensais_query.php'>12. Comparativo Mensal de Horas por Executor</a>
                                 <a class='dropdown-item' href='#'>13. Indicadores da Manutenção</a>
                                
                             </div>
                         </li>
                           <li class='nav-item dropdown'>
                             <a class='nav-link dropdown-toggle' href='#' id='dropdown01' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>Custos da Manutenção</a>
                             <div class='dropdown-menu' aria-labelledby='dropdown01'>
                                 <a class='dropdown-item' href='/gop/custos/ocorrencias_custo_query.php'>1. Custos por Ocorrências Padrões</a>
                                 <a class='dropdown-item' href='/gop/custos/oficinas_custo_query.php'>2. Custos por Oficinas</a>
                                 <a class='dropdown-item' href='/gop/custos/solicitantes_custo_query.php'>3. Custos por Solicitantes</a> 
                                 <a class='dropdown-item' href='/gop/custos/setores_custo_query.php''>4. Custos por Setor</a>
                                 <a class='dropdown-item' href='/gop/custos/centrodecusto_custo_query.php'>5. Custos por Centro de Custo</a>
                                 <a class='dropdown-item' href='/gop/custos/executores_custos_query.php'>6. Custos por Executor</a>
                                 <a class='dropdown-item' href='/gop/custos_mensais/ocorrencias_custo_mensal_query.php'>7. Comparativo mensal de Custos por Ocorrências Padrões</a>
                                 <a class='dropdown-item' href='/gop/custos_mensais/oficinas_custo_mensal_query.php'>8. Comparativo mensal de Custos por Oficina</a>
                                 <a class='dropdown-item' href='/gop/custos_mensais/solicitantes_custo_mensal_query.php'>9. Comparativo mensal de Custos por Solicitante</a>
                                 <a class='dropdown-item' href='/gop/custos_mensais/setores_custo_mensal_query.php'>10. Comparativo mensal de Custos por Setor</a>
                                
                                
                             </div>
                         </li>";
                                            if ($_SESSION['tipo'] == 'Administrador')
                                                echo
                                                "<li class='nav-item'><a href='/gop/configuracoes.php' class='nav-link'>Configurações</a></li>
                        
                         ";
                                        }
                                        ?>
                             <li class='nav-item dropdown'>
                                 <a class='nav-link dropdown-toggle' href='#' id='dropdown01' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>Usuários</a>
                                 <div class='dropdown-menu' aria-labelledby='dropdown01'>
                                     <?php
                                        if ($_SESSION['tipo'] == 'Administrador') {
                                            echo "<a class='dropdown-item' href='/gop/cadastros/usuarios/usuarios_lista.php'><img src='\gop\images\usuario.png' alt='25' width='25' height='25'> Cadastro de Usuários</a>
                                 <a class='dropdown-item' href='/gop/cadastros/usuarios/usuarios_perfil_lista.php'><img src='\gop\images\perfil.png' alt='25' width='25' height='25'> Perfis de Usuários</a>";
                                        }
                                        ?>
                                     <a class='dropdown-item' href=''><img src='\gop\images\trocasenha.png' alt='25' width='25' height='25'>Troca de Senha</a>
                                 </div>
                             </li>

                         </ul>
                     </div>

                 </nav>

                 <div style="padding-bottom :1px;">
                     <div class="topnav">
                         <a href="#"></a>
                         <a title='Abertura de Solicitação de Serviço' href='/gop/solicitacao/solicitacao.php'><img src="\gop\images\contato.png" alt="" width="30" height="25"></a>
                         <?php
                            if ($_SESSION['tipo'] <> 'Solicitante') {
                                echo "<a title='Ordens de Serviço' href='/gop/ordens/ordens.php'><img src='\gop\images\ordem.png' alt='' width='30' height='25'></a>";
                                echo "<a title='Cadastro de Recursos Físicos' href='/gop/cadastros/recursos/recursos_lista.php'><img src='\gop\images\config.png' alt='' width='30' height='25'></a>";
                            }
                            ?>
                         <a title='Alterar Senha' href='\gop\alterasenha.php'><img src="\gop\images\trocasenha.png" alt="" width="30" height="25"></a>
                         <a title='Sair do Sistema' href='\gop\index.php'><img src="\gop\images\saida.png" alt="" width="30" height="25"></a>
                     </div>
                 </div>

                 <div class="panel default class">
                     <div class="alert alert-success">

                         <strong>Login efetuado! - </strong>Bem vindo <?php echo ' ' . $_SESSION['c_usuario'] . ' - ' . $agora . ' '; ?>
                         <label for="usuario"></label>
                     </div>
                 </div>
                 <br>
                 <div class="content">
                     <?php
                        if ($_SESSION['tipo'] <> 'Solicitante') {
                            require('cards_menu.php');
                        }
                        ?>
                 </div>

         </div>
         </body>

         <div style="padding-bottom:15px;">
             <footer>
                 <div style="padding-left :10px;">
                     <p>
                     <h4>GOP - Gestão Operacional - Todos os direitos reservados</h4>
                     </p>
                 </div>
             </footer>
         </div>

     </main>
 </div>




 </html>



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


 <!-- rodape do menu -->
 <style>
     html,
     body {
         min-height: 100%;
     }

     body {
         padding: 0;
         margin: 0;
     }

     footer {
         position: fixed;
         bottom: 0;
         background-color: #4682B4;
         color: #FFF;
         width: 100%;
         height: 45px;
         text-align: left;
         line-height: 70px;
     }
 </style>