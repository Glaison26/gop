<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include('links2.php');
include('conexao.php');
// funções 

function carregadados()
{
    $c_descricao = $_POST['descricao'];
    $c_patrimonio = $_POST['patrimonio'];
    $c_modelo = $_POST['modelo'];
    $c_numeroserie = $_POST['numeroserie'];
    $c_estado = $_POST['estado'];
    $c_notafiscal = $_POST['notafiscal'];

    $d_datacadastro = '';


    $d_datagarantia =  new DateTime($_POST['datagarantia']);
    $d_datagarantia = $d_datagarantia->format('Y-m-d');

    $d_dataaquisicao =  new DateTime($_POST['dataaquisicao']);
    $d_dataaquisicao = $d_dataaquisicao->format('Y-m-d');

    $d_ultimapreventiva = new DateTime($_POST['ultimapreventiva']);
    $d_ultimapreventiva = $d_ultimapreventiva->format('Y-m-d');

    $d_dataultimamanutencao = new DateTime($_POST['dataultimamanutencao']);
    $d_dataultimamanutencao = $d_dataultimamanutencao->format('Y-m-d');

    $n_valordepreciado = $_POST['valordepreciado'];
    $n_valoraquisicao = $_POST['valoraquisicao'];
    $c_ativo = $_POST['ativo'];
    $c_motivo = $_POST['motivo'];
    $c_anvisa = $_POST['anvisa'];
    $c_grupo = $_POST['grupo'];
    $c_marca = $_POST['marca'];
    $c_fornecedor = $_POST['fornecedor'];
    $c_fabricante = $_POST['fabricante'];
    $c_espaco = $_POST['espaco'];
    $c_centrodecusto = $_POST['centrodecusto'];
    $c_oficina = $_POST['oficina'];
    $c_setor = $_POST['setor'];
    $c_obs = $_POST['obs'];
}

include_once "lib_gop.php";

$c_descricao = '';
$c_patrimonio = '';
$c_modelo = '';
$c_numeroserie = '';
$c_estado = '';
$c_notafiscal = '';
date_default_timezone_set('America/Sao_Paulo');
$d_datacadastro = date('d/m/Y');

$d_datagarantia = '';
$n_valoraquisicao = '0.00';
$n_valordepreciado = '0.00';
$d_ultimapreventiva = '';
$d_dataultimamanutencao = '';
$d_dataaquisicao = '';
$c_ativo = '';
$c_motivo = '';
$c_anvisa = '';
$c_grupo = '';
$c_marca = '';
$c_fornecedor = '';
$c_fabricante = '';
$c_espaco = '';
$c_centrodecusto = '';
$c_oficina = '';
$c_obs = '';



// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $c_descricao = $_POST['descricao'];
    $c_patrimonio = $_POST['patrimonio'];
    $c_modelo = $_POST['modelo'];
    $c_numeroserie = $_POST['numeroserie'];
    $c_estado = $_POST['estado'];
    $c_notafiscal = $_POST['notafiscal'];

    $d_datacadastro =  new DateTime($_POST['datacadastro']);
    $d_datacadastro = $d_datacadastro->format('Y-m-d');

    $d_datagarantia =  new DateTime($_POST['datagarantia']);
    $d_datagarantia = $d_datagarantia->format('Y-m-d');

    $d_dataaquisicao =  new DateTime($_POST['dataaquisicao']);
    $d_dataaquisicao = $d_dataaquisicao->format('Y-m-d');

    $d_ultimapreventiva = new DateTime($_POST['ultimapreventiva']);
    $d_ultimapreventiva = $d_ultimapreventiva->format('Y-m-d');

    $d_dataultimamanutencao = new DateTime($_POST['dataultimamanutencao']);
    $d_dataultimamanutencao = $d_dataultimamanutencao->format('Y-m-d');

    $n_valordepreciado = $_POST['valordepreciado'];
    $n_valoraquisicao = $_POST['valoraquisicao'];
    $c_ativo = $_POST['ativo'];
    $c_motivo = $_POST['motivo'];
    $c_anvisa = $_POST['anvisa'];
    $c_grupo = $_POST['grupo'];
    $c_marca = $_POST['marca'];
    $c_fornecedor = $_POST['fornecedor'];
    $c_fabricante = $_POST['fabricante'];
    $c_espaco = $_POST['espaco'];
    $c_centrodecusto = $_POST['centrodecusto'];
    $c_oficina = $_POST['oficina'];
    $c_setor = $_POST['setor'];
    $c_obs = $_POST['obs'];

    do {
        if (empty($c_descricao) || empty($c_patrimonio) || empty($c_modelo) || empty($c_notafiscal)) {
            $msg_erro = "Campos Descrição, patrimonio, modelo, nota fiscal devem ser preenchidos!!";
            Carregadados();
            break;
            if (($d_dataaquisicao == null)) {
                $msg_erro = "Campos data da aquisição deve ser informado!!";
                Carregadados();
                break;
            }

            if (($d_datagarantia == null)) {
                $msg_erro = "Campos data da garantia deve ser informado!!";
                Carregadados();
                break;
            }

            if (($d_dataultimamanutencao == null)) {
                $msg_erro = "Campos data da ultima manutenção deve ser informado!!";
                Carregadados();
                break;
            }
            if (($d_ultimapreventiva == null)) {
                $msg_erro = "Campos data da ultima preventiva deve ser informado!!";
                Carregadados();
                break;
            }
        }

        // verifico a id do grupo selecionado no combo
        $c_sql_secundario = "SELECT grupos.id FROM grupos where grupos.descricao='$c_grupo' ORDER BY grupos.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_grupo = $registro_secundario['id'];
        // verifico a id do marca selecionado no combo 
        $c_sql_secundario = "SELECT marcas.id FROM marcas where marcas.descricao='$c_marca' ORDER BY marcas.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_marca = $registro_secundario['id'];
        // verifico a id do fornecedores selecionado no combo 
        $c_sql_secundario = "SELECT fornecedores.id FROM fornecedores where fornecedores.descricao='$c_fornecedor' ORDER BY fornecedores.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_fornecedor = $registro_secundario['id'];
        // verifico a id do fabricantes selecionado no combo 
        $c_sql_secundario = "SELECT fabricantes.id FROM fabricantes where fabricantes.descricao='$c_fabricante' ORDER BY fabricantes.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_fabricante = $registro_secundario['id'];
        // verifico a id do espaço fisico selecionado no combo 
        $c_sql_secundario = "SELECT espacos.id FROM espacos where espacos.descricao='$c_espaco' ORDER BY espacos.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_espaco = $registro_secundario['id'];
        // verifico a id do centro de custo selecionado no combo 
        $c_sql_secundario = "SELECT centrodecusto.id FROM centrodecusto where centrodecusto.descricao='$c_centrodecusto' ORDER BY centrodecusto.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_centrodecusto = $registro_secundario['id'];
        // verifico a id da oficina selecionado no combo 
        $c_sql_secundario = "SELECT oficinas.id FROM oficinas where oficinas.descricao='$c_oficina' ORDER BY oficinas.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_oficina = $registro_secundario['id'];
        // verifico a id da oficina selecionado no combo 
        $c_sql_secundario = "SELECT setores.id FROM setores where setores.descricao='$c_setor' ORDER BY setores.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_setor = $registro_secundario['id'];
        // grava dados no banco

        // faço a inclusão da tabela com sql
        $c_sql = "INSERT INTO recursos (id_espacofisico, id_fabricante, id_fornecedor, id_grupo, id_centrodecusto, id_oficina, id_setor, id_marca, descricao, patrimonio," .
            " modelo, numeroserie, estado, notafiscal, datacadastro, datagarantia, valoraquisicao, valordepreciado, ultimapreventiva, ultimamanutencao," .
            " dataaquisicao, ativo, motivoinativo, reganvisa, obs) VALUES ('$i_espaco', '$i_fabricante', '$i_fornecedor', '$i_grupo', '$i_centrodecusto', '$i_oficina', '$i_setor'," .
            " '$i_marca', '$c_descricao', '$c_patrimonio' ,'$c_modelo', '$c_numeroserie', '$c_estado', '$c_notafiscal', '$d_datacadastro', '$d_datagarantia', '$n_valoraquisicao'," .
            " '$n_valordepreciado', '$d_ultimapreventiva', '$d_dataultimamanutencao', '$d_dataaquisicao','$c_ativo','$c_motivo', '$c_anvisa', '$c_obs')";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }


        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/recursos_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script type="text/javascript">
        $(document).ready(function() {
            $("#fone1").mask("(99)9999-9999");
            $("#fone2").mask("(99)9999-9999");
            $("#cnpj_cpf").mask("999999999999999999");
            $("#cep").mask("99.999-999");
        });
    </script>

</head>


