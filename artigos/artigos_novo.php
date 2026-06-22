<?php
// controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include_once "../lib_gop.php";
include("../conexao.php");
include("../links2.php");


// variaveis para mensagens de erro e suscessso da gravação
$msg_gravou = "";
$msg_erro = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // faço post para as variáveis que vão gravar no sql
    do {

        $titulo = $_POST['titulo'];
        $descricao = $_POST['descricao'];
        $palavra_chave = $_POST['palavra_chave'];
        $aplicacao = $_POST['aplicacao'];
        $causa_problema = $_POST['causa_problema'];
        $solucao_abordagem = $_POST['solucao_abordagem'];
        $requisitos = $_POST['requisitos'];
        $executor_id = $_POST['executor'];
        $data_criacao = $_POST['data_criacao'];
        $data_atualizacao = $_POST['data_atualizacao'] ?? null;
        $categoria_id = $_POST['categoria'];
        // monto o sql para inserir os dados do novo artigo técnico
        $sql_insert = "INSERT INTO artigos (titulo, breve_descricao, tags, cenario_sitoma, causa_raiz,
         passo_a_passo, requisitos, id_autor, data_criacao, data_atualizacao, id_categoria) VALUES 
         ('$titulo', '$descricao', '$palavra_chave', '$aplicacao', '$causa_problema', '$solucao_abordagem', 
         '$requisitos', $executor_id, '$data_criacao', " . ($data_atualizacao ? "'$data_atualizacao'" : "NULL") . ", $categoria_id)";   
        $result = $conection->query($sql_insert);
        if (!$result) {
            $msg_erro = "Erro ao gravar o artigo técnico: " . $conection->error;
            break;
        }

        header('location: /gop/artigos/artigos_lista.php');
    } while (false);
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GOP - Novo Artigo</title>
    <link rel="stylesheet" href="/gop/css/basico.css">

</head>

<body>
    <div class="container-fluid">
        <div style="padding-top:5px;">
            <div class="panel panel-primary class">
                <div class="panel-heading text-center">
                    <h4>GOP - Gestão Operacional</h4>
                    <h5>Novo Artigo Técnico<h5>
                </div>
            </div>
        </div>

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
        <div class="container content-box">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

                </div>
                <h5>Campos com (*) são obrigatórios</h5>
            </div>
            <form method="post">
                <!-- montagem do formulário de artigos técnicos -->
                 <!-- combo box da tabela de categorias para classificar o artigo técnico -->
                <?php
                $c_sql_categorias = "SELECT id, descricao FROM artigos_categoria ORDER BY descricao";
                $result_categorias = $conection->query($c_sql_categorias);
                $categorias = [];
                while ($row = $result_categorias->fetch_assoc()) {
                    $categorias[] = $row;
                }
                ?>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-6">
                        <label for="categoria" class="form-label">Categoria *</label>
                        <select class="form-select form-select-lg mb-3" id="categoria" name="categoria" required>
                            <option value="">Selecione uma categoria</option>
                            <?php foreach ($categorias as $categoria) { ?>
                                <option value="<?= $categoria['id'] ?>"><?= $categoria['descricao'] ?></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                <!-- titulo do artigo -->
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-12">
                        <label for="titulo" class="form-label">Título do Artigo Técnico *</label>
                        <input type="text" class="form-control" id="titulo" name="titulo" required>
                    </div>
                </div>
                <!-- breve descrição do artigo -->
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-12">
                        <label for="descricao" class="form-label">Breve Descrição do Artigo Técnico *</label>
                        <input type="text" class="form-control" id="descricao" name="descricao" maxlength="150" required>
                    </div>
                </div>
                <!-- tag ou palavra-chave para o artigo -->
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-6">
                        <label for="palavra_chave" class="form-label">Tag ou Palavra-chave *</label>
                        <input type="text" class="form-control" id="palavra_chave" name="palavra_chave" required>
                    </div>
                </div>
                <!-- cenário de aplicação do artigo -->
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-6">
                        <label for="aplicacao" class="form-label">Cenário de Aplicação *</label>
                        <input type="text" class="form-control" id="aplicacao" name="aplicacao" required>
                    </div>
                </div>
                <!-- causa ou problema que o artigo técnico aborda -->
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-12">
                        <label for="causa_problema" class="form-label">Causa ou Problema Abordado *</label>
                        <textarea class="form-control" id="causa_problema" name="causa_problema" rows="6" required></textarea>
                    </div>
                </div>
                <!-- solução ou abordagem proposta pelo artigo técnico -->
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-12">
                        <label for="solucao_abordagem" class="form-label">Solução ou Abordagem Proposta *</label>
                        <textarea class="form-control" id="solucao_abordagem" name="solucao_abordagem" rows="6" required></textarea>
                    </div>
                </div>
                <!-- requisitos ou pré-requisitos para aplicar a solução do artigo técnico -->
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-12">
                        <label for="requisitos" class="form-label">Requisitos ou Pré-requisitos para Aplicação *</label>
                        <textarea class="form-control" id="requisitos" name="requisitos" rows="6" required></textarea>
                    </div>
                </div>
                <?php
                $c_sql_executores = "SELECT id, nome FROM executores ORDER BY nome";
                $result_executores = $conection->query($c_sql_executores);
                $executores = [];
                while ($row = $result_executores->fetch_assoc()) {
                    $executores[] = $row;
                }
                ?>
                <!-- combobox com executor responsável pela aplicação da solução do artigo técnico com dados da tabela de executores -->
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-6">
                        <label for="executor" class="form-label">Executor Responsável *</label>
                        <select class="form-select form-select-lg mb-3" id="executor" name="executor" required>
                            <option value="">Selecione um executor</option>
                            <?php foreach ($executores as $executor) { ?>
                                <option value="<?= $executor['id'] ?>"><?= $executor['nome'] ?></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                <!-- data da criação do artigo técnico -->
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-6">
                        <label for="data_criacao" class="form-label">Data de Criação *</label>
                        <input type="date" class="form-control" id="data_criacao" name="data_criacao" required>
                    </div>
                </div>
                <!-- data da ultima atualização do artigo técnico -->
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-6">
                        <label for="data_atualizacao" class="form-label">Data da Última Atualização</label>
                        <input type="date" class="form-control" id="data_atualizacao" name="data_atualizacao">
                    </div>
                </div>
                <hr>
                <div class="row mb-3">
                    <div class="offset-sm-0 col-sm-3">
                        <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                        <a class='btn btn-danger' href='/gop/artigos/artigos_lista.php'><span class='glyphicon glyphicon-remove'></span> Cancelar</a>
                    </div>

                </div>
            </form>
        </div>
    </div>

</body>

</html>