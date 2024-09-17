<div class="row mx-auto h-25" style="max-width: 750px;">
    <div class="col-xl-4 col-md-6">
        <div class="card text-dark bg-light mb-3" style="width: 18rem;">
            <div class="card-header">
                <h4>Solicitações de Serviço</h4>
            </div>
            <div class="card-body">

                <p class="card-text">
                    <img src="\gop\images\alerta.png" alt="25" height="25">
                <h4><strong> Existem <?php echo $c_solicitacao_aberta; ?> Solicitações registradas como abertas</strong></h4>
                </p>
                <a href="/gop/chama_solicitacoes_menu.php" class="btn btn-primary">Clique para Visualizar</a>
            </div>
        </div>
    </div>
    <div class="col-xl-4 col-md-6">

        <div class="card text-dark bg-light mb-3" style="width: 18rem;">
            <div class="card-header">
                <h4>Ordens de Serviço</h4>
            </div>

            <div class="card-body">

                <p class="card-text">
                    <?php
                    if ($c_ordens_sla > 0) {
                        echo "<img src='\gop\images\alerta.png' alt='25' height='25'>";
                    } else {
                        echo "<img src='\gop\images\certo.png' alt='25' height='25'>";
                    } ?>
                <h4><strong>Existem <?php echo $c_ordens_sla; ?> Ordens de Serviço fora do prazo SLA</h4></strong></p><br>
                <a href="#" class="btn btn-primary">Clique para Visualizar</a>
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

                <h4><strong>Existem 0 Preventivas Ordens de Serviço a serem geradas</h4></strong></p>
                <a href="#" class="btn btn-primary">Clique para Visualizar</a>
            </div>

        </div>
    </div>

</div>