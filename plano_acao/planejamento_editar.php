<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include_once "../lib_gop.php";
include("../conexao.php");
include("../links2.php");

// rotina de post dos dados do formuário

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/plano_acao/planejamento_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from planejamento where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/plano_acao/mplanejamento_lista.php');
        exit;
    }
    $c_descritivo = $registro['descritivo'];
    $i_setor = $registro['id_setor'];
    $d_data = $registro['data'];
    $c_meta = $registro['meta'];
    $c_gerencia = $registro['gerencia'];
} else {
    // metodo post para atualizar dados
    $c_id = $_POST["id"];
    // pego setor selecionado
    $c_setor = $_POST['setor'];
    $c_sql_setor = "Select id from setores where descricao='$c_setor'";
    $result_setor = $conection->query($c_sql_setor);
    $registro_setor = $result_setor->fetch_assoc();
    $i_setor = $registro_setor['id'];
    //
    $d_data = new DateTime($_POST['data']);
    $d_data = $d_data->format('Y-m-d');
    $c_descritivo = $_POST['descritivo'];
    $c_meta = $_POST['meta'];
    $c_gerencia = $_POST['gerencia'];
    do {
        if (empty($c_descritivo) || empty($c_gerencia)) {
            $msg_erro = "Todos os Campos com (*) devem ser preenchidos !!";
            break;
        }
        // grava dados no banco
        // faço a Leitura da tabela com sql
        $c_sql = "Update planejamento" .
            " SET descritivo = '$c_descritivo',  gerencia='$c_gerencia', meta='$c_meta',
             id_setor='$i_setor', data='$d_data'".
            " where id=$c_id";
        
        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/plano_acao/planejamento_lista.php');
    } while (false);
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

    <div class="container  -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Editar dados do Planejamento de Plano de Ação<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Campos com (*) são obrigatórios</h5>
        </div>

        <br>
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <div style='padding-left:15px;'>
                    
                </div>
                <h4><img Align='left' src='\gop\images\aviso.png' alt='30' height='35'> $msg_erro</h4>
            </div>
            ";
        }
        ?>

        <form method="post">
            <input type="hidden" name="id" value="<?php echo $c_id; ?>">
            <div class="mb-3 row">
                <label for="data" class="col-md-3 form-label">Data (*)</label>
                <div class="col-md-2">
                    <input type="date" class="form-control" id="data" name="data" value='<?php echo $d_data; ?>'>
                </div>
            </div>

            <div class="mb-3 row">
                <label for="descritivo" class="col-md-3 form-label">Descritivo (*)</label>
                <div class="col-md-6">
                    <input type="text" class="form-control" id="descritivo" name="descritivo" value='<?php echo $c_descritivo; ?>'>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="gerencia" class="col-md-3 form-label">Gerência (*)</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" id="gerencia" name="gerencia" value='<?php echo $c_gerencia; ?>'>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Setor (*)</label>
                <div class="col-sm-5">
                    <select class="form-select form-select-lg mb-3" id="setor" name="setor">

                        <?php
                        // select da tabela de setores
                        $c_sql_setor = "SELECT setores.id, setores.descricao FROM setores ORDER BY setores.descricao";
                        $result_setor = $conection->query($c_sql_setor);
                        while ($c_linha = $result_setor->fetch_assoc()) {
                            $op = "";
                            if ($c_linha['id'] == $i_setor)
                                $op = 'selected';
                            echo "<option $op>$c_linha[descricao]</option>";
                        }
                        ?>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Meta</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="meta" name="meta" rows="5"><?php echo $c_meta; ?></textarea>
                </div>
            </div>

            <br>
            <div class="row mb-3">
                <div class="offset-sm-3 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/cadastros/materiais/materiais_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>

        </form>
    </div>

</body>

</html>