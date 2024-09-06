<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("conexao.php");
include("links2.php");
// pego id do recurso selecionado na página anterior
$i_id_recurso = $_GET["id"];
// sql para pegar nome
$c_sql = "SELECT recursos.id, recursos.descricao FROM recursos where recursos.id='$i_id_recurso'";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
$c_recurso = $registro['descricao'];
$c_solicitacao = "";

// inclusão da solicitação no banco de dados

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // procuro setor selecionado
    $c_setor = $_POST['setor'];
    $c_sql_setor = "Select id from setores where descricao='$c_setor'";
    $result_setor = $conection->query($c_sql_setor);
    $registro_setor = $result_setor->fetch_assoc();
    $i_setor = $registro_setor['id'];
    // procuro solicitante
    $c_solicitante = $_SESSION['c_usuario'];
    $c_sql_solicitante = "Select id from usuarios where login='$c_solicitante'";
    $result_solicitante = $conection->query($c_sql_solicitante);
    $registro_solicitante = $result_solicitante->fetch_assoc();
    $i_solicitante = $registro_solicitante['id'];
    // tipo da solicitação
    if ($_POST['tipo'] == "Programada") {
        $c_tipo = "P";
    } else {
        $c_tipo = 'U';
    }
    // data de abertura
    date_default_timezone_set('America/Sao_Paulo');
    $d_data_abertura =   date("Y-m-d");
    $c_agora = date('H:i');
    $c_descricao = $_POST['solicitacao'];
    do {

        //$d_data_abertura = $d_data_abertura->format('Y-m-d');
        // gravar informações 
        $c_sql = "Insert into solicitacao (id_setor, id_solicitante,id_recursos, data_abertura, hora_abertura, 
                status, classificacao,tipo,descricao) value ('$i_setor', '$i_solicitante', '$i_id_recurso', '$d_data_abertura', 
                '$c_agora', 'A', 'R', '$c_tipo', '$c_descricao')";
                echo $c_sql;
        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
        header('location: /gop/solicitacao_gerada.php?id_recurso=$i_id_recurso');



        //header('location: /gop/menu.php');
    } while (false);
}
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
            <h5>Conclusão de abertura de Solicitação de Serviço para Recurso Físico<h5>
        </div>
    </div>

    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Digite as informações da solicitação para o Recurso selecionado e Clique em finalizar para gravar a solicitação. Todos os Campos são obrigatórios</h5>
        </div>
        <form method="post">
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Recurso Selecionado</label>
                <div class="col-sm-7">
                    <input type="text" readonly="120" class="form-control" name="descricao" value="<?php echo $c_recurso; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Tipo de Solicitação</label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="tipo" name="tipo" value="<?php echo $c_tipo; ?>">
                        <option>Programada</option>
                        <option>Urgência</option>

                    </select>
                </div>
                <label class="col-sm-2 col-form-label">Setor </label>
                <div class="col-sm-3">
                    <select class="form-select form-select-lg mb-3" id="setor" name="setor">
                        <?php
                        // select da tabela de setores
                        $c_sql_setor = "SELECT setores.id, setores.descricao FROM setores ORDER BY setores.descricao";
                        $result_setor = $conection->query($c_sql_setor);
                        while ($c_linha = $result_setor->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>

            </div>
            <div style="padding-top:5px;">

                <div class="row mb-7">
                    <label class="col-sm-3 col-form-label">Descrição</label>
                    <div class="col-sm-7">
                        <textarea class="form-control" id="solicitacao" name="solicitacao" rows="10"><?php echo $c_solicitacao; ?></textarea>
                    </div>
                </div>

            </div>
            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Finalizar</button>
                    <a class='btn btn-danger' href='/gop/solicitacao_nova_recurso_pesquisa.php'><span class='glyphicon glyphicon-remove'></span> Voltar</a>
                </div>
            </div>
        </form>
    </div>


</body>

</html>