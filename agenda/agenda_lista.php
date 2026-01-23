<?php 

session_start(); // controle de acesso ao formulário
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
// executo o sql que foi montado
$c_sql = $_SESSION['sql_agenda'];
$result = $conection->query($c_sql);


//echo $_SESSION['sql_agenda'];
?>

<!-- html com tabela da agenda dp executor de serviço selecionado no período -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agenda de Executor de Serviço</title>
</head>
<body>
    <div class="container-fluid">

        <div class="panel panel-primary class">
            <div class="panel-heading text-center">
                <h4>GOP - Gestão Operacional</h4>
                <h5>Agenda de Executor<h5>
            </div>
        </div>
        
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>

            <h5>Agenda do Executor : xxxxxx no perído de </h5>
        </div>
    </div>

    
</body>
</html>