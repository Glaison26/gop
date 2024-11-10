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

$c_sql = "SELECT solicitacao.id, solicitacao.data_abertura, solicitacao.hora_abertura, solicitacao.id_solicitante,
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

</head>

<body>
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Detalhe da Solicitação de Serviços<h5>
        </div>
    </div>

    <div class="container -my5">
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Detalhe da Solicitação de Serviço No. <?php echo $registro['id'] ?> para Visualização </h5>
        </div>
        <?php
        $c_id_ordem = $registro["id"];
        if ($_SESSION['tipo'] <> 'Solicitante' && $registro['status'] == 'A')
            echo '<a class="btn btn btn-sm" href="\gop\solicitacao\solicitacao_gera_os.php?id=' . $c_id_ordem . '"><img src="\gop\images\ordem.png" alt="" width="25" height="25"> Gerar OS</a>';
        ?>

        <a class="btn btn btn-sm" href="\gop\solicitacao\solicitacao_lista.php"><img src="\gop\images\saida.png" alt="" width="25" height="25"> Voltar</a>
        <hr>
        <!-- abas de solicitações por recursos físicos -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#descritivo" aria-controls="descritivo" role="tab" data-toggle="tab">Descrição do Serviço</a></li>
            <li role="presentation"><a href="#detalhe" aria-controls="detalhe" role="tab" data-toggle="tab">Detalhe da Solicitação</a></li>

        </ul>

        <div class="tab-content">
            <!-- aba da descricao fisico-->
            <div role="tabpanel" class="tab-pane  active" id="descritivo">
                <div style="padding-top:15px;padding-left:20px;">

                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea readonly class="form-control" id="descricao" name="descricao" rows="10"><?php echo $c_descricao; ?></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <!-- aba de Detalhe -->
            <div role="tabpanel" class="tab-pane" id="detalhe">
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
                        <label class="col-md-2 form-label">Setor</label>
                        <div class="col-sm-4">
                            <input type="text" readonly class="form-control" name="setor" id="setor" value='<?php echo $c_setor; ?>'>
                        </div>
                        <label class="col-md-2 form-label">Solicitante</label>
                        <div class="col-sm-2">
                            <input type="text" readonly class="form-control" name="Solicitante" id="Solicitante" value='<?php echo $c_Solicitante; ?>'>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-md-2 form-label">Tipo</label>
                        <div class="col-sm-4">
                            <input type="text" readonly class="form-control" name="tipo" id="tipo" value='<?php echo $c_tipo; ?>'>
                        </div>
                        <label class="col-md-2 form-label">Status</label>
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
        </div>

    </div>


</body>

</html>