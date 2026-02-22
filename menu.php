<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include('conexao.php');

date_default_timezone_set('America/Sao_Paulo');
$agora = date('d/m/Y H:i');
$c_data = date('Y-m-d');
//
$_SESSION['voltadiretriz'] = 'N';
$_SESSION['consulta_solicitacao'] = "";
$_SESSION['consulta_ordem'] = "";
$_SESSION['consulta_resumo'] = "S";
$_SESSION['checa_preventiva'] = "N";
// verifico numero de solicitações em aberto
$c_sql = "select COUNT(*) AS aberta_solicitacao FROM solicitacao WHERE STATUS = 'A'";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
$c_solicitacao_aberta = $registro['aberta_solicitacao'];
$c_ordens_sla = 0;
//verifoco numero de preventivas a serem geradas
$c_sql = "select COUNT(*) AS preventivas FROM preventivas WHERE data_prox_realizacao<='$c_data'";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
$c_preventivas = $registro['preventivas'];
// verifico Ordens de serviço com o SLA em atraso
$c_sql = "select COUNT(*) AS sla FROM ordens WHERE ((data_previsao < '$c_data' AND ordens.`status`='A') OR (data_previsao = '$c_data' AND hora_previsao <= CURTIME() AND ordens.`status`='A'))";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
$c_ordens_sla = $registro['sla'];
// verifico ordens de serviço que encontran-se em aberto
$c_sql = "select COUNT(*) AS abertas FROM ordens WHERE  ordens.`status`='A'";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
$c_ordens_abertas = $registro['abertas'];
// verifico ordens de servico que encontran-se suspensas
$c_sql = "select COUNT(*) as suspensas from ordens where ordens.status='S'";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
$c_ordens_suspensas = $registro['suspensas'];
// verifico ordens preventiva geradas no dia
// pegar ordens geradas
//$c_data = date('Y/m/d');

$c_sql =    "SELECT count(*) as preventivas_geradas FROM ordens
                 WHERE ordens.data_geracao='$c_data' and tipo_ordem='P'";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
$c_preventivas_geradas = $registro['preventivas_geradas'];
// marcados para ver ordem na agenda de executores
$_SESSION['ver_os'] = false;
?>




<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestão de Manutenção</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="shortcut icon" type="imagex/png" href="./imagens/img_gop.ico">
    <style>
        .dropdown:hover .dropdown-menu {
            display: block;
        }
    </style>
</head>


