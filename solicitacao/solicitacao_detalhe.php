<?php
///////////////////////////////////////////////////////////
// pagina de detalhe da solicitação de recurso fisico
//////////////////////////////////////////////////////////

session_start(); // controle de acesso ao formulário
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
include("../links2.php");
// pego id da solicitação selecionado na página anterior
$i_id = $_GET["id"];
// verifico classificação da solicitação
$c_sql = "select solicitacao.classificacao from solicitacao where solicitacao.id='$i_id'";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
// sql para pegar dados da solicitação selecionada

$c_sql = "SELECT solicitacao.id, solicitacao.data_abertura, solicitacao.prazo_data, solicitacao.prazo_hora, solicitacao.hora_abertura, solicitacao.id_solicitante,
solicitacao.id_recursos, solicitacao.tipo, solicitacao.id_ocorrencia, solicitacao.`status`, solicitacao.descricao, solicitacao.classificacao,
usuarios.nome AS solicitante, setores.descricao AS setor,";
if ($registro['classificacao'] == 'R') {
    $c_sql = $c_sql . "recursos.descricao AS recurso,";
}
if ($registro['classificacao'] == 'E') {
    $c_sql = $c_sql . "espacos.descricao AS espaco,";
}
$c_sql = $c_sql . "case 
WHEN solicitacao.tipo='P' THEN 'Programada'
ELSE 'Urgência'
END AS solicitacao_tipo,
case
when solicitacao.status='A' then 'Aberta'
when solicitacao.status='E' then 'Em Andamento'
when solicitacao.status='C' then 'Concluída'
END AS solicitacao_status
FROM solicitacao
JOIN usuarios ON solicitacao.id_solicitante=usuarios.id";
if ($registro['classificacao'] == 'R') {
    $c_sql = $c_sql . " JOIN recursos ON solicitacao.id_recursos=recursos.id";
}
if ($registro['classificacao'] == 'E') {
    $c_sql = $c_sql . " JOIN espacos ON solicitacao.id_espaco=espacos.id";
}
$c_sql = $c_sql . " JOIN setores ON solicitacao.id_setor=setores.id
where solicitacao.id='$i_id'";

//echo $c_sql;

$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
// variaveis do formulário
$c_descricao = $registro['descricao'];

$c_setor = $registro['setor'];
$d_data = date("d-m-Y", strtotime(str_replace('/', '-', $registro['data_abertura'])));
$c_hora = $registro['hora_abertura'];
if (!empty($registro['prazo_data']))
    $d_prazo_data = date("d-m-Y", strtotime(str_replace('/', '-', $registro['prazo_data'])));
else
    $d_prazo_data = '';
if (!empty($registro['prazo_hora']))
    $c_prazo_hora = $registro['prazo_hora'];
else
    $c_prazo_hora = '';

$c_Solicitante = $registro['solicitante'];
$c_status = $registro['solicitacao_status'];
$c_tipo = $registro['solicitacao_tipo'];
$i_id_ocorrencia = $registro['id_ocorrencia'];

$c_sql = "select id,descricao from ocorrencias where ocorrencias.id='$i_id_ocorrencia'";

$result_ocorrencia = $conection->query($c_sql);
$registro_ocorrencia = $result_ocorrencia->fetch_assoc();
$c_ocorrencia = $registro_ocorrencia['descricao'];
?>

<!-- frontend html da página -->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhe da Solicitação de Serviços</title>
    <link rel="stylesheet" href="/gop/css/basico.css">

