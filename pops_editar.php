<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}



include("conexao.php");
include("links2.php");
include_once "lib_gop.php";

// rotina de post dos dados do formuário
$c_id = "";
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


if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/pops_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do cliente através de sql usando id passada
    $c_sql = "select * from pops where id=$c_id";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/pops_lista.php');
        exit;
    }
    $c_tipo = $registro['tipo'];
    $c_descricao = $registro['descricao'];
    $c_resultado = $registro['resultadoesperado'];
    $c_descritivo = $registro['descritivo'];
    $c_material = $registro['materialnecessario'];
    $c_atividadecritica = $registro['atividadecritica'];
    $c_cuidados = $registro['cuidados'];
    $c_anc = $registro['anc'];
    $c_processo = $registro['processo'];
    $c_objetivo = $registro['objetivo'];
    $c_risco = $registro['risco'];
    $c_bibliografia = $registro['refbibliografica'];
    $c_preparado = $registro['preparado'];
    $c_revisado = $registro['revisado'];
    //
    $i_recurso = $registro['id_recurso'];
    $i_espaco = $registro['id_espaco'];
    $i_oficina = $registro['id_oficina'];
    //

} else {
    // metodo post para atualizar dados
    $c_id = $_GET["id"];
    $c_resultado = $_POST['resultado'];
    $c_descricao = $_POST['descricao'];
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
    $c_preparado = $_POST['preparado'];
    $c_revisado = $_POST['revisado'];
    $c_tipo = $_POST['tipopop'];
    $c_data =  new DateTime(date('d-m-Y'));
    $c_data = $c_data->format('Y-m-d');

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
        $c_sql = "Update pops" .
            " SET descricao='$c_descricao', revisado='$c_revisado', preparado='$c_preparado', resultadoesperado='$c_resultado', materialnecessario='$c_material'" .
            ", descritivo='$c_descritivo', atividadecritica='$c_atividadecritica', cuidados='$c_cuidados', anc='$c_anc', data='$c_data'," .
            "processo='$c_processo', objetivo='$c_objetivo', risco='$c_risco', refbibliografica='$c_bibliografia', tipo='$c_tipo'" .
            ", id_recurso='$i_idrecurso', id_espaco='$i_idespaco', id_oficina='$i_idoficina'" .
            " where id=$c_id";

        $result = $conection->query($c_sql);

        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }
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
</head>

