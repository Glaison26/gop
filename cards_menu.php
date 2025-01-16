<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
    <div class="row mx-auto h-25" style="max-width: 750px;">
        <div class="col-xl-4 col-md-6">
            <div class="card text-dark bg-light mb-3" style="width: 18rem;">
                <div class="card-header">
                    <h4>Solicitações de Serviço</h4>
                </div>
                <div class="card-body">

                    <p class="card-text">
                        <?php
                        if ($c_solicitacao_aberta > 0) {
                            echo "<img src='\gop\images\alerta.png' alt='25' height='25'>";
                        } else {
                            echo "<img src='\gop\images\certo.png' alt='25' height='25'>";
                        }
                        ?>

                    <h4><strong> Existem <?php echo $c_solicitacao_aberta; ?> Solicitações registradas como abertas</strong></h4>
                    </p>
                    <a href="/gop/chama_solicitacoes_menu.php" class="btn btn-primary">Clique para Visualizar</a>
                </div>
            </div>
        </div>

        <div class="col-xl-4 col-md-6">
            <div class="card text-dark bg-light mb-3" style="width: 18rem;">
                <div class="card-header">
                    <h4>Ordens de Serviço Abertas</h4>
                </div>

                <div class="card-body">

                    <p class="card-text">
                        <?php
                        if ($c_ordens_sla > 0) {
                            echo "<img src='\gop\images\alerta.png' alt='25' height='25'>";
                        } else {
                            echo "<img src='\gop\images\certo.png' alt='25' height='25'>";
                        } ?>
                    <h4><strong>Existem <?php echo $c_ordens_abertas; ?> Ordens em aberto</h4></strong></p><br>
                    <a href="/gop/chama_abertas.php" class="btn btn-primary">Clique para Visualizar</a>
                </div>

            </div>
        </div>

        <div class="col-xl-4 col-md-6">

            <div class="card text-dark bg-light mb-3" style="width: 18rem;">
                <div class="card-header">
                    <h4>Ordens de Serviço fora de SLA</h4>
                </div>

                <div class="card-body">

                    <p class="card-text">
                        <?php
                        if ($c_ordens_sla > 0) {
                            echo "<img src='\gop\images\alerta.png' alt='25' height='25'>";
                        } else {
                            echo "<img src='\gop\images\certo.png' alt='25' height='25'>";
                        } ?>
                    <h4><strong>Existem <?php echo $c_ordens_sla; ?> Ordens fora do prazo de SLA</h4></strong></p><br>
                    <a href="/gop/chama_fora_sla.php" class="btn btn-primary">Clique para Visualizar</a>
                </div>

            </div>
        </div>
        <div class="col-xl-4 col-md-6">
            <div class="card text-dark bg-light mb-3" style="width: 18rem;">
                <div class="card-header">
                    <h4>Preventivas</h4>
                </div>

                <div class="card-body">

                    <p class="card-text">
                        <?php
                        if ($c_preventivas > 0) {
                            echo "<img src='\gop\images\alerta.png' alt='25' height='25'>";
                        } else {
                            echo "<img src='\gop\images\certo.png' alt='25' height='25'>";
                        } ?>

                    <h4><strong>Existem <?php echo $c_preventivas ?> Preventivas a serem geradas</h4></strong></p><br>
                    <a href="/gop/preventivas/preventivas_geracao.php" class="btn btn-primary">Clique para Visualizar</a>
                </div>

            </div>
        </div>

    </div>
</body>

</html>