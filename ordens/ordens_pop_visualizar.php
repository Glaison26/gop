<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}

include("conexao.php");
include("links2.php");
$c_id = $_GET["id"];

if ($_SERVER['REQUEST_METHOD'] == 'GET') {  // metodo get para carregar dados no formulário

    if (!isset($_GET["id"])) {
        header('location: /gop/pops_lista.php');
        exit;
    }

    $c_id = $_GET["id"];
    // leitura do pop
    $c_sql = "SELECT pops.id_recurso, pops.id_espaco, pops.id_oficina, pops.tipo, pops.descricao, pops.revisado,
            pops.preparado, pops.resultadoesperado, pops.materialnecessario, pops.descritivo, pops.atividadecritica, pops.cuidados, pops.anc, pops.`data`,pops.dataemissao,
            pops.processo, pops.objetivo, pops.risco, pops.refbibliografica,  pops.descricao as pop, recursos.descricao AS recurso, espacos.descricao AS espaco, oficinas.descricao AS oficina
            FROM pops
            JOIN oficinas ON pops.id_oficina = oficinas.id
            JOIN recursos ON pops.id_recurso = recursos.id
            JOIN espacos ON pops.id_espaco = espacos.id where pops.id='$c_id'";
    $result = $conection->query($c_sql);
    $registro = $result->fetch_assoc();

    if (!$registro) {
        header('location: /gop/ordens_gerenciar.php');
        exit;
    }

    $c_tipo = $registro['tipo'];
    if ($c_tipo == 1)
        $c_tipo = 'Administrativo';
    if ($c_tipo == 2)
        $c_tipo = 'Edificação';
    if ($c_tipo == 3)
        $c_tipo = 'Equipamento';
    if ($c_tipo == 4)
        $c_tipo = 'Instalação';
    if ($c_tipo == 5)
        $c_tipo = 'Mobiliário';

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
                    <h5>Visualizar POP da Ordem de serviço<h5>
                </div>
            </div>
        </div>
        <div class='alert alert-info' role='alert'>
            <div style="padding-left:15px;">
                <img Align="left" src="\gop\images\escrita.png" alt="30" height="35">
            </div>
            <h5>Visualização do POP selecionada da Ordem de serviço No.<?php echo $_SESSION['id_ordem']; ?></h5>
        </div>
        <hr>
        <div class="row mb-3">
            <p>
            <h5><strong>Tipo :</strong></h5>
            </p>
            <br>
            <div class="col-sm-6">
                <p><?php echo $c_tipo; ?></p>
            </div>
        </div>
        <div class="row mb-3">
            <p>
            <h5><strong>Descrição :</strong></h5>
            </p>
            <div class="col-sm-6">

                <p><?php echo $c_descricao; ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <p>
            <h5><strong>Preparado por :</strong></h5>
            </p>
            <div class="col-sm-6">
                <p><?php echo $c_preparado; ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <p>
            <h5><strong>Revisado por:</strong></h5>
            <div class="col-sm-6">
                <p><?php echo $c_revisado; ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <p>
            <h5><strong>Recurso Fisico:</strong></h5>
            <div class="col-sm-6">
                <p><?php echo $registro['recurso']; ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <h5><strong>Espaço Fisico:</strong></h5>
            <div class="col-sm-6">
                <p><?php echo $registro['espaco']; ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <h5><strong>Oficina :</strong></h5>
            <div class="col-sm-6">
                <p><?php echo $registro['oficina']; ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <h5><strong>Descritivo do POP :</strong></h5>
            <div class="col-sm-7">
                <p><?php echo $c_descritivo ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <h5><strong>Processos do POP :</strong></p>
                <br>
                <div class="col-sm-7">
                    <p><?php echo $c_processo ?></p>
                </div>
        </div>

        <div class="row mb-3">
            <p><strong> Resultado Esperado :</strong></p>
            <div class="col-sm-7">
                <p><?php echo $c_resultado ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <p><strong>Objetivo</p></strong>
            <div class="col-sm-7">
                <p><?php echo $c_objetivo ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <p><strong>Material Necessário</p></strong>
            <div class="col-sm-7">
                <p><?php echo $c_material ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <p><strong>Cuidados </p></strong>
            <div class="col-sm-7">
                <p><?php echo $c_cuidados ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <p><strong>Riscos </p></strong>
            <div class="col-sm-7">
                <p><?php echo $c_risco ?></p>
            </div>
        </div>

        <div class="row mb-3">
            <p><strong>Atividades Críticas</p></strong>
            <div class="col-sm-7">
                <p><?php echo $c_atividadecritica ?></p>
            </div>
        </div>
        <div class="row mb-3">
            <p><strong>A.N.C</p></strong>
            <div class="col-sm-7">
                <p><?php echo $c_anc ?></p>
            </div>
        </div>
        <div class="row mb-3">
            <p><strong>Ref. Bibliografica</p></strong>
            <div class="col-sm-7">
                <p><?php echo $c_bibliografia ?></p>
            </div>
        </div>

    </div>


</body>

</html>