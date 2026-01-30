<?php
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include('../../conexao.php');
include('../../links2.php');
$c_nome = '';
$c_razao = '';
$c_cnpj = '';
$c_contato = '';
$c_fone1 = '';
$c_fone2 = '';
$c_endereco = '';
$c_bairro = '';
$c_cidade = '';
$c_cep = '';
$c_email = '';
$msg_erro = "";
$msg_gravou = "";
// inclusão do prestador no banco de dados
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $c_nome = $_POST['descricao'];
    $c_grupo = $_POST['grupo'];
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
    $c_url = $_POST['url'];
    $c_obs = $_POST['obs'];
    $c_status = $_POST['status'];
    $c_valor_contrato = str_replace(',', '.', str_replace('.', '', $_POST['valor_contrato']));
    $c_valor_visita = str_replace(',', '.', str_replace('.', '', $_POST['valor_visita']));

    //
    do {
        if (empty($c_nome) || empty($c_razao) || empty($c_cnpj) || empty($c_contato) || empty($c_fone1) || empty($c_grupo) || empty($c_status)) {
            $msg_erro = "Todos os campos com * devem ser preenchidos !!";
            break;
        }

        // sql para inserir o prestador no banco de dados
        $c_sql_insert = "INSERT INTO prestadores (nome,grupo,razao_social,cnpj,contato,telefone1,telefone2,
        endereco,bairro,cidade,cep,email,url,observacao,status,valor_contrato,valor_visita)
        VALUES ('$c_nome','$c_grupo','$c_razao','$c_cnpj','$c_contato','$c_fone1','$c_fone2',
        '$c_endereco','$c_bairro','$c_cidade','$c_cep','$c_email','$c_url','$c_obs','$c_status',
        '$c_valor_contrato','$c_valor_visita')";

        $result_insert = $conection->query($c_sql_insert);
        if (!$result_insert) {
            $msg_erro = "Erro ao Gravar o Prestador no Banco de Dados !!" . $conection->connect_error;
            break;
        }
        // retorno para prestadores_lista.php
        $msg_gravou = "Prestador Gravado com Sucesso !!";
        header("Refresh: 2; /gop/cadastros/prestadores/prestadores_lista.php");
    } while (false);
}


?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/gop/css/basico.css">
    <title>Novo Prestador</title>
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
    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <div style="padding-left:15px;padding-top:15px;">
                        <!--<img Align="left" src="\gop\images\cadastro.png" alt="" width="60" height="45">-->

                    </div>
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo Prestador de Serviço<h5>
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
                    <img Align="left" src="\gop\images\escrita.png" alt="" width="50" height="45">

                </div>
                <h5>Campos com (*) são obrigatórios</h5>
            </div>
            <form method="post">
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Nome do Fornecedor *</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_nome; ?>" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Grupo * </label>
                    <div class="col-sm-4">
                        <select class="form-select form-select-lg mb-3" id="grupo" name="grupo" required>
                            <option></option>
                            <?php
                            // select da tabela de espacos fisicos
                            $c_sql_grupos = "SELECT grupos_fornecedores.id, grupos_fornecedores.descricao FROM grupos_fornecedores ORDER BY grupos_fornecedores.descricao";
                            $result_grupos = $conection->query($c_sql_grupos);
                            while ($c_linha = $result_grupos->fetch_assoc()) {
                                echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                            }
                            ?>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Razão Social *</label>
                    <div class="col-sm-6">
                        <input type="text" maxlength="120" class="form-control" name="razaosocial" value="<?php echo $c_razao; ?>" required>
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
                            <option value="AC">Acre</option>
                            <option value="AL">Alagoas</option>
                            <option value="AP">Amapa</option>
                            <option value="AM">Amazonas</option>
                            <option value="BA">Bahia</option>
                            <option value="CE">Ceara</option>
                            <option value="DF">Distrito Federal</option>
                            <option value="ES">Espirito Santo</option>
                            <option value="GO">Goias</option>
                            <option value="MA">Maranhão</option>
                            <option value="MT">Mato Grosso</option>
                            <option value="MS">Mato Grosso do Sul</option>
                            <option selected value="MG">Minas Gerais</option>
                            <option value="PA">Para</option>
                            <option value="PB">Paraiba</option>
                            <option value="PR">Parana</option>
                            <option value="PE">Pernambuco</option>
                            <option value="PI">Piaui</option>
                            <option value="RJ">Rio de Janeiro</option>
                            <option value="RN">Rio Grande do Norte</option>
                            <option value="RS">Rio Grande do Sul</option>
                            <option value="RO">Rondonia</option>
                            <option value="RR">Roraima</option>
                            <option value="SC">Santa Catarina</option>
                            <option value="SP">São Paulo</option>
                            <option value="SE">Sergipe</option>
                            <option value="TO">Tocantis</option>
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
                        <input type="text" maxlength="120" id="url" class="form-control col-xs-12" name="url">
                    </div>
                </div>


                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Status *</label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="status" name="status" required>
                            <option value="Ativo">Ativo</option>
                            <option value="Inativo">Inativo</option>
                        </select>
                    </div>
                </div>
                <!-- valores de contrato e valor de visita -->

                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Valor do Contrato *</label>
                    <div class="col-sm-3">
                        <input type="text" maxlength="10" id="valor_contrato" class="form-control" name="valor_contrato" placeholder="Valor do Contrato">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Valor da Visita *</label>
                    <div class="col-sm-3">
                        <input type="text" maxlength="10" id="valor_visita" class="form-control" name="valor_visita" placeholder="Valor da Visita">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">Observação</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" id="obs" name="obs" rows="3"></textarea>
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
                        <a class='btn btn-danger' href='/gop/cadastros/fornecedores/fornecedores_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                    </div>

                </div>
            </form>
        </div>
    </div>


</body>

</html>