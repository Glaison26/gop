<?php
$c_descricao = $c_linha_ordem['descricao'];

?>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Descrição da Ordem</title>

</head>

<body>


    <form>
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Descrição da Ordem</h3>
            </div>
        </div>
        <div class="form-group">

            <textarea readonly class="form-control" id="descricao" name="descricao" rows="12"><?php echo $c_descricao; ?></textarea>
        </div>
    </form>
</body>

</html>