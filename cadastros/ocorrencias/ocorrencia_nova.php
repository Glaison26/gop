<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// funções 



include_once "../../lib_gop.php";
include("../../conexao.php");
include("../../links2.php");



// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $c_descricao = rtrim($_POST['add_descricaoField']);
    $c_texto = $_POST['add_textoField'];
    $c_texto_fechamento = $_POST['add_textofechamentoField'];
    $c_tempo_horas = $_POST['add_tempo_horas'];
    $c_tempo_minutos = $_POST['add_tempo_minutos'];
    $i_id_tipo_ocorrencia = $_POST['tipo'];

    do {
        // grava dados no banco

        // faço a Leitura da tabela com sql
        $c_sql = $c_sql = "Insert into ocorrencias (descricao, texto, texto_fechamento, tempo_hora, tempo_minuto, id_tipo_ocorrencia)
                           Value ('$c_descricao', '$c_texto', '$c_texto_fechamento', '$c_tempo_horas', '$c_tempo_minutos', '$i_id_tipo_ocorrencia')";
                            echo $c_sql;
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
    <title>Novo Espaço Físico</title>
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
                    <h5>Nova Ocorrência de Serviço<h5>
                </div>
            </div>
        </div>

        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <div style='padding-left:15px;'>
                    <h5><img Align='left' src='\gop\images\aviso.png' alt='35' height='35'> $msg_erro</h5>
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
                    <label for="add_descricaoField" class="col-md-3 form-label">Descrição*</label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="add_descricaoField" name="add_descricaoField" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Tipo de Ocorrência</label>
                    <div class="col-sm-4">
                        <select class="form-select form-select-lg mb-3" id="tipo" name="tipo" required>
                            <option></option>
                            <?php
                            // select da tabela de tipo de ocorrências
                            $c_sql_ocorrencia = "SELECT tipo_ocorrencia.id, tipo_ocorrencia.descricao FROM tipo_ocorrencia ORDER BY tipo_ocorrencia.descricao";
                            $result_ocorrencia = $conection->query($c_sql_ocorrencia);
                            while ($c_linha = $result_ocorrencia->fetch_assoc()) {
                                  
                           echo "<option value='" . $c_linha['id'] . "'>" . $c_linha['descricao'] . "</option>";
                        
                            }
                            ?>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Tempo em horas</label>
                    <div class="col-sm-3">
                        <input type="number" class="form-control" id="add_tempo_horas" required name="add_tempo_horas">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Tempo em Min.</label>
                    <div class="col-sm-3">
                        <input type="number" class="form-control" id="add_tempo_minutos" required name="add_tempo_minutos">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Texto Padrão</label>
                    <div class="col-sm-11">
                        <textarea class="form-control" id="add_textoField" name="add_textoField" rows="8"></textarea>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Texto Padrão de Conclusão</label>
                    <div class="col-sm-11">
                        <textarea class="form-control" id="add_textofechamentoField" name="add_textofechamentoField" rows="8"></textarea>
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