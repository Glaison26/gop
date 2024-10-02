<?php

session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("conexao.php");
include("links2.php");
$_SESSION['pesquisamenu'] = false;
// click no botão de pesquisa
if ((isset($_POST["btnpesquisa"])) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {
    $c_where = "";
    // formatação de datas para o sql
    $d_data1 = $_POST['data1'];
    $d_data1 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data1)));
    $d_data2 = $_POST['data2'];
    $d_data2 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data2)));
    // expressão sql inicia para recursos fisicos

    // data da próxima realização
    if ($_POST['tipo_data'] == '1') {
        $c_where = "(data_prox_realizacao>='$d_data1' and data_prox_realizacao<='$d_data2') and ";
    }
    // data da ultima realização
    if ($_POST['tipo_data'] == '2') {
        $c_where = "(data_ult_realizacao>='$d_data1' and data_ult_realizacao<='$d_data2') and ";
    }
    // pesquisa por descritivo da preventiva
    if ($_POST['descritivo'] <> '') {
        $c_descritivo = $_POST['descritivo'];
        $c_where = $c_where . "preventivas.descritivo LIKE '%$c_descritivo%' and ";
    }
    // tipo de preventiva
    $c_tipo = $_POST['tipo'];
    if ($c_tipo <> 'T')
        $c_where =  $c_where . "tipo_preventiva='$c_tipo' and ";
    // pesquisa por descritivo

    if ($c_where <> '')
        $c_where = $c_where = substr($c_where, 0, -5); // tirar o and no final

    // montagem do sql para pesquisa de preventivas em recursos fisicos
    $c_sqlrecursos = "SELECT preventivas.id ,preventivas.id_recurso,  preventivas.descritivo, preventivas.id_oficina, preventivas.id_centrodecusto, preventivas.tipo_preventiva,
preventivas.data_cadastro, preventivas.periodicidade_geracao, preventivas.data_prox_realizacao, preventivas.data_ult_realizacao, preventivas.calibracao,
oficinas.descricao AS oficina, recursos.descricao AS recurso, recursos.patrimonio,
case
when preventivas.tipo_preventiva ='S' then 'Sistemática'
when preventivas.tipo_preventiva ='P' then 'Preditiva'
when preventivas.tipo_preventiva ='R' then 'Rotina'
END AS preventiva_tipo_completo,
case
when preventivas.calibracao ='S' then 'Sim'
when preventivas.calibracao ='N' then 'Não'
END AS preventiva_calibracao
FROM preventivas
JOIN oficinas ON preventivas.id_oficina=oficinas.id
JOIN recursos ON preventivas.id_recurso=recursos.id";
    if ($c_where <> '')
        $c_sqlrecursos = $c_sqlrecursos . ' where ' . $c_where;

    $c_sqlrecursos = $c_sqlrecursos . ' ORDER BY preventivas.data_prox_realizacao desc';

    // montagem de sql para pesquisa de preventivas dem espaçõs fisicos
    $c_sqlespacos = "SELECT preventivas.id, preventivas.descritivo, preventivas.id_espaco, preventivas.id_oficina, preventivas.id_centrodecusto, preventivas.tipo_preventiva,
preventivas.data_cadastro, preventivas.periodicidade_geracao, preventivas.data_prox_realizacao, preventivas.data_ult_realizacao, preventivas.calibracao,
oficinas.descricao AS oficina, espacos.descricao AS espaco,
case
when preventivas.tipo_preventiva ='S' then 'Sistemática'
when preventivas.tipo_preventiva ='P' then 'Preditiva'
when preventivas.tipo_preventiva ='R' then 'Rotina'
END AS preventiva_tipo_completo
FROM preventivas
JOIN oficinas ON preventivas.id_oficina=oficinas.id
JOIN espacos ON preventivas.id_espaco=espacos.id";
    if ($c_where <> '')
        $c_sqlespacos = $c_sqlespacos . ' where ' . $c_where;

    $c_sqlespacos = $c_sqlespacos . ' ORDER BY preventivas.data_prox_realizacao desc';

    // variaves que repassaram o sql de pesquisa
    $_SESSION['sqlrecurso'] = $c_sqlrecursos;
    $_SESSION['sqlespaco'] = $c_sqlespacos;
    // variavel de controle de retorno para o card ou não no menu principal
    $_SESSION['pesquisamenu'] = false;

    header('location: /gop/preventivas_lista.php');
}

?>

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
            <h5>Cadastro de Preventivas<h5>
        </div>
    </div>
    <div class="content">

        <div class="container -my5">
            <div class='alert alert-info' role='alert'>
                <div style="padding-left:15px;">
                    <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
                </div>
                <h5><?php $_SESSION['c_usuario'] ?>Clique em nova preventiva para novo registro de preventiva ou realize uma pesquisa com as opções de pesquisa abaixo</h5>
            </div>

            <form method="post">
                <div style="padding-top:5px;padding-bottom:15px">
                    <a class="btn btn btn-sm" href="preventivas_nova.php"><img src="\gop\images\preventivo.png" alt="" width="25" height="25"> Nova Preventiva</a>
                    <button type="submit" name='btnpesquisa' id='btnpesquisa' class="btn btn btn-sm"><img src="\gop\images\lupa.png" alt="" width="20" height="20"></span> Pesquisar</button>
                    <!--<a class="btn btn btn-sm" href="#"><img src="\gop\images\eraser.png" alt="" width="25" height="25"> Limpar pesquisa</a> -->
                    <a class="btn btn btn-sm" href="\gop\preventivas_geracao.php"><img src="\gop\images\ordem.png" alt="" width="25" height="25">Preventivas Pendentes</a>
                    <a class="btn btn btn-sm" href="\gop\menu.php"><img src="\gop\images\saida.png" alt="" width="25" height="25"> Voltar</a>
                </div>
                <div class="panel panel-light class">
                    <div class="panel-heading text-center">
                        <h5>Opções de Consulta<h5>
                    </div>
                </div>

                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">Data para pesquisa</label>
                    <div class="col-sm-2">
                        <select class="form-select form-select-lg mb-3" id="tipo_data" name="tipo_data" value="<?php echo $c_tipo; ?>">
                            <option value='0'>Nenhuma data</option>
                            <option value='1'>Próxima realização</option>
                            <option value='2'>Ultima realização</option>

                        </select>
                    </div>

                    <label class="col-sm-2 col-form-label">Tipo</label>
                    <div class="col-sm-3">
                        <select class="form-select form-select-lg mb-3" id="tipo" name="tipo" value="<?php echo $c_tipo; ?>">
                            <option value='T'>Todos</option>
                            <option value='S'>Sistêmica</option>
                            <option value='P'>Preditiva</option>
                            <option value='R'>Rotina</option>
                        </select>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-md-2 form-label">De</label>
                    <div class="col-sm-3">
                        <input type="Date" class="form-control" name="data1" id="data1" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                    </div>
                    <label class="col-md-1 form-label">até</label>
                    <div class="col-sm-3">
                        <input type="Date" class="form-control" name="data2" id="data2" value='<?php echo date("Y-m-d"); ?>' onkeypress="mascaraData(this)">
                    </div>
                </div>
                <br>
                <div class="row mb-3">
                    <label class="col-md-2 form-label">Descritivo</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" name="descritivo" id="descritivo">
                    </div>
                </div>
            </form>
        </div>

</body>

</html>