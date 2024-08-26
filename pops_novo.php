<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

// funções 

function carregadados()
{
    $c_descricao = $_POST['descricao'];
}

include_once "lib_gop.php";

$c_descricao = "";

// conexão dom o banco de dados
$servername = $_SESSION['local'];
$username = $_SESSION['usuario'];
$password =  $_SESSION['senha'];
$database = $_SESSION['banco'];
// criando a conexão com banco de dados
$conection = new mysqli($servername, $username, $password, $database);
// checo erro na conexão
if ($conection->connect_error) {
    die("Erro na Conexão com o Banco de Dados!! " . $conection->connect_error);
}
// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";
$c_tipo = "";
$c_descricao = "";
$c_revisado = "";
$c_preparado = "";
$c_data = date('d/m/Y');
$c_resultado = "";
$c_descritivo = "";
$c_material = "";
$c_atividadecritica = "";
$c_cuidados = "";
$c_anc = "";
$c_processo = "";
$c_objetivo = "";
$c_riscos = "";
$c_bibliografia = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $c_descricao = $_POST['descricao'];
    $c_tipo = $_POST['tipopop'];
    $c_descricao = $_POST['descricao'];
    $c_revisado = $_POST['revisado'];
    $c_preparado = $_POST['preparado'];
    $c_data =  new DateTime(date('d-m-Y'));
    $c_data = $c_data->format('Y-m-d');

    //$c_dataemissao = new DateTime(Date('d-m-Y'));

    $c_resultado = $_POST['resultado'];
    $c_descritivo = $_POST['descritivo'];
    $c_material = $_POST['material'];
    $c_atividadecritica = $_POST['atividadecritica'];
    $c_cuidados = $_POST['cuidados'];
    $c_anc = $_POST['anc'];
    $c_processo = $_POST['processo'];
    $c_objetivo = $_POST['objetivo'];
    $c_risco = $_POST['risco'];
    $c_bibliografia = $_POST['bibliografia'];
    //
    $c_recurso = $_POST['recurso'];
    $c_oficina = $_POST['oficina'];
    $c_espaco = $_POST['espaco'];

    do {
        if (empty($c_descricao)) {
            $msg_erro = "Campos Descrição, Descritivo devem ser preenchidos !!";
            break;
        }
        // select da tabela de marcas
        $c_sql_secundario = "SELECT recursos.id FROM recursos where recursos.descricao='$c_recurso' ORDER BY recursos.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_idrecurso = $registro_secundario['id'];
        // select da tabela de oficinas para pegar codigo
        $c_sql_secundario = "SELECT oficinas.id FROM oficinas where oficinas.descricao='$c_oficina' ORDER BY oficinas.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_idoficina = $registro_secundario['id'];
        // verifico a id do espaço fisico selecionado no combo 
        $c_sql_secundario = "SELECT espacos.id FROM espacos where espacos.descricao='$c_espaco' ORDER BY espacos.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_idespaco = $registro_secundario['id'];
        // grava dados no banco
        $c_sql = "Insert into pops (descricao, revisado, preparado, resultadoesperado, materialnecessario, descritivo, atividadecritica, cuidados, anc, data," .
            "processo, objetivo, risco, refbibliografica, tipo, id_recurso, id_espaco, id_oficina)" .
            "Value ('$c_descricao', '$c_revisado', '$c_preparado', '$c_resultado','$c_material', '$c_descritivo', '$c_atividadecritica', '$c_cuidados', '$c_anc'" .
            ", '$c_data', '$c_processo', '$c_objetivo', '$c_risco', '$c_bibliografia', '$c_tipo', '$i_idrecurso', '$i_idespaco', '$i_idoficina' )";
        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $c_descricao = "";
        $msg_gravou = "Dados Gravados com Sucesso!!";
        header('location: /gop/pops_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>GOP</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css">
    <link rel="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css">
    <link href="https://nightly.datatables.net/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
    <script type="text/javascript" src="js/jquery.maskedinput-1.1.4.pack.js"></script>
</head>

<body>
    <div class="panel panel-light" style="background-color: #e3f2fd;">
        <div class="panel-heading text-center">
            <h2>Novo registro de POP</h2>
        </div>
    </div>
    <br>
    <div class="container -my5">
        <?php
        if (!empty($msg_erro)) {
            echo "
            <div class='alert alert-warning' role='alert'>
                <h3>$msg_erro</h3>
            </div>
                ";
        }
        ?>

        <form method="post">
            <hr>
            <div class="row mb-3">
                <div class="form-check" class="col-sm-6">
                    <p>
                        Tipo do POP<br><br>
                        <input type="radio" name="tipopop" id="tipo1" value="1">
                        <label class="form-check-label" for="tipo1">
                            Administrativo
                        </label>
                        <input type="radio" name="tipopop" id="tipo2" value="2">
                        <label class="form-check-label" for="tipo2">
                            Edificação
                        </label><br>
                        <input type="radio" name="tipopop" id="tipo3" value="3">
                        <label class="form-check-label" for="tipo3">
                            Equipamento
                        </label>
                        <input type="radio" name="tipopop" id="tipo4" value="4">
                        <label class="form-check-label" for="tipo4">
                            Instalação
                        </label><br>
                        <input type="radio" name="tipopop" id="tipo5" value="5">
                        <label class="form-check-label" for="tipo5">
                            Mobiliário
                        </label>
                    </p>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Descrição</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Preparado por</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="preparado" value="<?php echo $c_preparado; ?>">
                </div>
            </div>


            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Revisado por</label>
                <div class="col-sm-6">
                    <input type="text" maxlength="120" class="form-control" name="revisado" value="<?php echo $c_revisado; ?>">
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Recurso Fisico </label>
                <div class="col-sm-6">
                    <select class="form-control form-control-lg" id="recurso" name="recurso">
                        <?php
                        // select da tabela de recursos fisicos
                        $c_sql_recursos = "SELECT recursos.id, recursos.descricao FROM recursos ORDER BY recursos.descricao";
                        $result_recursos = $conection->query($c_sql_recursos);
                        while ($c_linha = $result_recursos->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Espaco Fisico </label>
                <div class="col-sm-6">
                    <select class="form-control form-control-lg" id="espaco" name="espaco">
                        <?php
                        // select de espacos fisicos
                        $c_sql_espacos = "SELECT espacos.id, espacos.descricao FROM espacos ORDER BY espacos.descricao";
                        $result_espacos = $conection->query($c_sql_espacos);
                        while ($c_linha = $result_espacos->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Oficina </label>
                <div class="col-sm-6">
                    <select class="form-control form-control-lg" id="oficina" name="oficina">
                        <?php
                        // select de oficinas
                        $c_sql_oficinas = "SELECT oficinas.id, oficinas.descricao FROM oficinas ORDER BY oficinas.descricao";
                        $result_oficinas = $conection->query($c_sql_oficinas);
                        while ($c_linha = $result_oficinas->fetch_assoc()) {
                            echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                        }
                        ?>
                    </select>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Descritivo do POP</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="descritivo" name="descritivo" rows="6"><?php echo $c_descritivo ?></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Processos do POP</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="processo" name="processo" rows="6"><?php echo $c_processo ?></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Resultado Esperado</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="resultado" name="resultado" rows="6"><?php echo $c_resultado ?></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Objetivo</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="objetivo" name="objetivo" rows="6"><?php echo $c_objetivo ?></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Material Necessário</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="material" name="material" rows="6"><?php echo $c_material ?></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Cuidados</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="cuidados" name="cuidados" rows="6"><?php echo $c_cuidados ?></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Riscos</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="risco" name="risco" rows="6"><?php echo $c_riscos ?></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Atividades Críticas</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="atividadecritica" name="atividadecritica" rows="6"><?php echo $c_atividadecritica ?></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">A.N.C</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="anc" name="anc" rows="6"><?php echo $c_anc ?></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-3 col-form-label">Ref. Bibliografica</label>
                <div class="col-sm-6">
                    <textarea class="form-control" id="bibliografia" name="bibliografia" rows="6"><?php echo $c_bibliografia ?></textarea>
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
                    <a class='btn btn-danger' href='/gop/pops_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>