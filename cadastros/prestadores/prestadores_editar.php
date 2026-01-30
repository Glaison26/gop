<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include('../../conexao.php');
include('../../links2.php');
// código para editar prestadores de serviço cadastrados no sistema
// sql para pegar os dados da tabela prestadores
$i_id = $_GET['id'];
$c_sql = "select * from prestadores where id='$i_id'";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
$c_nome = $registro['nome'];
$c_id_tipo = $registro['id_tipo'];
$c_razao = $registro['razao_social'];
$c_cnpj = $registro['cnpj'];
$c_contato = $registro['contato'];
$c_fone1 = $registro['telefone1'];
$c_fone2 = $registro['telefone2'];
$c_endereco = $registro['endereco'];
$c_bairro = $registro['bairro'];
$c_cidade = $registro['cidade'];
$c_cep = $registro['cep'];
$c_email = $registro['email'];
$c_site = $registro['site'];
$c_observacao = $registro['observacao'];
$c_status = $registro['ativa'];
$c_estado = $registro['uf'];
$c_valor_contrato = $registro['valor_contrato'];
$c_valor_visita = $registro['valor_visita'];
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // recebo os dados do formulário
    $c_nome = $_POST['descricao'];
    $c_id_tipo = $_POST['grupo'];
    $c_razao = $_POST['razaosocial'];
    $c_cnpj = $_POST['cnpj'];
    $c_contato = $_POST['contato'];
    $c_fone1 = $_POST['fone1'];
    $c_fone2 = $_POST['fone2'];
    $c_endereco = $_POST['endereco'];
    $c_bairro = $_POST['bairro'];
    $c_cidade = $_POST['cidade'];
    $c_cep = $_POST['cep'];
    $c_email = $_POST['email'];
    $c_site = $_POST['url'];
    $c_estado = $_POST['estado'];
    $c_observacao = $_POST['obs'];
    $c_ativa = $_POST['status'];
    // status igual "S" para ativo e "N" para inativo
    if ($c_ativa == 'Ativo') {
        $c_ativa = 'S';
    } else {
        $c_ativa = 'N';
    }
    
    $c_valor_contrato = number_format($_POST['valor_contrato'], 2, '.', '');
    $c_valor_visita = number_format($_POST['valor_visita'], 2, '.', '');

    // sql para atualizar os dados do prestador no banco de dados
    $c_sql_update = "update prestadores set nome='$c_nome', id_tipo='$c_id_tipo', razao_social='$c_razao',
    cnpj='$c_cnpj', contato='$c_contato', telefone1='$c_fone1', telefone2='$c_fone2',
    endereco='$c_endereco', bairro='$c_bairro', cidade='$c_cidade', cep='$c_cep', uf='$c_estado',
    email='$c_email', site='$c_site', observacao='$c_observacao', ativa='$c_ativa',
    valor_contrato='$c_valor_contrato', valor_visita='$c_valor_visita', observacao='$c_observacao', site='$c_site' where id='$i_id'";

    $result_update = $conection->query($c_sql_update);
    if ($result_update) {
        header('Location: /gop/cadastros/prestadores/prestadores_lista.php');
        exit();
    } else {
        die("Erro ao atualizar prestador: " . $conection->error);
    }
}
?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GOP - Edição de Prestadores de Serviços</title>
    <link rel="stylesheet" href="/gop/css/basico.css">

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

        const handleCNPJ = (event) => {
            let input = event.target
            input.value = cnpjMask(input.value)
        }
    </script>
</head>

