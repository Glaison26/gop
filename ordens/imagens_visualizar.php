<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("../conexao.php");
include_once "../lib_gop.php";
include("../links2.php");

// rotina de post dos dados do formuário
$c_descricao = "";
$d_data = "";

$c_id = $_GET["id"];

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";
//

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/ordens/ordens_gerenciar.php');
        exit;
    }


    $c_sql = "SELECT * FROM ordens_imagens where ordens_imagens.id='$c_id'";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/ordens/ordens_gerenciar.php');
        exit;
    }
    $c_descricao = $registro['comentario'];
    $d_data =  DateTime::createFromFormat('Y-m-d', $registro["data"]);
    $d_data = $d_data->format('d/m/Y');
    $c_pasta = $registro['caminho'];
    $c_pasta = substr($c_pasta, 4);
    //
    $c_arquivo = $registro['caminho'];
} else { // post da innformações
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // metodo post para atualizar dados
        $c_id = $_POST["id"];
        $c_descricao = $_POST['up_descricaoField'];
        $d_data = $_POST['data'];
        $d_data = date("Y-m-d", strtotime(str_replace('/', '-', $d_data)));
        do {
            // faço a alteração do registro
            $c_sql = "Update ordens_imagens" .
                " SET comentario ='$c_descricao',  data = '$d_data' where id=$c_id";
            $result = $conection->query($c_sql);
            // verifico se a query foi correto
            if (!$result) {
                die("Erro ao Executar Sql!!" . $conection->connect_error);
            }
            $msg_gravou = "Dados Gravados com Sucesso!!";
            header('location: /gop/ordens/ordens_gerenciar.php');
        } while (false);
    }
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
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Imagem da Ordem de Serviço<h5>
        </div>
    </div>
    <br>
    <div class="container -my5">
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-danger' role='alert'>
                <h5>$msg_erro</h5>
            </div>
                ";
        }
        ?>

        <form method="post">
            
            <hr>
            <input type="hidden" name="id" value="<?php echo $c_id; ?>">
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Data</label>
                <div class="col-sm-2">
                    <input type="text" maxlength="10" class="form-control" placeholder="dd/mm/yyyy" name="data" id="data" onkeypress="mascaraData(this)" value="<?php echo $d_data; ?>">
                </div>
            </div>
            <div class="mb-3 row">

                <label for="up_descricaoField" class="col-md-3 form-label">Descrição</label>
                <div class="col-md-6">
                    <input type="text" class="form-control" id="up_descricaoField" name="up_descricaoField" value="<?php echo $c_descricao; ?>">
                </div>

            </div>
            <div class="mb-3 row">

                <label for="up_arquivoField" class="col-md-3 form-label">Arquivo</label>
                <div class="col-md-6">
                    <input type="text" readonly class="form-control" id="up_arquivoField" name="up_arquivoField" value="<?php echo $c_pasta; ?>">
                </div>

            </div>
            <div class="mb-3 row">
                <label class="col-md-3 form-label">Imagem</label>
                <div class="panel panel-success">
                    <div class="panel-body">
                        <img class="rounded mx-auto d-block" class="img-responsive" src="\gop\ordens\img\<?php echo $c_pasta; ?>" class="img-fluid" style="height :400px" style="width:400px">
                    </div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <button type="submit" id='btn_grava' name='btn_grava' class="btn btn-Light"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-Light' href='/gop/ordens/ordens_gerenciar.php'> <img src="\gop\images\voltar.png" alt="" width="15" height="15"> Voltar</a>
                </div>

            </div>
            <?php
            if (!empty($msg_gravou)) {
                echo "
                    <div class='row mb-3'>
                        <div class='offset-sm-3 col-sm-6'>
                             <div class='alert alert-success alert-dismissible fade show' role='alert'>
                                <strong>$msg_gravou</strong>

                             </div>
                        </div>     
                    </div>    
                ";
            }
            ?>
            <br>
        </form>
    </div>

</body>

</html>