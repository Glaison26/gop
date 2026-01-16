<?php
// Define o título da página antes de incluir o cabeçalho
$pageTitle = "Página Inicial";

// Simulação de login para demonstração
session_start();
$_SESSION['user_name'] = "João Silva";
$_SESSION['user_role'] = "Administrador";

// Inclui o cabeçalho
include 'header.php';
?>

<main style="padding: 2rem; max-width: 1200px; margin: 0 auto;">
    <section style="background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
        <h2 style="color: #2c3e50; margin-bottom: 1rem;">Bem-vindo ao GOP - Gestão Operacional</h2>
        <p style="line-height: 1.6; color: #555;">
            Este é um exemplo de como o cabeçalho é integrado às páginas do sistema. 
            O cabeçalho é fixo no topo e contém a identificação do sistema, menu de navegação e informações do usuário logado.
        </p>
        
        <div style="margin-top: 2rem; display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px;">
            <div style="border: 1px solid #eee; padding: 1.5rem; border-radius: 6px;">
                <h3 style="color: #3498db;"><i class="fas fa-info-circle"></i> Como usar</h3>
                <p style="font-size: 0.9rem; margin-top: 10px;">Basta utilizar o comando <code>include 'includes/header.php';</code> no início de cada arquivo .php do seu sistema.</p>
            </div>
            <div style="border: 1px solid #eee; padding: 1.5rem; border-radius: 6px;">
                <h3 style="color: #3498db;"><i class="fas fa-code"></i> Customização</h3>
                <p style="font-size: 0.9rem; margin-top: 10px;">Você pode alterar as cores e estilos editando o arquivo <code>css/header.css</code>.</p>
            </div>
        </div>
    </section>
</main>

<?php
// Aqui você incluiria o rodapé (footer.php) se existisse
?>
</body>
</html>