<body>
    <div class="container  -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Edição de POP<h5>
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
            <!-- abas de cadastro e cadstro de pops -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#apresentacao" aria-controls="apresentacao" role="tab" data-toggle="tab">Apresentação</a></li>
                <li role="presentation"><a href="#descritivo" aria-controls="descritivo" role="tab" data-toggle="tab">Descritivo</a></li>
                <li role="presentation"><a href="#processos" aria-controls="processos" role="tab" data-toggle="tab">Processos</a></li>
                <li role="presentation"><a href="#resultado" aria-controls="resultado" role="tab" data-toggle="tab">Resultados Esperados</a></li>
                <li role="presentation"><a href="#objetivo" aria-controls="objetivo" role="tab" data-toggle="tab">Objetivo</a></li>
                <li role="presentation"><a href="#material" aria-controls="material" role="tab" data-toggle="tab">Materiais Necessários</a></li>
                <li role="presentation"><a href="#cuidados" aria-controls="cuidados" role="tab" data-toggle="tab">Cuidados</a></li>
                <li role="presentation"><a href="#riscos" aria-controls="riscos" role="tab" data-toggle="tab">Riscos</a></li>
                <li role="presentation"><a href="#criticas" aria-controls="criticas" role="tab" data-toggle="tab">Atividades Críticas</a></li>
                <li role="presentation"><a href="#anc" aria-controls="anc" role="tab" data-toggle="tab">Não conformidades</a></li>
                <li role="presentation"><a href="#bibliografia" aria-controls="bibliografia" role="tab" data-toggle="tab">Bibliografia</a></li>
            </ul>


            <div class="tab-content">
                <!-- aba da apresentação-->
                <div role="tabpanel" class="tab-pane active" id="apresentacao">
                    <div style="padding-top:15px;padding-left:20px;">
                        <input type="hidden" name="id" value="<?php echo $c_id; ?>">
                        <div class="row mb-3">
                            <div class="form-check" class="col-sm-6">
                                <strong>Tipo do POP</strong><br><br>
                                <input type="radio" name="tipopop" id="tipo1" value="1"  <?= ($c_tipo == '1') ? 'checked' : '' ?>>
                                <label class="form-check-label" for="tipo1">
                                    Administrativo
                                </label>
                                <input type="radio" name="tipopop" id="tipo2" value="2"  <?= ($c_tipo == '2') ? 'checked' : '' ?>>
                                <label class="form-check-label" for="tipo2">
                                    Edificação
                                </label>
                                <input type="radio" name="tipopop" id="tipo3" value="3"  <?= ($c_tipo == '3') ? 'checked' : '' ?>>
                                <label class="form-check-label" for="tipo3">
                                    Equipamento
                                </label>
                                <input type="radio" name="tipopop" id="tipo4" value="4"  <?= ($c_tipo == '4') ? 'checked' : '' ?>>
                                <label class="form-check-label" for="tipo4">
                                    Instalação
                                </label>
                                <input type="radio" name="tipopop" id="tipo5" value="5"  <?= ($c_tipo == '5') ? 'checked' : '' ?>>
                                <label class="form-check-label" for="tipo5">
                                    Mobiliário
                                </label>
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
                                <select class="form-select form-select-lg mb-3" id="recurso" name="recurso">
                                    <?php
                                    // select da tabela de recursos fisicos
                                    $c_sql_recursos = "SELECT recursos.id, recursos.descricao FROM recursos ORDER BY recursos.descricao";
                                    $result_recursos = $conection->query($c_sql_recursos);
                                    while ($c_linha = $result_recursos->fetch_assoc()) {
                                        if ($c_linha['id'] == $i_recurso) {
                                            $op = 'selected';
                                        } else {
                                            $op = '';
                                        }
                                        echo "  
                          <option $op>$c_linha[descricao]</option>
                        ";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Espaco Fisico </label>
                            <div class="col-sm-6">
                                <select class="form-select form-select-lg mb-3" id="espaco" name="espaco">
                                    <?php
                                    // select de espacos fisicos
                                    $c_sql_espacos = "SELECT espacos.id, espacos.descricao FROM espacos ORDER BY espacos.descricao";
                                    $result_espacos = $conection->query($c_sql_espacos);
                                    while ($c_linha = $result_espacos->fetch_assoc()) {
                                        if ($c_linha['id'] == $i_espaco) {
                                            $op = 'selected';
                                        } else {
                                            $op = '';
                                        }
                                        echo "<option $op>$c_linha[descricao]</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Oficina </label>
                            <div class="col-sm-6">
                                <select class="form-select form-select-lg mb-3" id="oficina" name="oficina">
                                    <?php
                                    // select de oficinas
                                    $c_sql_oficinas = "SELECT oficinas.id, oficinas.descricao FROM oficinas ORDER BY oficinas.descricao";
                                    $result_oficinas = $conection->query($c_sql_oficinas);
                                    while ($c_linha = $result_oficinas->fetch_assoc()) {
                                        if ($c_linha['id'] == $i_oficina) {
                                            $op = 'selected';
                                        } else {
                                            $op = '';
                                        }
                                        echo "<option $op>$c_linha[descricao]</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- aba descritivo -->
                <div role="tabpanel" class="tab-pane" id="descritivo">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Descritivo do POP</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="descritivo" name="descritivo" rows="6"><?php echo $c_descritivo ?></textarea>
                            </div>
                        </div>

                    </div>
                </div>
                <!-- aba da processos -->
                <div role="tabpanel" class="tab-pane" id="processos">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Processos do POP</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="processo" name="processo" rows="6"><?php echo $c_processo ?></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- aba resultados esperados-->
                <div role="tabpanel" class="tab-pane" id="resultado">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Resultado Esperado</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="resultado" name="resultado" rows="6"><?php echo $c_resultado ?></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- aba objetivo -->
                <div role="tabpanel" class="tab-pane" id="objetivo">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Objetivo</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="objetivo" name="objetivo" rows="6"><?php echo $c_objetivo ?></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- aba da materiais ncessários-->
                <div role="tabpanel" class="tab-pane" id="material">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Material Necessário</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="material" name="material" rows="6"><?php echo $c_material ?></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- aba da cuidados necessários-->
                <div role="tabpanel" class="tab-pane" id="cuidados">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Cuidados</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="cuidados" name="cuidados" rows="6"><?php echo $c_cuidados ?></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- aba riscos-->
                <div role="tabpanel" class="tab-pane" id="riscos">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Riscos</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="risco" name="risco" rows="6"><?php echo $c_riscos ?></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- aba da atividades criticas-->
                <div role="tabpanel" class="tab-pane" id="criticas">
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">Atividades Críticas</label>
                        <div class="col-sm-6">
                            <textarea class="form-control" id="atividadecritica" name="atividadecritica" rows="6"><?php echo $c_atividadecritica ?></textarea>
                        </div>
                    </div>
                    <div style="padding-top:15px;padding-left:20px;">

                    </div>
                </div>
                <!-- aba da apresentação-->
                <div role="tabpanel" class="tab-pane" id="anc">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">A.N.C</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="anc" name="anc" rows="6"><?php echo $c_anc ?></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- aba da bibliografia -->
                <div role="tabpanel" class="tab-pane" id="bibliografia">
                    <div style="padding-top:15px;padding-left:20px;">

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Ref. Bibliografica</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="bibliografia" name="bibliografia" rows="6"><?php echo $c_bibliografia ?></textarea>
                            </div>
                        </div>
                    </div>
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
            
            <hr>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/pops_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>

        </form>
    </div>

</body>

</html>