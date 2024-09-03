<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}


include_once "lib_gop.php";
include("conexao.php");
include("links2.php");

$c_descricao = '';
$c_responsavel = '';
$c_fone1 = '';
$c_fone2 = '';
$c_email = '';
$c_prioritario = '';
$c_nivelprioridade = '';

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $c_descricao = $_POST['descricao'];
    $c_responsavel = $_POST['responsavel'];
    $c_fone1 = $_POST['fone1'];
    $c_fone2 = $_POST['fone2'];
    $c_email = $_POST['email'];
    $c_prioritario = $_POST['prioritario'];
    $c_nivelprioridade = $_POST['nivelprioridade'];
    $c_centrodecusto = $_POST['centrocusto'];

    do {
        if (empty($c_descricao)  || empty($c_responsavel)) {
            $msg_erro = "Campos descrição e responsável devem ser preenchidos!!";
            break;
        }
        // localizo o id do valor do combobox de centro de custos
        // select da tabela de centro de custos
        $c_sql_centros = "SELECT centrodecusto.id FROM centrodecusto where centrodecusto.descricao='$c_centrodecusto' ORDER BY centrodecusto.descricao";
        $result_centros = $conection->query($c_sql_centros);
        $registro_centros = $result_centros->fetch_assoc();
        $i_centro = $registro_centros['id'];
        // grava dados no banco

        // faço a Leitura da tabela com sql
        $c_sql = "Insert into setores (descricao,  responsavel, fone1, fone2, prioritario, nivelprioridade, email, id_centrodecusto)" .
            "Value ('$c_descricao', '$c_responsavel', '$c_fone1', '$c_fone2', '$c_prioritario', '$c_nivelprioridade', '$c_email', '$i_centro')";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $c_descricao = '';
        $c_responsavel = '';
        $c_fone1 = '';
        $c_fone2 = '';
        $c_email = '';
        $c_prioritario = '';
        $c_nivelprioridade = '';


        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/setores_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
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
    <div class="container -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo Setor<h5>
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

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Descrição</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Centro de Custo </label>
                <div class="col-sm-6">
                    <select class="form-select form-select-lg mb-3" id="centrocusto" name="centrocusto">
                        <?php
                        // select da tabela de espacos fisicos
                        $c_sql_centro = "SELECT centrodecusto.id, centrodecusto.descricao FROM centrodecusto ORDER BY centrodecusto.descricao";
                        $result_centro = $conection->query($c_sql_centro);
                        while ($c_linha = $result_centro->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Responsável</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="100" class="form-control" name="responsavel" value="<?php echo $c_responsavel; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Fone I</label>
                <div class="col-sm-2">
                    <input type="tel" onkeyup="handlePhone(event)" maxlength="20" id="fone1" class="form-control" name="fone1" value="<?php echo $c_fone1; ?>">
                </div>
                <label class="col-sm-2 col-form-label">Fone II</label>
                <div class="col-sm-2">
                    <input type="tel" onkeyup="handlePhone(event)" maxlength="20" id="fone2" class="form-control" name="fone2" value="<?php echo $c_fone2; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">E-mail</label>
                <div class="col-sm-6">
                    <input type="email" maxlength="120" id="email" class="form-control" name="email" placeholder="E-mail" value="<?php echo $c_email; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Prioritário</label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="prioritario" name="prioritario">
                        <option>SIM</option>
                        <option>NÃO</option>
                    </select>
                </div>
                <label class="col-sm-2 col-form-label">Prioridade (de 1 a 5)</label>
                <div class="col-sm-2">
                    <select class="form-select form-select-lg mb-3" id="nivelprioridade" name="nivelprioridade">
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                        <option>5</option>

                    </select>
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
            <div class="row mb-3">
                <div class="offset-sm-3 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/setores_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>