<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include_once "../../lib_gop.php";
include("../../conexao.php");
include("../../links2.php");

$c_descricao = '';
$c_tipo_empresa = '';
$c_contrato = '';
$c_vigencia = '';
$c_resp_contratante = '';
$c_resp_contratada = '';
$c_objeto = '';
$c_iniciais = '';
$c_operacional = '';
$c_email_operacional = '';

$d_inicio = 'dd/mm/yyyy';
$d_termino = 'dd/mm/yyyy';
$c_obs = '';

// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $c_descricao = rtrim($_POST['descricao']);
    $c_marca = $_POST['marca'];
    $c_grupo = $_POST['grupo'];
    $c_unidadesaida = $_POST['unidadesaida'];
    $c_unidadeentrada = $_POST['unidadeentrada'];
    $n_custo = $_POST['custo'];
    $n_qtdmin = $_POST['qtdmin'];
    $n_qtdmax = $_POST['qtdmax'];
    $d_ultimasaida = $_POST['ultimasaida'];
    $d_ultimaentrada = $_POST['ultimaentrada'];
    $n_quantidadeatual = $_POST['quantidadeatual'];
    $d_validade = $_POST['validade'];
    $c_fator = $_POST['fator'];
    $c_obs = $_POST['obs'];

    do {
        if (empty($c_descricao)) {
            $msg_erro = "Campos descrição deve ser preenchidos!!";
            break;
        }
        if (($d_ultimaentrada == null)) {
            $msg_erro = "Campos data da ultima entrada deve ser informado!!";
            break;
        }

        if (($d_ultimasaida == null)) {
            $msg_erro = "Campos data da ultima saida deve ser informado!!";
            break;
        }

        if (($d_validade == null)) {
            $msg_erro = "Campos data de validade deve ser informado!!";
            break;
        }


        // localizo o id do valor do combobox de centro de custos
        // select da tabela de marcas
        $c_sql_secundario = "SELECT marcas.id FROM marcas where marcas.descricao='$c_marca' ORDER BY marcas.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_marca = $registro_secundario['id'];
        // select da tabela de grupos
        $c_sql_secundario = "SELECT grupos.id FROM grupos where grupos.descricao='$c_grupo' ORDER BY grupos.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_grupo = $registro_secundario['id'];
        // select da tabela de unidade com saida
        $c_sql_secundario = "SELECT unidades.id FROM unidades where unidades.descricao='$c_unidadesaida' ORDER BY unidades.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_unidadesaida = $registro_secundario['id'];
        // select da tabela de unidade com entrada
        $c_sql_secundario = "SELECT unidades.id FROM unidades where unidades.descricao='$c_unidadeentrada' ORDER BY unidades.descricao";
        $result_secundario = $conection->query($c_sql_secundario);
        $registro_secundario = $result_secundario->fetch_assoc();
        $i_unidadeentrada = $registro_secundario['id'];

        // grava dados no banco

        // faço a Leitura da tabela com sql
        $c_sql = "Insert into materiais (descricao,  custo, qtdmin, qtdmax, fator, ultimasaida, ultimaentrada, data_validade, quantidadeatual, obs, id_marca, id_grupo, id_unidadesaida, id_unidadeentrada)" .
            "Value ('$c_descricao', '$n_custo', '$n_qtdmin', '$n_qtdmax', '$c_fator', '$d_ultimasaida', '$d_ultimaentrada', '$d_validade', '$n_quantidadeatual', '$c_obs', '$i_marca', '$i_grupo', '$i_unidadesaida', '$i_unidadeentrada')";

        $result = $conection->query($c_sql);
        // verifico se a query foi correto
        if (!$result) {
            die("Erro ao Executar Sql!!" . $conection->connect_error);
        }

        $c_descricao = '';
        $n_custo = 0.0;
        $n_qtdmin = 0;
        $n_qtdmax = 0;
        $d_ultimasaida = 'dd/mm/yyyy';
        $d_ultimaentrada = 'dd/mm/yyyy';
        $n_quantidadeatual = 0;
        $d_validade = 'dd/mm/yyyy';
        $c_obs = '';


        $msg_gravou = "Dados Gravados com Sucesso!!";

        header('location: /gop/cadastros/materiais/materiais_lista.php');
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
    <div class="container -my5">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo Contrato<h5>
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
            <!-- abas de cadastro  -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#apresentacao" aria-controls="apresentacao" role="tab" data-toggle="tab">Apresentação</a></li>
                <li role="presentation"><a href="#descritivo" aria-controls="descritivo" role="tab" data-toggle="tab">Mais Informações</a></li>
            </ul>
            <div class="tab-content">
                <!-- aba da apresentação-->
                <div role="tabpanel" class="tab-pane active" id="apresentacao">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Empresa (*)</label>
                            <div class="col-sm-6">
                                <input type="text" maxlength="120" class="form-control" name="descricao" required value="<?php echo $c_descricao; ?>">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Tipo da Empresa </label>
                            <div class="col-sm-6">
                                <input type="text" maxlength="120" class="form-control" name="tipo_empresa" required value="<?php echo $c_tipo_empresa; ?>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Objeto</label>
                            <div class="col-sm-6">
                                <input type="text" maxlength="150" class="form-control" name="objeto" value="<?php echo $c_objeto; ?>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Dados Iniciais</label>
                            <div class="col-sm-6">
                                <input type="text" maxlength="150" class="form-control" name="iniciais" value="<?php echo $c_iniciais; ?>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">No. de Contrato </label>
                            <div class="col-sm-2">
                                <input type="text" maxlength="30" class="form-control" name="contrato" required value="<?php echo $c_contrato; ?>">
                            </div>
                            <label class="col-sm-1 col-form-label">Vigência (em dias)</label>
                            <div class="col-sm-3">
                                <input type="text" maxlength="80" class="form-control" name="vigencia" value="<?php echo $c_vigencia; ?>">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Início </label>
                            <div class="col-sm-2">
                                <input type="date" maxlength="30" class="form-control" name="inicio" required value="<?php echo $c_inicio; ?>">
                            </div>
                            <label class="col-sm-2 col-form-label">Término</label>
                            <div class="col-sm-2">
                                <input type="date" maxlength="80" class="form-control" name="termino" requerid value="<?php echo $c_termino; ?>">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Centro de Custo</label>
                            <div class="col-sm-6">
                                <select class="form-select form-select-lg mb-3" id="centrodecusto" name="centrodecusto" required>
                                    <option></option>
                                    <?php
                                    // select da tabela de centro de custos
                                    $c_sql_centrocusto = "SELECT centrodecusto.id, centrodecusto.descricao FROM centrodecusto ORDER BY centrodecusto.descricao";
                                    $result_centrocusto = $conection->query($c_sql_centrocusto);
                                    while ($c_linha = $result_centrocusto->fetch_assoc()) {
                                        echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                                    }
                                    ?>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Espaço Físico</label>
                            <div class="col-sm-6">
                                <select class="form-select form-select-lg mb-3" id="espacofisico" name="espacofisico" required>
                                    <option></option>
                                    <?php
                                    // select da tabela de Espacos físicos
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
                            <label class="col-sm-3 col-form-label">Setor</label>
                            <div class="col-sm-6">
                                <select class="form-select form-select-lg mb-3" id="centrodecusto" name="centrodecusto" required>
                                    <option></option>
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
                            <label class="col-sm-3 col-form-label">Observação</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="obs" name="obs" rows="5"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Aba de Mais informações -->
                <div role="tabpanel" class="tab-pane" id="descritivo">
                    <div style="padding-top:15px;padding-left:20px;">
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Resp. Contratante</label>
                            <div class="col-sm-6">
                                <input type="text" maxlength="100" class="form-control" name="resp_contratante" value="<?php echo $c_resp_contratante; ?>">
                            </div>

                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Resp. Contratada</label>
                            <div class="col-sm-6">
                                <input type="text" maxlength="100" class="form-control" name="resp_contratada" value="<?php echo $c_resp_contratada; ?>">
                            </div>
                        </div>

                        <hr>
                        <p>
                        <h5><strong> E-mails:</h5></strong></p>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Operacional</label>
                            <div class="col-sm-6">
                                <input type="email" maxlength="180" class="form-control" name="email_operacional" value="<?php echo $c_email_operacional; ?>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Gerência</label>
                            <div class="col-sm-6">
                                <input type="email" maxlength="180" class="form-control" name="email_gerencia" value="<?php echo $c_email_gerencia; ?>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Diretoria</label>
                            <div class="col-sm-6">
                                <input type="email" maxlength="180" class="form-control" name="email_diretoria" value="<?php echo $c_email_diretoria; ?>">
                            </div>
                        </div>
                        <hr>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Informação de Denuncia</label>
                            <div class="col-sm-6">
                                <input type="text" maxlength="180" class="form-control" name="denuncia" value="<?php echo $c_denuncia; ?>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Valor Mensal</label>
                            <div class="col-sm-2">
                                <input placeholder="valor Mensal" type="text" data-thousands="." data-decimal=","
                                    data-prefix="R$ " class="form-control" id="valor" name="valor" value="<?php echo $c_valor ?>">
                            </div>
                            <label class="col-sm-3 col-form-label">Reajuste (%)</label>
                            <div class="col-sm-1">
                                <input type="text" data-thousands="." data-decimal=","
                                    class="form-control" id="valor" name="reajuste" value="<?php echo $c_reajuste ?>">
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
                    <a class='btn btn-danger' href='/gop/cadastros/materiais/materiais_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                </div>

            </div>
        </form>
    </div>

</body>

</html>