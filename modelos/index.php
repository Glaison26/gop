<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include('..\conexao.php');

date_default_timezone_set('America/Sao_Paulo');
$agora = date('d/m/Y H:i');
$c_data = date('Y-m-d');
//
$_SESSION['voltadiretriz'] = 'N';
$_SESSION['consulta_solicitacao'] = "";
$_SESSION['consulta_ordem'] = "";
$_SESSION['consulta_resumo'] = "S";
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
$c_sql = "select COUNT(*) AS sla FROM ordens WHERE data_previsao <= '$c_data' AND ordens.`status`='A'";
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
?>




<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestão de Manutenção</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .dropdown:hover .dropdown-menu {
            display: block;
        }
    </style>
</head>

<body class="bg-gray-100 font-sans leading-normal tracking-normal">

    <!-- Navbar -->
    <nav class="bg-blue-800 p-4 shadow-lg">
        <div class="container mx-auto flex items-center justify-between">
            <div class="text-white font-bold text-xl">
                <i class="fas fa-tools mr-2"></i>GOP - Gestão de Operacional
            </div>
            <div class="hidden md:flex items-center space-x-6">
                <a href="#" class="text-white hover:text-blue-200 transition">Início</a>

                <!-- Dropdown Cadastro -->
                <?php
                if ($_SESSION['tipo'] <> 'Solicitante') {
                    echo '
                <div class="relative dropdown">
                    <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                        Cadastros <i class="fas fa-chevron-down ml-1 text-xs"></i>
                    </button>
                    <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow-xl rounded-md w-48 z-50">
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/recursos/recursos_lista.php">Recursos Fisicos</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/espacos/espacos_lista.php">Espaços Fisicos</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/fornecedores/fornecedores_lista.php">Fornecedores</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/fabricantes/fabricantes_lista.php">Fabricantes</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/executores/executores_lista.php">Executores</a>
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

                <div class="relative dropdown">
                    <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                        Serviços <i class="fas fa-chevron-down ml-1 text-xs"></i>
                    </button>
                    <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow-xl rounded-md w-48 z-50">
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/solicitacao/solicitacao.php">Solicitações</a>
                        <?php
                        if ($_SESSION['tipo'] <> 'Solicitante') {
                            echo '<a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/ordens/ordens.php">Ordens de Serviço</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/preventivas/preventivas.php">Preventivas</a>
                    <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/ocorrencias/ocorrencias_lista.php">Ocorrências Padrões</a>
                   
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
                        <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/cadastros/pop/pops_lista.php">Cadastro de POP</a>
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
                            <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/indicadores/indicadores_quantitativos.php">Quantitativos</a>
                            <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/indicadores/indicadores_financeiros.php">Financeiros</a>
                        </div>';
                      }
                      ?>
                    </div>
               
                    <!-- User Profile -->
                    <div class="relative dropdown">
                        <button class="text-white hover:text-blue-200 transition flex items-center focus:outline-none">
                            <i class="fas fa-user-circle text-2xl"></i>
                        </button>
                        <div class="dropdown-menu absolute hidden bg-white text-gray-800 pt-2 shadow-xl rounded-md w-48 z-50 right-0">
                            <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/usuarios/usuario_alterar_senha.php">Alterar Senha</a>
                            <a class="block px-4 py-2 hover:bg-blue-100 border-b border-gray-100" href="/gop/logout.php">Sair</a>

                        </div>
                        <div class="md:hidden">
                            <button class="text-white focus:outline-none">
                                <i class="fas fa-bars text-2xl"></i>
                            </button>
                        </div>
                    </div>
    </nav>

    <!-- Main Content -->
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
                            <p class="text-3xl font-bold text-gray-900 mt-1">12</p>
                        </div>
                        <div class="bg-yellow-100 p-3 rounded-full">
                            <i class="fas fa-file-alt text-yellow-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="#" class="text-yellow-600 hover:text-yellow-700 font-semibold text-sm flex items-center">
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
                            <p class="text-3xl font-bold text-gray-900 mt-1">08</p>
                        </div>
                        <div class="bg-blue-100 p-3 rounded-full">
                            <i class="fas fa-clipboard-list text-blue-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="#" class="text-blue-600 hover:text-blue-700 font-semibold text-sm flex items-center">
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
                            <p class="text-3xl font-bold text-gray-900 mt-1">05</p>
                        </div>
                        <div class="bg-red-100 p-3 rounded-full">
                            <i class="fas fa-calendar-check text-red-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="#" class="text-red-600 hover:text-red-700 font-semibold text-sm flex items-center">
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
                            <p class="text-sm font-medium text-gray-500 uppercase tracking-wider">Ordens de serviço com SLA em Atraso</p>
                            <p class="text-3xl font-bold text-gray-900 mt-1">03</p>
                        </div>
                        <div class="bg-purple-100 p-3 rounded-full">
                            <i class="fas fa-clock text-purple-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="#" class="text-purple-600 hover:text-purple-700 font-semibold text-sm flex items-center">
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
                            <p class="text-3xl font-bold text-gray-900 mt-1">02</p>
                        </div>
                        <div class="bg-green-100 p-3 rounded-full">
                            <i class="fas fa-pause-circle text-green-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="#" class="text-green-600 hover:text-green-700 font-semibold text-sm flex items-center">
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
                            <p class="text-3xl font-bold text-gray-900 mt-1">04</p>
                        </div>
                        <div class="bg-indigo-100 p-3 rounded-full">
                            <i class="fas fa-tools text-indigo-600 text-2xl"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="#" class="text-indigo-600 hover:text-indigo-700 font-semibold text-sm flex items-center">
                            Ver detalhes <i class="fas fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </div>

        </div>


    </main>

    <footer class="mt-20 py-6 text-center text-gray-500 text-sm">
        &copy; 2026 Sistema de Gestão de Manutenção. Todos os direitos reservados.
    </footer>

</body>

</html>