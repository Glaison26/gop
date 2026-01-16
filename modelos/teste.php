<?php
// header.php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Exemplo de dados do usuário logado
$usuario = $_SESSION['usuario'] ?? 'Usuário';
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>GOP - Gestão Operacional</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Estilo personalizado -->
    <style>
        body {
            background-color: #f5f6fa;
        }
        .gop-header {
            background-color: #0d6efd;
            color: #fff;
        }
        .gop-header a {
            color: #fff;
            text-decoration: none;
            margin-right: 15px;
        }
        .gop-header a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<header class="gop-header p-3 mb-4">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <div>
            <h4 class="mb-0">GOP - Gestão Operacional</h4>
            <small>Sistema de controle operacional</small>
        </div>

        <nav>
            <a href="dashboard.php">Dashboard</a>
            <a href="tabelas.php">Tabelas</a>
            <a href="formularios.php">Formulários</a>
            <a href="logout.php" class="text-warning">Sair</a>
        </nav>

        <div class="text-end">
            <small>Usuário:</small><br>
            <strong><?= htmlspecialchars($usuario) ?></strong>
        </div>
    </div>
</header>

<main class="container-fluid">
