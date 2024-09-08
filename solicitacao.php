<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("conexao.php");
include("links2.php");


// rotina para montagem do sql com as opções selecionadas
if ((isset($_POST["btnpesquisa"])) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {
    // expressão sql inicila para recursos fisicos
    if ($_POST['classificacao'] == "1") {
        $c_sqlpesquisa = "SELECT solicitacao.data_abertura, solicitacao.hora_abertura, solicitacao.id_solicitante,
                    solicitacao.id_recursos, solicitacao.tipo,  solicitacao.`status`,
                    usuarios.nome AS solicitante, recursos.descricao AS recurso,
                    case 
                    WHEN solicitacao.tipo='P' THEN 'Programada'
                    ELSE 'Urgência'
                    END AS solicitacao_tipo,
                    case
                    when solicitacao.status='A' then 'Aberta'
                    when solicitacao.status='E' then 'Em Andamento'
                    when solicitacao.status='C' then 'Concluída'
                    END AS solicitacao_status
                    FROM solicitacao
                    JOIN usuarios ON solicitacao.id_solicitante=usuarios.id
                    JOIN recursos ON solicitacao.id_recursos=recursos.id";
        // chamo pagina com os dados a serem selecionados passando a string sql
        $_SESSION['sql'] = $c_sqlpesquisa;
        header('location: /gop/solicitacao_lista.php');            
    }
}


?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<script>
    // função para verificas selct do tipo de solicitação e desebilita/ habilitar espaco fisico ou recurso
    function verifica(value) {
        var input_recurso = document.getElementById("recurso");
        var input_espaco = document.getElementById("espaco");

        if (value == 1) {
            input_recurso.disabled = false;
            input_espaco.disabled = true;
        } else if (value == 2) {
            input_recurso.disabled = true;
            input_espaco.disabled = false;
        }
    };
</script>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Solicitações de Serviços<h5>
        </div>
    </div>

    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">

            </div>
            <h5>Clique em nova solitação para abrir uma nova solicitação de serviço ou realize uma pesquisa com as opções de pesquisa abaixo</h5>
        </div>
        <form method="post">
            <div style="padding-top:5px;padding-bottom:15px">
                <a class="btn btn btn-sm" href="solicitacao_nova.php"><img src="\gop\images\contato.png" alt="" width="25" height="25"> Nova Solicitação</a>
                <button type="submit" name='btnpesquisa' id='btnpesquisa' class="btn btn btn-sm"><img src="\gop\images\lupa.png" alt="" width="20" height="20"></span> Pesquisar</button>
                <a class="btn btn btn-sm" href="#"><img src="\gop\images\eraser.png" alt="" width="25" height="25"> Limpar pesquisa</a>
                <a class="btn btn btn-sm" href="\gop\menu.php"><img src="\gop\images\voltar.png" alt="" width="25" height="25"> Voltar</a>
            </div>
            <div class="card">
                <div class="card-header">
                    <h5 class="text-center">Opções para pesquisa</h5>
                </div>
                <div class="form-group">
                    <div style="padding-top:15px;">
                        <label class="col-sm-2 col-form-label">Solicitação em</label>
                        <div class="col-sm-2">
                            <select onchange="verifica(this.value)" class="form-select form-select-lg mb-3" id="classificacao" name="classificacao" value="<?php echo $c_classificacao; ?>">
                                <option value="1" selected>Recurso Físico</option>
                                <option value="2">Espaço Físico</option>
                            </select>
                        </div>
                        <label for="solicitacao" class="col-md-2 form-label">No. da Solicitação</label>
                        <div class="col-md-2">
                            <input type="text" class="form-control" id="solicitacao" name="solicitacao">
                        </div>
                    </div>
                </div>
                <div class="form-group">

                    <label class="col-md-2 form-label">De</label>
                    <div class="col-sm-2">
                        <input type="Date" maxlength="10" class="form-control" name="data1" id="data1" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                    </div>
                    <label class="col-md-2 form-label">até</label>
                    <div class="col-sm-2">
                        <input type="Date" maxlength="10" class="form-control" name="data2" id="data2" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                    </div>

                </div>

                <div class="form-group">
                    <label class="col-sm-2 col-form-label">Tipo</label>
                    <div class="col-sm-2">
                        <select class="form-select form-select-lg mb-3" id="tipo" name="tipo" value="<?php echo $c_tipo; ?>">
                            <option>Todos</option>
                            <option>Programada</option>
                            <option>Urgência</option>
                        </select>
                    </div>
                    <label for="solicitacao" class="col-md-2 form-label">No. Patrimônio</label>
                    <div class="col-md-2">
                        <input type="text" class="form-control" id="patrimonio" name="patrimonio">
                    </div>

                </div>
                <div class="form-group">

                    <label class="col-sm-2 col-form-label">Solicitante </label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="solicitante" name="solicitante">
                            <option>Todos</option>
                            <?php
                            // select da tabela de solicitantes
                            $c_sql_sol = "SELECT usuarios.id, usuarios.nome FROM usuarios ORDER BY usuarios.nome";
                            $result_sol = $conection->query($c_sql_sol);
                            while ($c_linha = $result_sol->fetch_assoc()) {
                                echo "  
                          <option>$c_linha[nome]</option>
                        ";
                            }
                            ?>
                        </select>
                    </div>
                    <label class="col-sm-1 col-form-label">Setor </label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="setor" name="setor">
                            <option>Todos</option>
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
                <div class="form-group">
                    <label class="col-sm-2 col-form-label">Espaço Físico</label>
                    <div class="col-sm-7">
                        <select disabled class="form-select form-select-lg mb-3" id="espaco" name="espaco">
                            <option>Todos</option>
                            <?php
                            // select da tabela de espaço fisico
                            $c_sql_esp = "SELECT espacos.id, espacos.descricao FROM espacos ORDER BY espacos.descricao";
                            $result_esp = $conection->query($c_sql_esp);
                            while ($c_linha = $result_esp->fetch_assoc()) {
                                echo "  
                          <option>$c_linha[descricao]</option>
                        ";
                            }
                            ?>
                        </select>
                    </div>

                </div>
                <div class="form-group">
                    <label for="descricao" class="col-md-2 form-label">Recurso Físico</label>
                    <div class="col-md-7">
                        <input type="text" class="form-control" id="recurso" name="recurso">
                    </div>
                </div>
                <div class="form-group">
                    <label for="descricao" class="col-md-2 form-label">Descrição</label>
                    <div class="col-md-7">
                        <input type="text" class="form-control" id="descricao" name="descricao">
                    </div>
                </div>
            </div>

        </form>
    </div>



</body>

</html>