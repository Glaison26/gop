<?php
session_start();
if (!isset($_SESSION['newsession'])) {
  die('Acesso não autorizado!!!');
}


if (!isset($_GET["id"])) {
    header('location: /gop/ordens/ordens_gerenciar.php');
  exit;
}
// pego id da imagem
$c_id = $_GET["id"];
include("../conexao.php");
// sql para pegar o arquivo a ser excluido
$c_sql = "select caminho from ordens_imagens where id='$c_id'";
$result = $conection->query($c_sql);
// verifico se a query foi correto
if (!$result) {
  die("Erro ao Executar Sql!!" . $conection->connect_error);
}

// insiro os registro do banco de dados na tabela 
$c_linha = $result->fetch_assoc();
$c_pasta = $c_linha['caminho'];

// verifico existencia do arquivo

if (file_exists($c_pasta)) {
  if (unlink($c_pasta)) {  // se arquivo existe faço a exclusão
    echo "
         <script>
            alert('Imagem excluida com sucesso!!!')
         </script>   
         ";
    // exclusão do registro no banco de dados
    $c_sql = "delete from ordens_imagens where id=$c_id";
    $result = $conection->query($c_sql);
  } else {
    echo "
        <script>
            alert('Falha ao excluir imagem!!!')
         </script>   
         ";
  }
} else {
  echo "
  <script>
      alert('Arquivo de imagem não existe!!!')
   </script>   
   ";
}

header('location: /gop/ordens/ordens_gerenciar.php');