<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
include_once "../lib_gop.php";
include("../links.php");
$c_id = $_GET["id"];
$c_descricao = "";
// sql para contar numero de refistros
// sql para capturar as imagens
$c_sql_conta = "SELECT Count(*) as total FROM ordens_imagens where ordens_imagens.id_ordem='$c_id' ORDER BY ordens_imagens.`data` desc";
$result_conta = $conection->query($c_sql_conta);
$c_linha_conta = $result_conta->fetch_assoc();
$c_conta = $c_linha_conta['total'];
?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Imagens da Ordem de Serviço<h5>
        </div>
    </div>
    <br>
    <div class="container -my5">
        <div class="class='mb-3 row">
            <a class='btn btn-Light' href='/gop/ordens/ordens_gerenciar.php'> <img src="\gop\images\saida.png" alt="" width="20" height="20"> Voltar</a>
        </div><br>
        
        <?php
        // sql para capturar as imagens
        $c_sql = "SELECT * FROM ordens_imagens where ordens_imagens.id_ordem='$c_id' ORDER BY ordens_imagens.`data` desc";
        $result = $conection->query($c_sql);
        $i_contador = 1;
        while ($c_linha = $result->fetch_assoc()) {
            $d_data =  DateTime::createFromFormat('Y-m-d', $c_linha["data"]);
            $d_data = $d_data->format('d/m/Y');
            $c_descricao = $c_linha['comentario'];
            $c_pasta = $c_linha['caminho'];
            $c_pasta = substr($c_pasta, 4);
            $c_caminho = "\gop\ordens\img\ ";
            $c_caminho = rtrim($c_caminho) . $c_pasta;

            // string para montagem do html
            $c_texto = "<div class='panel panel-primary class'>
                         <div class='panel-heading text-center'>
                              <h4>Imagem $i_contador de $c_conta</h4>
                               
                        </div>
                     </div>" .
                "<div class='row mb-3'>
            <label class='col-md-3 form-label'>Data</label>
            <div class='col-md-2'>
                <input type='text' readonly maxlength='10' class='form-control' placeholder='dd/mm/yyyy' name='data' id='data' onkeypress='mascaraData(this)'' value='$d_data'>
            </div>
        </div>
        <div class='mb-3 row'>

            <label for='up_descricaoField' class='col-md-3 form-label'>Descrição</label>
            <div class='col-md-6'>
                <input type='text' readonly class='form-control' id='up_descricaoField' name='up_descricaoField' value='$c_descricao'>
            </div>

        </div>" .
                "<div class='mb-3 row'>" .

                "<label for='up_arquivoField' class='col-md-3 form-label'>Arquivo</label>
            <div class='col-md-6'>
                <input type='text' readonly class='form-control' id='up_arquivoField' name='up_arquivoField' value='$c_pasta'>
            </div>

        </div>" .


                "<div class='mb-3 row'>
                            <label class='col-md-3 form-label'>Imagem</label>
                                <div class='panel panel-success'>
                                    <div class='panel-body'>
                                        <img class='rounded mx-auto d-block' class='img-responsive' src='$c_caminho' class='img-fluid' style='height :300px' style='width:300px'>
                                    </div>
                                </div>
                         </div>";



            echo $c_texto;
            $i_contador++;
        }
        ?>
    </div>

</body>

</html>