</head>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Detalhe da Solicitação de Serviços<h5>
        </div>
    </div>

    <div class="container content-box">

        <?php
        $c_id_ordem = $registro["id"];
        if ($_SESSION['tipo'] <> 'Solicitante' && $registro['status'] == 'A')
            echo '<a class="btn btn btn-sm" href="\gop\solicitacao\solicitacao_gera_os.php?id=' . $c_id_ordem . '"><img src="\gop\images\ordem.png" alt="" width="25" height="25"> Gerar OS</a>';
        ?>
        <a class="btn btn btn-sm" href="\gop\solicitacao\solicitacao_lista.php"><img src="\gop\images\saida.png" alt="" width="25" height="25"> Voltar</a>
        <hr>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Detalhe da Solicitação de Serviço No. <?php echo $registro['id'] ?> </h5>
        </div>
        <!-- abas de solicitações por recursos físicos -->
        <ul class="nav nav-tabs" role="tablist">

            <li role="presentation" class="active"><a href="#detalhe" aria-controls="detalhe" role="tab" data-toggle="tab">Detalhe da Solicitação</a></li>
            <li role="presentation"><a href="#descritivo" aria-controls="descritivo" role="tab" data-toggle="tab">Descrição do Serviço</a></li>
            <li role="menssagens"><a href="#mensagens" aria-controls="mensagens" role="tab" data-toggle="tab">Troca de Mensagens</a></li>
        </ul>

        <div class="tab-content">
            <!-- aba da descricao fisico-->
            <div role="tabpanel" class="tab-pane" id="descritivo">
                <div style="padding-top:15px;padding-left:20px;">

                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea readonly class="form-control" id="descricao" name="descricao" rows="10"><?php echo $c_descricao; ?></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <!-- aba de Detalhe -->
            <div role="tabpanel" class="tab-pane active" id="detalhe">
                <div style="padding-top:15px;padding-left:20px;">
                    <?php
                    if ($registro['classificacao'] == 'R') {
                        $c_recurso = $registro['recurso'];
                        echo " 
                              <div class='row mb-3'>
                                 <label class='col-md-2 form-label'>Recurso Físico</label>
                                 <div class='col-sm-8'>
                                      <input  type='text' readonly class='form-control' name='recurso' id='recurso' value=' $c_recurso'>
                                </div>
                              </div>";
                    }
                    ?>
                    <?php
                    if ($registro['classificacao'] == 'E') {
                        $c_espaco = $registro['espaco'];
                        echo " 
                              <div class='row mb-3'>
                                 <label class='col-md-2 form-label'>Espaço Físico</label>
                                 <div class='col-sm-8'>
                                      <input  type='text' readonly class='form-control' name='espaco' id='espaco' value=' $c_espaco'>
                                </div>
                                </div>";
                    }
                    ?>
                    <div class="row mb-3">
                        <label class="col-md-2 form-label">Hora</label>
                        <div class="col-sm-2">
                            <input type="text" readonly class="form-control" name="hora" id="hora" value='<?php echo $c_hora; ?>'>
                        </div>
                        <label class="col-md-2 form-label">Data Abertura</label>
                        <div class="col-sm-2">
                            <input type="text" readonly class="form-control" name="data" id="data" value='<?php echo $d_data; ?>'>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-md-2 form-label">Prazo Data</label>
                        <div class="col-sm-2">
                            <input type="text" readonly class="form-control" name="prazo_data" id="data" value='<?php echo $d_prazo_data; ?>'>
                        </div>
                        <label class="col-md-2 form-label">Prazo Hora</label>
                        <div class="col-sm-2">
                            <input type="text" readonly class="form-control" name="prazo_hora" id="hora" value='<?php echo $c_prazo_hora; ?>'>
                        </div>

                    </div>

                    <div class="row mb-3">
                        <label class="col-md-2 form-label">Setor</label>
                        <div class="col-sm-3">
                            <input type="text" readonly class="form-control" name="setor" id="setor" value='<?php echo $c_setor; ?>'>
                        </div>
                        <label class="col-md-1 form-label">Solicitante</label>
                        <div class="col-sm-2">
                            <input type="text" readonly class="form-control" name="Solicitante" id="Solicitante" value='<?php echo $c_Solicitante; ?>'>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-md-2 form-label">Tipo</label>
                        <div class="col-sm-3">
                            <input type="text" readonly class="form-control" name="tipo" id="tipo" value='<?php echo $c_tipo; ?>'>
                        </div>
                        <label class="col-md-1 form-label">Status</label>
                        <div class="col-sm-3">
                            <input type="text" readonly class="form-control" name="status" id="status" value='<?php echo $c_status; ?>'>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-md-2 form-label">Ocorrência</label>
                        <div class="col-sm-6">
                            <input type="text" readonly class="form-control" name="ocorrencia" id="ocorrencia" value='<?php echo $c_ocorrencia; ?>'>
                        </div>
                    </div>

                </div>
            </div>
            <!-- Aba de troca de mensagens -->
            <div role="tabpanel" class="tab-pane" id="mensagens">
                <div style="padding-top:15px;padding-left:20px;">
                    <!-- tabela com as mensagens trocadas entre usuário final e operador do sistema -->

                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#mensagem"><img src="\gop\images\escrita.png" alt="" width="25" height="25">
                        Nova Mensagem
                    </button>
                    <hr>
                    <table class="table table   tab_mensagens">
                        <thead class="thead">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Data</th>
                                <th scope="col">Hora</th>
                                <th scope="col">Enviado por</th>
                                <th scope="col">Tipo</th>
                               
                                <th scope="col">Mensagem</th>

                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            // faço a Leitura da tabela com sql
                            $c_sql = "SELECT mensagens.id, mensagens.id_solicitacao, mensagens.id_usuario, usuarios.nome,
                        mensagens.tipo, mensagens.`data`, mensagens.hora, mensagens.`status`, mensagem,
                        case
                            when mensagens.tipo ='0' then 'Operador'
                            when mensagens.tipo ='1' then 'Solicitante'
                        END AS tipo_usuario,
                        case
                            when mensagens.status ='N' then 'Não Lido'
                            when mensagens.status ='S' then 'Lido'
                        END AS status_msg
                        FROM mensagens
                        JOIN usuarios ON mensagens.id_usuario=usuarios.id
                        WHERE mensagens.id_solicitacao='$i_id ' ORDER BY mensagens.`data`,mensagens.hora desc";
                            $result = $conection->query($c_sql);
                            // verifico se a query foi correto
                            if (!$result) {
                                die("Erro ao Executar Sql!!" . $conection->connect_error);
                            }

                            // insiro os registro do banco de dados na tabela 
                            while ($c_linha = $result->fetch_assoc()) {
                                $c_data = date("d-m-Y", strtotime(str_replace('/', '-', $c_linha['data'])));
                                echo "
                    <tr>
                    <td>$c_linha[id]</td>
                    <td>$c_data</td>
                    <td>$c_linha[hora]</td>
                    <td>$c_linha[nome]</td>
                    <td>$c_linha[tipo_usuario]</td>
                    
                    <td>$c_linha[mensagem]</td>
                    
                   

                    </tr>
                    ";
                            }
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>

<!-- Modal -->
<div class="modal fade" id="mensagem" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Nova Mensagem da Solicitação</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row mb-3">
                    <label class="col-sm-5 col-form-label">Mensagem para envio</label>
                    <div class="col-sm-20">
                        <textarea class="form-control" id="add_texto" name="add_texto" rows="18"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-primary">Envia</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">Fechar</button>
            </div>
        </div>
    </div>
</div>

</html>