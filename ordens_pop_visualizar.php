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
    $c_sql = "SELECT *, recursos.descricao AS recurso, espacos.descricao AS espaco, oficinas.descricao AS oficina
            from pops
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
            <h5>Visualização do POP selecionada da Ordem de serviço</h5>
        </div>
        <hr>
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Tipo</label>
            <div class="col-sm-6">
                <input readonly type="text" maxlength="120" class="form-control" name="tipo" value="<?php echo $c_tipo; ?>">
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Descrição</label>
            <div class="col-sm-6">
                <input readonly type="text" maxlength="120" class="form-control" name="descricao" value="<?php echo $c_descricao; ?>">
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Preparado por</label>
            <div class="col-sm-6">
                <input readonly type="text" maxlength="120" class="form-control" name="preparado" value="<?php echo $c_preparado; ?>">
            </div>
        </div>


        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Revisado por</label>
            <div class="col-sm-6">
                <input readonly type="text" maxlength="120" class="form-control" name="revisado" value="<?php echo $c_revisado; ?>">
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Recurso Fisico </label>
            <div class="col-sm-6">
                <input readonly type="text" maxlength="120" class="form-control" name="recurso" value="<?php echo $registro['recurso']; ?>">
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Espaco Fisico </label>
            <div class="col-sm-6">
                <input readonly type="text" maxlength="120" class="form-control" name="espaco" value="<?php echo $registro['espaco']; ?>">
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Oficina </label>
            <div class="col-sm-6">
                <input readonly type="text" maxlength="120" class="form-control" name="oficina" value="<?php echo $registro['oficina']; ?>">
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Descritivo do POP</label>
            <div class="col-sm-7">
                <textarea readonly class="form-control" id="descritivo" name="descritivo" rows="6"><?php echo $c_descritivo ?></textarea>
            </div>
        </div>


        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Processos do POP</label>
            <div class="col-sm-7">
                <textarea readonly class="form-control" id="processo" name="processo" rows="6"><?php echo $c_processo ?></textarea>
            </div>
        </div>


        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Resultado Esperado</label>
            <div class="col-sm-7">
                <textarea readonly class="form-control" id="resultado" name="resultado" rows="6"><?php echo $c_resultado ?></textarea>
            </div>
        </div>


        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Objetivo</label>
            <div class="col-sm-7">
                <textarea readonly class="form-control" id="objetivo" name="objetivo" rows="6"><?php echo $c_objetivo ?></textarea>
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Material Necessário</label>
            <div class="col-sm-7">
                <textarea readonly class="form-control" id="material" name="material" rows="6"><?php echo $c_material ?></textarea>
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Cuidados</label>
            <div class="col-sm-7">
                <textarea readonly class="form-control" id="cuidados" name="cuidados" rows="6"><?php echo $c_cuidados ?></textarea>
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Riscos</label>
            <div class="col-sm-7">
                <textarea readonly class="form-control" id="risco" name="risco" rows="6"><?php echo $c_risco ?></textarea>
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Atividades Críticas</label>
            <div class="col-sm-7">
                <textarea readonly class="form-control" id="atividadecritica" name="atividadecritica" rows="6"><?php echo $c_atividadecritica ?></textarea>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">A.N.C</label>
            <div class="col-sm-7">
                <textarea readonly class="form-control" id="anc" name="anc" rows="6"><?php echo $c_anc ?></textarea>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label">Ref. Bibliografica</label>
            <div class="col-sm-7">
                <textarea readonly class="form-control" id="bibliografia" name="bibliografia" rows="6"><?php echo $c_bibliografia ?></textarea>
            </div>
        </div>
        <hr>
        <div class="row mb-3">
            <div class="offset-sm-0 col-sm-3">

                <a class='btn btn-info' href='/gop/ordens_gerenciar.php'>Voltar</a>
            </div>

        </div>
    </div>

    </div>

</body>

</html>