<body class="bg-gray-100 font-sans leading-normal tracking-normal">

    <!-- Navbar resposiva -->
    <nav class="bg-blue-800 p-4 shadow-lg" responsive-navbar>

        <br>
        <div class="container mx-auto flex items-center justify-between">

            <div class="text-white font-bold text-xl">
                <i class="fas fa-tools mr-2"></i>GOP - Gestão Operacional
            </div>

            <div class="hidden md:flex items-center space-x-6">


                <!-- Dropdown Cadastro -->
                <?php
                if ($_SESSION['tipo'] <> 'Solicitante') {
                    echo '
                <div class="relative dropdown">
                    <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                        Cadastros  <i class="fas fa-chevron-down ml-1 text-xs"></i>
                    </button>
                    <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow-xl rounded-md w-48 z-50">
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/recursos/recursos_lista.php">Recursos Fisicos</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/espacos/espacos_lista.php">Espaços Fisicos</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/grupos_fornecedor/grupos_fornecedor_lista.php">Grupos de Fornecedores</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/fornecedores/fornecedores_lista.php">Fornecedores</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/fabricantes/fabricantes_lista.php">Fabricantes</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/executores/executores_lista.php">Executores Internos</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/prestadores/prestadores_lista.php">Prestadores de Serviço</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/funcoes/funcoes_lista.php">Funções e Cargos</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/oficinas/oficinas_lista.php">Oficinas</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/centrodecustos/centrodecusto_lista.php">Centros de Custos</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/setores/setores_lista.php">Setores</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/ferramentas/ferramentas_lista.php">Ferramentas</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/tipos/tipos_lista.php">Tipos de Recurso</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/marcas/marcas_lista.php">Marcas de Recursos</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/checklist/checklist_lista.php">Cadastro de Cheklist</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/unidades/unidades_lista.php">Unidades e Medidas</a> 
                    </div>
                </div>';
                }
                ?>

                <!-- Dropdown Solicitações -->
                <?php
                if ($_SESSION['tipo'] <> 'Solicitante') {
                    echo '
                <div class="relative dropdown">
                    <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                        Serviços <i class="fas fa-chevron-down ml-1 text-xs"></i>
                    </button>
                    <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow-xl rounded-md w-48 z-50">
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/solicitacao/solicitacao.php">Solicitações de Serviço</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/ordens/ordens.php">Ordens de Serviço</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/preventivas/preventivas.php">Cadastro de preventivas</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/agenda/agenda.php">Agenda de Executores</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/ocorrencias/ocorrencias_lista.php">Ocorrências Padrões de Serviço</a>
                   
                    </div>
                </div>';
                } else {
                    echo '
                    <div class="relative dropdown">
                    <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                        Serviços <i class="fas fa-chevron-down ml-1 text-xs"></i>
                    </button>
                    <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow-xl rounded-md w-48 z-50">
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/solicitacao/solicitacao.php">Solicitações</a>
                    </div>
                </div>';
                }
                ?>
                <!-- Dropdown Almoxarifados  -->
                <?php
                if ($_SESSION['tipo'] <> 'Solicitante') {
                    echo '
                <div class="relative dropdown">
                    <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                        Almoxarifado <i class="fas fa-chevron-down ml-1 text-xs"></i>
                    </button>
                    <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow-xl rounded-md w-48 z-50">
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/almoxarifado/cotacao_lista.php">Cotações de Compras</a>
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/almoxarifado/compras_lista.php">Pedidos de Compras</a>
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/materiais/materiais_lista.php">Cadastro de Materiais</a>
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/grupos/grupos_lista.php">Grupos de Materiais</a>
                        
                    </div>
                </div>';
                }
                ?>
                <!-- dropdown outros aplicativos -->
                <?php
                if ($_SESSION['tipo'] <> 'Solicitante') {
                    echo '
                    <div class="relative dropdown">
                    <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                        Outros Aplicativos <i class="fas fa-chevron-down ml-1 text-xs"></i>
                    </button>
                    <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow-xl rounded-md w-48 z-50">
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/plano_acao/planos_menu.php">Planos de Ação</a>
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/pop/pops_lista.php">Cadastro de Procedimentos Operacionais Padrões</a>
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/obras/obras_menu.php">Custos de Obras</a>
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/contratos/contratos_lista.php">Gestão de Contratos</a>

                    </div>
                </div>';
                }
                ?>
                <!-- Dropdown Indicadores Quantitativos -->
                <?php
                if ($_SESSION['tipo'] <> 'Solicitante') {
                    echo '
                    <div class="relative dropdown">
                        <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                            Indicadores <i class="fas fa-chevron-down ml-1 text-xs"></i>
                        </button>
                        <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow-xl rounded-md w-48 z-50">
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/relatorios/ocorrencias_query.php">Ocorrências Padrões</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/relatorios/oficinas_query.php">Ocorrências por Oficinas</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/relatorios/solicitantes_query.php">Ocorrências por Solicitantes</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/relatorios/setores_query.php">Ocorrências por Setor</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/relatorios/centrodecusto_query.php">Ocorrências por Centro de Custo</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/relatorios/executores_query.php">Horas Trabalhadas por Executor</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/indicadores_mensais/ocorrencias_mensais_query.php">Comparativo Mensal de Ocorrências Padrões</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/indicadores_mensais/oficinas_mensais_query.php">Comparativo Mensal por Oficina</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/indicadores_mensais/solicitantes_mensais_query.php">Comparativo Mensal por Solicitante</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/indicadores_mensais/setores_mensais_query.php">Comparativo Mensal por Setor</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/indicadores_mensais/centrodecusto_mensais_query.php">Comparativo Mensal por Centro de Custo</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/indicadores_mensais/executores_mensais_query.php">Comparativo Mensal de Horas por Executor</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/indicadores_mensais/indicadores_manutencao_query.php">Indicadores da Manutenção</a>
                        </div>
                      </div>';
                }
                ?>

                <!-- indicadores de custos -->
                <?php
                if ($_SESSION['tipo'] <> 'Solicitante') {
                    echo '
                    <div class="relative dropdown">
                        <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                            Indicadores de Custos <i class="fas fa-chevron-down ml-1 text-xs"></i>
                        </button>
                        <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow-xl rounded-md w-48 z-50">
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/custos/centrodecusto_custo_geral_query.php">Custo Geral de Manutenção por Período</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/custos/ocorrencias_custo_query.php">Custos por Ocorrências Padrões</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/custos/oficinas_custo_query.php">Custos por Oficinas</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/custos/solicitantes_custo_query.php">Custos por Solicitantes</a> 
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/custos/setores_custo_query.php">Custos por Setor</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/custos/centrodecusto_custo_query.php">Custos por Centro de Custo</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/custos/executores_custos_query.php">Custos por Executor</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/custos_mensais/ocorrencias_custo_mensal_query.php">Comparativo mensal de Custos por Ocorrências Padrões</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/custos_mensais/oficinas_custo_mensal_query.php">Comparativo mensal de Custos por Oficina</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/custos_mensais/solicitantes_custo_mensal_query.php">Comparativo mensal de Custos por Solicitante</a>
                                 <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/custos_mensais/setores_custo_mensal_query.php">Comparativo mensal de Custos por Setor</a>
                                 
                        </div>
                    </div>';
                }
                ?>
                <!-- configurações -->
                <?php
                if ($_SESSION['tipo'] == 'Administrador') {
                    echo '
                <div class="relative dropdown">
                    <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                        Configurações <i class="fas fa-chevron-down ml-1 text-xs"></i>  
                    </button>
                    <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow
                    rounded-md w-48 z-50">
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/usuarios/usuarios_lista.php">Usuários do Sistema</a>
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/usuarios/usuarios_perfil_lista.php">Perfis de Acesso</a>
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/configuracoes.php">Parâmetros do Sistema</a>
                    </div>
                </div>';
                }
                ?>
                <!-- User Profile -->
                <div class="relative dropdown">
                    <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                        <i class="fas fa-user-circle text-2xl"></i>
                    </button>
                    <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow-xl rounded-md w-48 z-50 right-0">
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/alterasenha.php">Alterar Senha</a>
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/index.php">Sair</a>

                    </div>
                    <div class="md:hidden">
                        <button class="text-white focus:outline-none">
                            <i class="fas fa-bars text-2xl"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!--painel de boas vindas com data e hora e nome do usuário -->
        <br>
        <div class="container mx-auto mt-2 text-white">
            <p>Bem-vindo, <span class="font-bold"><?php echo $_SESSION['c_usuario']; ?></span>! Hoje é <?php echo date('d/m/Y'); ?>, <?php echo date('H:i'); ?> horas.</p>
        </div>
    </nav>
    <!-- subnav barra de navegação secundária com atalhos de solicitações e ordens -->
    <div class="bg-blue-700 p-2 shadow-md">
        <div class="container mx-auto flex items-center space-x-4">
            <a href="/gop/solicitacao/solicitacao.php" class="text-white hover:text-blue-200 transition flex items-center">
                <i class="fas fa-file-alt mr-2"></i> Solicitação de Serviço
            </a>
            <?php

            if ($_SESSION['tipo'] <> 'Solicitante') {
                echo '<a href="/gop/ordens/ordens.php" class="text-white hover:text-blue-200 transition flex items-center">
                <i class="fas fa-clipboard-list mr-2"></i> Ordem de Serviço
            </a>
            <a href="/gop/preventivas/preventivas.php" class="text-white hover:text-blue-200 transition flex items-center">
                <i class="fas fa-calendar-check mr-2"></i> Preventivas
            </a>';
            }
            ?>

        </div>
        <!-- end subnav barra de navegação secundária com atalhos de solicitações e ordens -->

    </div>
    <!-- Main Content cards -->
    <?php
    if ($_SESSION['tipo'] <> 'Solicitante') {
        echo '
    <main class="container mx-auto mt-10 px-4">
        <header class="mb-8">
            <h1 class="text-3xl font-bold text-gray-800">Painel de Controle</h1>
            <p class="text-gray-600">Visão geral das atividades pendentes</p>
        </header>

        <!-- Dashboard Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

            <!-- Card Solicitações Abertas -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden border-l-4 border-yellow-500 hover:shadow-lg transition">
                <div class="p-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-500 uppercase tracking-wider">Solicitações Abertas</p>
                            <p class="text-3xl font-bold text-gray-900 mt-1">' . $c_solicitacao_aberta . '<p>
                        </div>
                        <div class="bg-yellow-100 p-3 rounded-full">
                            <i class="fas fa-file-alt text-yellow-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="/gop/chama_solicitacoes_menu.php" class="text-yellow-600 hover:text-yellow-700 font-semibold text-sm flex items-center">
                            Ver detalhes <i class="fas fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Card Ordens de Serviço Abertas -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden border-l-4 border-blue-500 hover:shadow-lg transition">
                <div class="p-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-500 uppercase tracking-wider">Ordens de Serviço Abertas</p>
                            <p class="text-3xl font-bold text-gray-900 mt-1">' . $c_ordens_abertas . '</p>
                        </div>
                        <div class="bg-blue-100 p-3 rounded-full">
                            <i class="fas fa-clipboard-list text-blue-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="/gop/chama_abertas.php" class="text-blue-600 hover:text-blue-700 font-semibold text-sm flex items-center">
                            Ver detalhes <i class="fas fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Card Preventivas em Aberto -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden border-l-4 border-red-500 hover:shadow-lg transition">
                <div class="p-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-500 uppercase tracking-wider">Preventivas pendentes para geração</p>
                            <p class="text-3xl font-bold text-gray-900 mt-1">' . $c_preventivas . '</p>
                        </div>
                        <div class="bg-red-100 p-3 rounded-full">
                            <i class="fas fa-calendar-check text-red-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="/gop/preventivas/preventivas_geracao.php" class="text-red-600 hover:text-red-700 font-semibold text-sm flex items-center">
                            Ver detalhes <i class="fas fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </div>
            <!-- Card Ordens com SLA em Atraso -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden border-l-4 border-purple-500 hover:shadow-lg transition">
                <div class="p-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-500 uppercase tracking-wider">Ordens de serviço fora de SLA</p>
                            <p class="text-3xl font-bold text-gray-900 mt-1">' . $c_ordens_sla . '</p>
                        </div>
                        <div class="bg-purple-100 p-3 rounded-full">
                            <i class="fas fa-clock text-purple-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="/gop/chama_fora_sla.php" class="text-purple-600 hover:text-purple-700 font-semibold text-sm flex items-center">
                            Ver detalhes <i class="fas fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </div>
            <!-- Card Ordens Suspensas -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden border-l-4 border-green-500 hover:shadow-lg transition">
                <div class="p-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-500 uppercase tracking-wider">Ordens de serviço Suspensas</p>
                            <p class="text-3xl font-bold text-gray-900 mt-1">' . $c_ordens_suspensas . '</p>
                        </div>
                        <div class="bg-green-100 p-3 rounded-full">
                            <i class="fas fa-pause-circle text-green-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="/gop/chama_suspensas.php" class="text-green-600 hover:text-green-700 font-semibold text-sm flex items-center">
                            Ver detalhes <i class="fas fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </div>
            <!-- Preventivas geradas em aberto -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden border-l-4 border-indigo-500 hover:shadow-lg transition">
                <div class="p-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-500 uppercase tracking-wider">Preventivas geradas em aberto</p>
                            <p class="text-3xl font-bold text-gray-900 mt-1">' . $c_preventivas_geradas . '</p>
                        </div>
                        <div class="bg-indigo-100 p-3 rounded-full">
                            <i class="fas fa-tools text-indigo-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="/gop/ordens/chama_ordens_preventivas.php" class="text-indigo-600 hover:text-indigo-700 font-semibold text-sm flex items-center">
                            Ver detalhes <i class="fas fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </div>

        </div>

    </main>
    ';
    }
    ?>

    <footer class="mt-20 py-6 text-center text-gray-500 text-sm">
        &copy; 2026 Sistema de Gestão de Manutenção. Todos os direitos reservados.
    </footer>

</body>

</html>