<body>
    <!-- html com formulário para editar prestadores de serviço cadastrados no sistema -->
    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <div style="padding-left:15px;padding-top:15px;">
                        <!--<img Align="left" src="\gop\images\cadastro.png" alt="" width="60" height="45">-->

                    </div>
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Edição de Prestador de Serviço<h5>
                </div>
            </div>
        </div>


        <br>
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
                    <h5>Preencha o formulário abaixo para editar o prestador de serviço</h5>
                </div>
            </div>
            <form method="POST" action="">
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
                    <label class="col-sm-3 col-form-label">Prestador *</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_nome; ?>" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Grupo * </label>
                    <div class="col-sm-4">
                        <!-- selecionar grupo fornecedor com id e descricao do grupo retornando a id no select -->
                        <select class="form-select form-select-lg mb-3" id="grupo" name="grupo" required>
                            <option value="">Selecione o Grupo</option>
                            <?php
                            $sql_grupos = "SELECT id,descricao FROM grupos_fornecedores ORDER BY descricao ASC";
                            $result_grupos = $conection->query($sql_grupos);
                            if ($result_grupos->num_rows > 0) {
                                while ($row = $result_grupos->fetch_assoc()) {
                                    if ($c_linha['id'] == $i_id_grupo) {
                                        $op =  'Selected';
                                    } else {
                                        $op = '';
                                    }
                                    $selected = ($row['id'] == (isset($_POST['grupo']) ? $_POST['grupo'] : '')) ? 'selected' : '';
                                    echo "<option value='" . $row['id'] . "' $op>" . $row['descricao'] . "</option>";
                                }
                            }
                            ?>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Razão Social *</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="120" class="form-control" name="razaosocial" id="razaosocial" value="<?php echo $c_razao; ?>" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">CNPJ *</label>
                    <div class="col-sm-4">
                        <input type="text" onkeyup="handleCNPJ(event)" maxlength="18" id="cnpj" class="form-control" name="cnpj" value="<?php echo $c_cnpj; ?>" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Contato *</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="100" class="form-control" name="contato" value="<?php echo $c_contato; ?>" required>
                    </div>
                </div>

                <hr>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Fone I *</label>
                    <div class="col-sm-2">
                        <input type="tel" onkeyup="handlePhone(event)" maxlength="20" id="fone1" class="form-control" name="fone1" value="<?php echo $c_fone1; ?>" required>
                    </div>
                    <label class="col-sm-2 col-form-label">Fone II</label>
                    <div class="col-sm-2">
                        <input type="tel" onkeyup="handlePhone(event)" maxlength="20" id="fone2" class="form-control" name="fone2" value="<?php echo $c_fone2; ?>">
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Endereço</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="120" id="endereco" class="form-control" name="endereco" value="<?php echo $c_endereco; ?>">
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Bairro</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="100" id="bairro" class="form-control" name="bairro" value="<?php echo $c_bairro; ?>">
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Cidade</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="100" id="cidade" class="form-control" name="cidade" value="<?php echo $c_cidade; ?>">
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Estado</label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="estado" name="estado">
                            <option value="AC" <?= ($c_estado == 'AC') ? 'selected' : '' ?>>Acre</option>
                            <option value="AL" <?= ($c_estado == 'AL') ? 'selected' : '' ?>>Alagoas</option>
                            <option value="AP" <?= ($c_estado == 'AP') ? 'selected' : '' ?>>Amapa</option>
                            <option value="AM" <?= ($c_estado == 'AM') ? 'selected' : '' ?>>Amazonas</option>
                            <option value="BA" <?= ($c_estado == 'BA') ? 'selected' : '' ?>>Bahia</option>
                            <option value="CE" <?= ($c_estado == 'CE') ? 'selected' : '' ?>>Ceara</option>
                            <option value="DF" <?= ($c_estado == 'DF') ? 'selected' : '' ?>>Distrito Federal</option>
                            <option value="ES" <?= ($c_estado == 'ES') ? 'selected' : '' ?>>Espirito Santo</option>
                            <option value="GO" <?= ($c_estado == 'GO') ? 'selected' : '' ?>>Goias</option>
                            <option value="MA" <?= ($c_estado == 'MA') ? 'selected' : '' ?>>Maranhão</option>
                            <option value="MT" <?= ($c_estado == 'MT') ? 'selected' : '' ?>>Mato Grosso</option>
                            <option value="MS" <?= ($c_estado == 'MS') ? 'selected' : '' ?>>Mato Grosso do Sul</option>
                            <option value="MG" <?= ($c_estado == 'MG') ? 'selected' : '' ?>>Minas Gerais</option>
                            <option value="PA" <?= ($c_estado == 'PA') ? 'selected' : '' ?>>Para</option>
                            <option value="PB" <?= ($c_estado == 'PB') ? 'selected' : '' ?>>Paraiba</option>
                            <option value="PR" <?= ($c_estado == 'PR') ? 'selected' : '' ?>>Parana</option>
                            <option value="PE" <?= ($c_estado == 'PE') ? 'selected' : '' ?>>Pernambuco</option>
                            <option value="PI" <?= ($c_estado == 'PI') ? 'selected' : '' ?>>Piaui</option>
                            <option value="RJ" <?= ($c_estado == 'RJ') ? 'selected' : '' ?>>Rio de Janeiro</option>
                            <option value="RN" <?= ($c_estado == 'RN') ? 'selected' : '' ?>>Rio Grande do Norte</option>
                            <option value="RS" <?= ($c_estado == 'RS') ? 'selected' : '' ?>>Rio Grande do Sul</option>
                            <option value="RO" <?= ($c_estado == 'RO') ? 'selected' : '' ?>>Rondonia</option>
                            <option value="RR" <?= ($c_estado == 'RR') ? 'selected' : '' ?>>Roraima</option>
                            <option value="SC" <?= ($c_estado == 'SC') ? 'selected' : '' ?>>Santa Catarina</option>
                            <option value="SP" <?= ($c_estado == 'SP') ? 'selected' : '' ?>>São Paulo</option>
                            <option value="SE" <?= ($c_estado == 'SE') ? 'selected' : '' ?>>Sergipe</option>
                            <option value="TO" <?= ($c_estado == 'TO') ? 'selected' : '' ?>>Tocantis</option>
                        </select>
                    </div>
                    <label class="col-sm-1 col-form-label">CEP</label>
                    <div class="col-sm-2">
                        <input type="text" maxlength="10" id="cep" class="form-control" name="cep" value="<?php echo $c_cep; ?>">
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">E-mail</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="120" id="email" class="form-control" name="email" placeholder="E-mail" value="<?php echo $c_email; ?>">
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Site</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="120" id="url" class="form-control col-xs-12" name="url" value="<?php echo $c_site; ?>">
                    </div>
                </div>


                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Status *</label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="status" name="status" required>
                            <option value="ativo" <?= ($c_status == 'S') ? 'selected' : '' ?>>Ativo</option>
                            <option value="inativo" <?= ($c_status == 'N') ? 'selected' : '' ?>>Inativo</option>
                        </select>
                    </div>
                </div>
                <!-- valores de contrato e valor de visita -->

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Valor do Contrato *</label>
                    <div class="col-sm-3">
                        <input type="text" maxlength="10" id="valor_contrato" required class="form-control" name="valor_contrato" value="<?php echo $c_valor_contrato;?> " placeholder="Valor do Contrato">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Valor da Visita *</label>
                    <div class="col-sm-3">
                        <input type="text" maxlength="10" id="valor_visita" required class="form-control" name="valor_visita" value="<?php echo $c_valor_visita;?> " placeholder="Valor da Visita">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Observação</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" id="obs" name="obs" rows="3"><?php echo $c_observacao;?></textarea>
                    </div>
                </div>

                <hr>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                        <a class='btn btn-danger' href='/gop/cadastros/prestadores/prestadores_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                    </div>

                </div>
            </form>
        </div>
    </div>




</body>

</html>