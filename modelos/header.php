<?php
/**
 * GOP - Gestão Operacional
 * Componente de Cabeçalho Reutilizável
 */

// Inicia a sessão se ainda não estiver iniciada
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Simulação de dados do usuário (em um sistema real, viria do banco de dados/sessão)
$userName = isset($_SESSION['user_name']) ? $_SESSION['user_name'] : 'Usuário';
$userRole = isset($_SESSION['user_role']) ? $_SESSION['user_role'] : 'Operador';
$currentDate = date('d/m/Y');

?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo isset($pageTitle) ? $pageTitle . " | GOP" : "GOP - Gestão Operacional"; ?></title>
    <link rel="stylesheet" href="css/header.css">
    <!-- Font Awesome para ícones (opcional, via CDN) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<header class="gop-header">
    <div class="gop-logo">
        <h1>GOP</h1>
        <span>Gestão Operacional</span>
    </div>

    <nav class="gop-nav">
        <ul>
            <li><a href="dashboard.php"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="operacoes.php"><i class="fas fa-tasks"></i> Operações</a></li>
            <li><a href="relatorios.php"><i class="fas fa-chart-line"></i> Relatórios</a></li>
            <li><a href="configuracoes.php"><i class="fas fa-cog"></i> Configurações</a></li>
        </ul>
    </nav>

    <div class="gop-user-info">
        <div class="user-badge">
            <i class="fas fa-user"></i> <?php echo htmlspecialchars($userName); ?> (<?php echo htmlspecialchars($userRole); ?>)
        </div>
        <span class="date-info" style="font-size: 0.8rem; opacity: 0.7;">
            <i class="far fa-calendar-alt"></i> <?php echo $currentDate; ?>
        </span>
        <a href="logout.php" class="logout-btn" title="Sair do Sistema">
            <i class="fas fa-sign-out-alt"></i> Sair
        </a>
    </div>
</header>
