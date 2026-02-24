<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include_once "../../lib_gop.php";
include("../../conexao.php");
include("../../links2.php");

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";
$c_id = $_GET["id"];

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/cadastros/ocorrencias/ocorrencias_lista.php');
        exit;
    }


    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from ocorrencias where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();
    // capturo os campos
    $c_descricao = $registro['descricao'];
    $c_texto = $registro['texto'];
    $c_texto_fechamento = $registro['texto_fechamento'];
    $c_tempo_horas = $registro['tempo_hora'];
    $c_tempo_minutos = $registro['tempo_minuto'];

    if (!$registro) {
        header('location: /gop/cadastros/ocorrencias/ocorrencias_lista.php');
        exit;
    }
} else {
    // metodo post para atualizar dados
    
    $c_descricao = rtrim($_POST['up_descricaoField']);
    $c_texto = $_POST['up_textoField'];
    $c_texto_fechamento = $_POST['up_textofechamentoField'];
    $c_tempo_horas = $_POST['up_tempo_horas'];
    $c_tempo_minutos = $_POST['up_tempo_minutos'];

    do {

        // grava dados no banco
        // faço a Leitura da tabela com sql
        $c_sql = "Update ocorrencias" .
            " SET descricao = '$c_descricao', texto = '$c_texto', texto_fechamento='$c_texto_fechamento',
            tempo_hora='$c_tempo_horas',tempo_minuto='$c_tempo_minutos'
            where id=$c_id";

        $result = $conection->query($c_sql);

        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/cadastros/ocorrencias/ocorrencias_lista.php');
    } while (false);
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/gop/css/basico.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Espaço Físico</title>
    <script>
        const handlePhone = (event) => {
            let input = event.target
            input.value = phoneMask(input.value)
        }

        const phoneMask = (value) => {
            if (!value) return ""
            value = value.replace(/\D/g, '')
            value = value.replace(/(\d{2})(\d)/, "($1) $2")
            value = value.replace(/(\d)(\d{4})$/, "$1-$2")
            return value
        }
    </script>
</head>

<body>

    <div class="container-fluid">

        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Editar Ocorrência de Serviço<h5>
                </div>
            </div>
        </div>

        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <div style='padding-left:15px;'>
                    <h5><img Align='left' src='\gop\images\aviso.png' alt='30' height='35'> $msg_erro</h5>
                </div>
                
            </div>
            ";
        }
        ?>
        <div class="container content-box">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

                </div>
                <h5>Campos com * são obrigatórios</h5>
            </div>

            <form method="post">
                <div class="mb-3 row">
                    <label for="up_descricaoField" class="col-md-3 form-label">Descrição (*)</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" id="up_descricaoField" name="up_descricaoField" required value="<?php echo $c_descricao; ?>">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Tempo em horas</label>
                    <div class="col-sm-2">
                        <input type="number" class="form-control" required id="up_tempo_horas" name="up_tempo_horas" value="<?php echo $c_tempo_horas; ?>">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Tempo em Min.</label>
                    <div class="col-sm-2">
                        <input type="number" class="form-control" required id="up_tempo_minutos" name="up_tempo_minutos" value="<?php echo $c_tempo_minutos; ?>">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Texto padrão</label>
                    <div class="col-sm-9">
                        <textarea class="form-control" id="up_textoField" name="up_textoField" rows="8"><?php echo $c_texto; ?></textarea>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Texto de conclusão</label>
                    <div class="col-sm-9">
                        <textarea class="form-control" id="up_textofechamentoField" name="up_textofechamentoField" rows="8"><?php echo $c_texto_fechamento; ?></textarea>
                    </div>
                </div>


                <br>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                        <a class='btn btn-danger' href='/gop/cadastros/ocorrencias/ocorrencias_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                    </div>

                </div>
            </form>
        </div>

    </div>

</body>

</html>