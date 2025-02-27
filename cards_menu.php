<?php
/////////////////// rotina para definir cores do cards
// solicitações em aberto
if ($c_solicitacao_aberta > 0)
    $c_cor_solicitacoes_abertas = 'card text-dark bg-warning mb-3';
else
    $c_cor_solicitacoes_abertas = 'card text-dark bg-info mb-3';
// ordens de serviço suspensas
if ($c_ordens_suspensas > 0)
    $c_cor_ordens_suspensas = 'card text-dark bg-warning mb-3';
else
    $c_cor_ordens_suspensas = 'card text-dark bg-info mb-3';
// ordens de serviço abertas
if ($c_ordens_abertas > 0)
    $c_cor_ordens_abertas = 'card text-dark bg-warning mb-3';
else
    $c_cor_ordens_abertas = 'card text-dark bg-info mb-3';
// ordens fora de SLA
if ($c_ordens_sla > 0)
    $c_cor_ordens_sla = 'card text-dark bg-warning mb-3';
else
    $c_cor_ordens_sla = 'card text-dark bg-info mb-3';
// preventivas pendentes de geração
if ($c_preventivas > 0)
    $c_cor_preventivas_pendentes = 'card text-dark bg-warning mb-3';
else
    $c_cor_preventivas_pendentes = 'card text-dark bg-info mb-3';
// preventivas geradas no dia
if ($c_preventivas_geradas > 0)
    $c_cor_preventivas_geradas = 'card text-dark bg-warning mb-3';
else
    $c_cor_preventivas_geradas = 'card text-dark bg-info mb-3';
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="row mx-auto h-25" style="max-width: 750px;">
        <div class="col-xl-4 col-md-6">
            <div class="<?php echo "$c_cor_solicitacoes_abertas" ?>" style="width: 18rem;">

                <div class="card-body">

                    <p class="card-text">
                    <div style="padding-left:60px;">
                        <?php
                        if ($c_solicitacao_aberta > 0) {
                            echo "<img src='\gop\images\alerta.png' alt='25' height='25'>";
                        } else {
                            echo "<img src='\gop\images\certo.png' alt='25' height='25'>";
                        }
                        ?>
                    </div>
                    <div style="padding-left:2px;">
                        <h1><strong><?php echo $c_solicitacao_aberta; ?><h4>Solicitaçao(ões) aberta(s)</h4> </strong></h1>
                    </div>
                    </p>
                   
                    <a href="/gop/chama_solicitacoes_menu.php" class="btn btn-success">Clique para Visualizar</a>
                </div>
            </div>
        </div>

        <div class="col-xl-4 col-md-6">
            <div class="<?php echo "$c_cor_ordens_abertas" ?>" style="width: 18rem;">


                <div class="card-body">

                    <p class="card-text">
                    <div style="padding-left:60px;">
                        <?php
                        if ($c_ordens_abertas > 0) {
                            echo "<img src='\gop\images\alerta.png' alt='25' height='25'>";
                        } else {
                            echo "<img src='\gop\images\certo.png' alt='25' height='25'>";
                        } ?>
                    </div>
                    <div style="padding-left:2px;">
                        <h1><strong><?php echo $c_ordens_abertas; ?><h4>Orden(s) de Serviço Aberta(s)</h4></strong></h1>
                        </p>
                    </div>
                    <a href="/gop/chama_abertas.php" class="btn btn-success">Clique para Visualizar</a>
                </div>

            </div>
        </div>

        <div class="col-xl-4 col-md-6">

            <div class="<?php echo "$c_cor_ordens_sla" ?>" style="width: 18rem;">


                <div class="card-body">

                    <p class="card-text">
                    <div style="padding-left:60px;">
                        <?php
                        if ($c_ordens_sla > 0) {
                            echo "<img src='\gop\images\alerta.png' alt='25' height='25'>";
                        } else {
                            echo "<img src='\gop\images\certo.png' alt='25' height='25'>";
                        } ?>
                    </div>
                    <div style="padding-left:2px;">
                        <h1><strong><?php echo $c_ordens_sla; ?><h4>Orden(s) de Serviço fora de SLA</h4>
                        </h1></strong></p>
                    </div>
                    <a href="/gop/chama_fora_sla.php" class="btn btn-success">Clique para Visualizar</a>
                </div>

            </div>
        </div>
        <div class="col-xl-4 col-md-6">
            <div class="<?php echo "$c_cor_preventivas_pendentes" ?>" style="width: 18rem;">


                <div class="card-body">

                    <p class="card-text">
                    <div style="padding-left:60px;">
                        <?php
                        if ($c_preventivas > 0) {
                            echo "<img src='\gop\images\alerta.png' alt='25' height='25'>";
                        } else {
                            echo "<img src='\gop\images\certo.png' alt='25' height='25'>";
                        } ?>
                    </div>
                    <div style="padding-left:2px;">
                        <h1><strong><?php echo $c_preventivas ?> <h4>Preventiva(s) Pendente(s)</h4>
                        </h1></strong></p>
                    </div>
                    <a href="/gop/preventivas/preventivas_geracao.php" class="btn btn-success">Clique para Visualizar</a>
                </div>

            </div>
        </div>

        <div class="col-xl-4 col-md-6">
            <div class="<?php echo "$c_cor_ordens_suspensas" ?>" style="width: 18rem;">


                <div class="card-body">

                    <p class="card-text">
                    <div style="padding-left:60px;">
                        <?php
                        if ($c_ordens_suspensas > 0) {
                            echo "<img src='\gop\images\alerta.png' alt='25' height='25'>";
                        } else {
                            echo "<img src='\gop\images\certo.png' alt='25' height='25'>";
                        } ?>
                    </div>
                    <br>
                    <div style="padding-left:2px;">
                        <h1><strong><?php echo $c_ordens_suspensas ?><h4>Orden(s) Suspensa(s)</h4>
                        </h1></strong></p>
                    </div>
                    <a href="/gop/chama_suspensas.php" class="btn btn-success">Clique para Visualizar</a>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-md-6">
            <div class="<?php echo "$c_cor_preventivas_geradas" ?>" style="width: 18rem;">


                <div class="card-body">

                    <p class="card-text">
                    <div style="padding-left:60px;">
                        <?php
                        if ($c_preventivas_geradas > 0) {
                            echo "<img src='\gop\images\alerta.png' alt='25' height='25'>";
                        } else {
                            echo "<img src='\gop\images\certo.png' alt='25' height='25'>";
                        } ?>
                    </div>
                    
                    <div style="padding-left:2px;">
                        <h1><strong><?php echo $c_preventivas_geradas ?> <h4>Preventiva(s) Gerada(s)</h4>
                        </h1></strong></p>
                    </div>

                    <a href="/gop/preventivas/preventivas_resumo.php" class="btn btn-success">Clique para Visualizar</a>
                </div>

            </div>
        </div>

    </div>
</body>

</html>