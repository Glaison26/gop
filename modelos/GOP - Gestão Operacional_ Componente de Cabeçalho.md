# GOP - Gestão Operacional: Componente de Cabeçalho

Este repositório contém o componente de cabeçalho (header) desenvolvido para o sistema **GOP - Gestão Operacional**. O design foi focado em profissionalismo, clareza e facilidade de integração.

## Estrutura de Arquivos

- `includes/header.php`: O arquivo principal que contém a estrutura HTML e lógica PHP.
- `css/header.css`: Estilização completa do cabeçalho, incluindo responsividade básica.
- `index.php`: Exemplo prático de implementação.

## Funcionalidades Implementadas

1.  **Identificação do Sistema**: Logo "GOP" com subtítulo descritivo.
2.  **Menu de Navegação**: Links para as principais áreas (Dashboard, Operações, Relatórios, Configurações).
3.  **Gestão de Sessão**: Exibição dinâmica do nome do usuário e seu cargo/perfil.
4.  **Informações de Contexto**: Exibição da data atual formatada.
5.  **Ação de Logout**: Botão de saída destacado em vermelho para segurança.
6.  **Design Responsivo**: Ajustes automáticos para telas menores.
7.  **Integração de Ícones**: Utilização do Font Awesome para uma interface moderna.

## Como Implementar

Para utilizar o cabeçalho em qualquer página do sistema, siga o exemplo abaixo:

```php
<?php
// 1. Opcional: Defina o título da página
$pageTitle = "Nome da Página";

// 2. Inclua o arquivo de cabeçalho
include 'includes/header.php';
?>

<!-- Conteúdo da sua página aqui -->

</body>
</html>
```

## Requisitos

- Servidor PHP 7.4 ou superior.
- Conexão com internet (para carregar os ícones via CDN do Font Awesome).
- Estrutura de pastas mantendo o CSS relativo ao arquivo que inclui o header.