<body>
    <div class="container  -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo Recurso Físico<h5>
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
            <!-- abas de cadastro e cadstro de recursos -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#apresentacao" aria-controls="apresentacao" role="tab" data-toggle="tab">Apresentação</a></li>
                <li role="presentation"><a href="#definicao" aria-controls="cadastro" role="tab" data-toggle="tab">Definição e Localização</a></li>
                <li role="presentation"><a href="#outras" aria-controls="definicao" role="tab" data-toggle="tab">Outras Informações</a></li>
                <li role="presentation"><a href="#obs" aria-controls="obs" role="tab" data-toggle="tab">Observações</a></li>
            </ul>
            <!-- aba da agenda-->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="apresentacao">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-5">
                            <div class="form-check col-sm-5">
                                <div class="col-sm-5">
                                    <label class="form-check-label col-form-label">Recurso Ativo</label>
                                    <div class="col-sm-3">
                                        <input class="form-check-input" type="checkbox" value="S" name="ativo" id="ativo" checked>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Descrição (*)</label>
                            <div class="col-sm-6">
                                <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Patrimônio no. (*)</label>
                            <div class="col-sm-3">
                                <input type="text" maxlength="20" class="form-control" name="patrimonio" value="<?php echo $c_patrimonio; ?>">
                            </div>
                            <label class="col-sm-1 col-form-label">No. Série</label>
                            <div class="col-sm-2">
                                <input type="text" maxlength="20" class="form-control" name="numeroserie" value="<?php echo $c_numeroserie; ?>">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Modelo (*)</label>
                            <div class="col-sm-6">
                                <input type="text" maxlength="90" class="form-control" name="modelo" value="<?php echo $c_modelo; ?>">
                            </div>
                        </div>
                        <hr>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Fornecedor </label>
                            <div class="col-sm-6">
                                <select class="form-select form-select-lg mb-3" id="fornecedor" name="fornecedor">
                                    <?php
                                    // select da tabela de fornecedores
                                    $c_sql_fornecedores = "SELECT fornecedores.id, fornecedores.descricao FROM fornecedores ORDER BY fornecedores.descricao";
                                    $result_fornecedores = $conection->query($c_sql_fornecedores);
                                    while ($c_linha = $result_fornecedores->fetch_assoc()) {
                                        echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Fabricante </label>
                            <div class="col-sm-6">
                                <select class="form-select form-select-lg mb-3" id="fabricante" name="fabricante">
                                    <?php
                                    // select da tabela de fabricantes
                                    $c_sql_fabricante = "SELECT fabricantes.id, fabricantes.descricao FROM fabricantes ORDER BY fabricantes.descricao";
                                    $result_fabricante = $conection->query($c_sql_fabricante);
                                    while ($c_linha = $result_fabricante->fetch_assoc()) {
                                        echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>

                    </div>
                </div> <!-- fim da aba do cadastro -->
                <!-- aba da definição e localização -->

                <div role="tabpanel" class="tab-pane" id="definicao">
                    <div style="padding-top:10px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Oficina </label>
                            <div class="col-sm-2">
                                <select class="form-select form-select-lg mb-3" id="oficina" name="oficina">
                                    <?php
                                    // select da tabela de oficinas
                                    $c_sql_oficina = "SELECT oficinas.id, oficinas.descricao FROM oficinas ORDER BY oficinas.descricao";
                                    $result_oficina = $conection->query($c_sql_oficina);
                                    while ($c_linha = $result_oficina->fetch_assoc()) {
                                        echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                                    }
                                    ?>
                                </select>
                            </div>
                            <label class="col-sm-2 col-form-label">Marca </label>
                            <div class="col-sm-2">
                                <select class="form-select form-select-lg mb-3" id="marca" name="marca">
                                    <?php
                                    // select da tabela de Marcas
                                    $c_sql_marca = "SELECT marcas.id, marcas.descricao FROM marcas ORDER BY marcas.descricao";
                                    $result_marca = $conection->query($c_sql_marca);
                                    while ($c_linha = $result_marca->fetch_assoc()) {
                                        echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Espaço Físico </label>
                            <div class="col-sm-4">
                                <select class="form-select form-select-lg mb-3" id="espaco" name="espaco">
                                    <?php
                                    // select da tabela de espacos fisicos
                                    $c_sql_espacos = "SELECT espacos.id, espacos.descricao FROM espacos ORDER BY espacos.descricao";
                                    $result_espaco = $conection->query($c_sql_espacos);
                                    while ($c_linha = $result_espaco->fetch_assoc()) {
                                        echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Centro de Custo </label>
                            <div class="col-sm-4">
                                <select class="form-select form-select-lg mb-3" id="centrodecusto" name="centrodecusto">
                                    <?php
                                    // select da tabela de centro de custo
                                    $c_sql_custo = "SELECT centrodecusto.id, centrodecusto.descricao FROM centrodecusto ORDER BY centrodecusto.descricao";
                                    $result_custo = $conection->query($c_sql_custo);
                                    while ($c_linha = $result_custo->fetch_assoc()) {
                                        echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Grupo </label>
                            <div class="col-sm-4">
                                <select class="form-select form-select-lg mb-3" id="grupo" name="grupo">
                                    <?php
                                    // select da tabela de grupos
                                    $c_sql_grupo = "SELECT grupos.id, grupos.descricao FROM grupos ORDER BY grupos.descricao";
                                    $result_grupo = $conection->query($c_sql_grupo);
                                    while ($c_linha = $result_grupo->fetch_assoc()) {
                                        echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Setor </label>
                            <div class="col-sm-4">
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
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Nota Fiscal (*)</label>
                            <div class="col-sm-2">
                                <input type="text" maxlength="20" class="form-control" name="notafiscal" value="<?php echo $c_notafiscal; ?>">
                            </div>
                            <label class="col-sm-2 col-form-label">Data de Aquisição</label>
                            <div class="col-sm-2">
                                <input type="date" class="form-control" name="dataaquisicao" value="<?php echo $d_dataaquisicao; ?>">
                            </div>
                        </div>

                    </div>

                </div> <!-- fim da aba de definição e localização -->

                <div role="tabpanel" class="tab-pane" id="outras">
                    <div style="padding-top:10px;padding-left:20px;">
                        <div class="row mb-5">

                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Conservação</label>
                                <div class="col-sm-2">
                                    <select class="form-select form-select-lg mb-3" id="estado" name="estado" value="<?php echo $c_estado; ?>">
                                        <option>Ótimo</option>
                                        <option>Muito Bom</option>
                                        <option>Bom</option>
                                        <option>Razoável</option>
                                        <option>Ruim</option>
                                        <option>Péssimo</option>
                                    </select>
                                </div>
                                <label class="col-sm-2 col-form-label">Data de Garantia</label>
                                <div class="col-sm-2">
                                    <input type="date" class="form-control" name="datagarantia" value="<?php echo $d_datagarantia; ?>">
                                </div>
                            </div>
                            <div class="row mb-3">

                                <label class="col-sm-3 col-form-label">Data de Cadastro</label>
                                <div class="col-sm-2">

                                    <input type="date" class="form-control" id="datacadastro" name="datacadastro" value="<?php echo $d_datacadastro; ?>">
                                </div>
                                <label class="col-sm-2 col-form-label">Valor Aquisição</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" name="valoraquisicao" value="<?php echo $n_valoraquisicao; ?>">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Ultima Preventiva</label>
                                <div class="col-sm-2">
                                    <input type="date" maxlength="20" class="form-control" name="ultimapreventiva" value="<?php echo $d_ultimapreventiva; ?>">
                                </div>
                                <label class="col-sm-2 col-form-label">Ultima Manutenção</label>
                                <div class="col-sm-2">
                                    <input type="date" class="form-control" name="dataultimamanutencao" value="<?php echo $d_dataultimamanutencao; ?>">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Valor Depreciado</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" name="valordepreciado" value="<?php echo $n_valordepreciado; ?>">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Motivo Inatividade</label>
                                <div class="col-sm-6">
                                    <input type="text" maxlength="100" class="form-control" name="motivo" value="<?php echo $c_motivo; ?>">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Reg. Anvisa</label>
                                <div class="col-sm-3">
                                    <input type="text" maxlength="20" class="form-control" name="anvisa" value="<?php echo $c_anvisa; ?>">
                                </div>
                            </div>
                        </div>
                    </div>

                </div> <!-- fim da aba de outros -->

                <div role="tabpanel" class="tab-pane" id="obs">
                    <div style="padding-top:10px;padding-left:20px;">
                        <div class="row mb-6">
                            <label class="col-sm-2 col-form-label">Observação</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="obs" name="obs" rows="10"></textarea>
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
            <br>
            <div class="row mb-3">
                <div class="offset-sm-0 col-sm-3">
                    <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                    <a class='btn btn-danger' href='/gop/recursos_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>
            </div>
        </form>
    </div>

</body>

</html>