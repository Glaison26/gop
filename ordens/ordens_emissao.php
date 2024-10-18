<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
include("../links2.php");
$c_id = $_GET["id"];

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/ordens/ordens_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do plano
    $c_sql = "select *, setores.descricao as setor from planejamento
    join setores on planejamento.id_setor=setores.id 
    where planejamento.id='$c_id'";
    $result = $conection->query($c_sql);
}


?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Emissão de Ordem de Serviço<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Emissao de ordem de Serviço No. <?php echo $c_id?></h5>
        </div>
        <hr>
        <?php
        while ($registro = $result->fetch_assoc()) {
            $d_data = date("d-m-Y", strtotime(str_replace('/', '-', $registro['data'])));
            echo "<div class='row mb-6'>
            <p><strong>Planejamento</p></strong>
            <div class='col-sm-7'>
                <p>Data : $d_data<br>
                   Setor : $registro[setor]<br>
                   Gerência : $registro[gerencia]<br>
                   Descritivo :$registro[descritivo]<br>
                   Meta : $registro[meta]<br>
                   <br>
                 
                </p>
            </div>
        </div>";
            // sql para pegar as estratégia
            $c_sql_estr = "SELECT planejamento_diretrizes.prazo, planejamento_diretrizes.responsavel, planejamento_diretrizes.`local`, planejamento_diretrizes.custo,
            planejamento_diretrizes.metodologia, planejamento_diretrizes.motivo, planejamento_diretrizes.observacao, planejamento_diretrizes.situacao, 
             estrategias.descricao as estrategia, diretrizes.descricao as diretriz, diretrizes.texto
             FROM planejamento_diretrizes JOIN diretrizes ON planejamento_diretrizes.id_diretriz=diretrizes.id
             join estrategias on planejamento_diretrizes.id_estrategia=estrategias.id
             where planejamento_diretrizes.id_planejamento='$c_id'";
            $result_estr = $conection->query($c_sql_estr);
            //echo $c_sql_estr;

            while ($registro_estr = $result_estr->fetch_assoc()) {
                if ($registro_estr['situacao']=='C')
                  $c_situacao = 'Concluido';
                else
                  $c_situacao = 'Aberto';
                echo "<div class='row mb-6'>
        
            <p>
            <strong>Estratégia: $registro_estr[estrategia]</strong><br>
            <strong>Diretriz : $registro_estr[diretriz]</p></strong><br>
            <div class='col-sm-7'>
                <p>
                 Descritivo : $registro_estr[texto]<br>
                 Local :  $registro_estr[texto]<br>
                 Prazo :  $registro_estr[prazo]<br>
                 Responsavel :  $registro_estr[responsavel]<br>
                 Custo :  $registro_estr[custo]<br>  
                 Situação :  $c_situacao<br>
                 Metodologia :  $registro_estr[metodologia]<br>
                 Motivo :  $registro_estr[motivo]<br>
                 Observação :  $registro_estr[observacao]<br>
                  
                </p>
            </div>
        </div>";
            }
        }
        ?>

    </div>


</body>

</html>