<?php
///////////////////////////////////////////////////////////////////////
// arquivo de include com tabela de materiais de ordem de serviço
///////////////////////////////////////////////////////////////////////

include_once "../lib_gop.php";
$formatter = new NumberFormatter('pt_BR',  NumberFormatter::CURRENCY);

// baixar materiais no cadastro
if (isset($_POST['btn_baixa']) && ($_SERVER['REQUEST_METHOD'] == 'POST')) {
    $c_sql_baixa =  "SELECT ordens_materiais.id, ordens_materiais.id_material, ordens_materiais.quantidade,
  ordens_materiais.baixa FROM ordens_materiais
  WHERE ordens_materiais.id_ordem='$i_id'";
    $result_baixa = $conection->query($c_sql_baixa);
    // loop para dar baixa
    while ($registro = $result_baixa->fetch_assoc()) {
        if ($registro['baixa'] == 'N') {
        $c_sql_up = "update materiais set quantidadeatual = quantidadeatual-$registro[quantidade]
         where materiais.id='$registro[id_material]'";
         //echo $c_sql_up;
        $result_up = $conection->query($c_sql_up);
        $c_sql_up2 = "update ordens_materiais set baixa='S' where id='$registro[id]'";
        $result_up2 = $conection->query($c_sql_up2);
        }
    }

  echo "<script>alert('Baixas Realizadas com sucesso!!');</script>"  ;
}

?>


<script language="Javascript">
    function confirmacao(id) {
        var resposta = confirm("Deseja remover esse registro?");
        if (resposta == true) {
            window.location.href = "/gop/ordens/ordens_materiais_excluir.php?id=" + id;
        }
    }
</script>

<script>
    $(document).ready(function() {
        $('.tabmateriais').DataTable({
            // 
            "iDisplayLength": -1,
            "order": [1, 'asc'],
            "aoColumnDefs": [{
                'bSortable': false,
                'aTargets': [5]
            }, {
                'aTargets': [0],
                "visible": false
            }],
            "oLanguage": {
                "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                "sLengthMenu": "_MENU_ resultados por página",
                "sInfoFiltered": " - filtrado de _MAX_ registros",
                "oPaginate": {
                    "spagingType": "full_number",
                    "sNext": "Próximo",
                    "sPrevious": "Anterior",
                    "sFirst": "Primeiro",
                    "sLoadingRecords": "Carregando...",
                    "sProcessing": "Processando...",
                    "sZeroRecords": "Nenhum registro encontrado",

                    "sLast": "Último"
                },
                "sSearch": "Pesquisar",
                "sLengthMenu": 'Mostrar <select>' +
                    '<option value="5">5</option>' +
                    '<option value="10">10</option>' +
                    '<option value="20">20</option>' +
                    '<option value="30">30</option>' +
                    '<option value="40">40</option>' +
                    '<option value="50">50</option>' +
                    '<option value="-1">Todos</option>' +
                    '</select> Registros'

            }

        });

    });
</script>


<div class="container-fluid">
    <form method="post" onsubmit="return confirm('Confirma baixa dos Materiais?')">
        <?php
        if (($c_linha_ordem['status'] <> 'C') && ($c_linha_ordem['status'] <> 'S') && ($c_linha_ordem['status'] <> 'X'))
            echo "<div class='panel panel-info class'>
                    <div class='panel-heading'>
            
                         <a class='btn btn' href='/gop/ordens/ordens_materiais_inclusao.php'><span class='glyphicon glyphicon-plus'></span> Incluir Material</a>
                         <button class='btn btn' type='submit' name='btn_baixa' id='btn_baixa' class='btn'><img src='\gop\images\itabela.png' alt='' width='20' height='20'></span> Baixa de Materiais</button>
                    </div>
            </div>";
        ?>
    </form>
    <hr>
    <table class="table table display table-bordered tabmateriais">
        <thead class="thead">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Material</th>
                <th scope="col">Qtd.</th>
                <th scope="col">Baixou</th>
                <th scope="col">Unidade</th>
                <th scope="col">Valor</th>
                <th scope="cod">Vlr. Total</th>
                <th scope="col">Opções</th>
            </tr>
        </thead>
        <tbody>
            <?php

            // faço a Leitura da tabela com sql
            $c_sql = "SELECT ordens_materiais.id, materiais.descricao as material, unidades.abreviatura as unidade, ordens_materiais.quantidade,
                    ordens_materiais.valor, ordens_materiais.baixa FROM ordens_materiais
                    JOIN materiais ON ordens_materiais.id_material=materiais.id
                    JOIN unidades ON ordens_materiais.id_unidade=unidades.id
                    WHERE ordens_materiais.id_ordem='$i_id'";
            $result = $conection->query($c_sql);
            // verifico se a query foi correto
            if (!$result) {
                die("Erro ao Executar Sql!!" . $conection->connect_error);
            }

            // insiro os registro do banco de dados na tabela 
            $c_custo_total = 0;
            while ($c_linha = $result->fetch_assoc()) {
                if ($c_linha['valor'] > 0) {
                    $c_custo = $formatter->formatCurrency($c_linha['valor'], 'BRL');
                    $c_total = $c_linha['valor'] * $c_linha['quantidade'];
                    $c_total = $formatter->formatCurrency($c_total, 'BRL');
                    $c_custo_total = $c_custo_total + $c_linha['valor'] * $c_linha['quantidade'];
                } else {
                    $c_custo = 0.00;
                    $c_total = 0.00;
                }
                if ($c_linha['baixa'] == 'N')
                    $c_baixa = 'Não';
                else
                    $c_baixa = 'Sim';

                echo "
                    <tr>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[material]</td>
                    <td>$c_linha[quantidade]</td>
                    <td>$c_baixa</td>
                    <td>$c_linha[unidade]</td>
                    <td style='text-align: right;'>$c_custo</td>
                    <td style='text-align: right;'>$c_total</td>
                    <td>";
                if ($c_linha_ordem['status'] <> 'C' && $c_linha_ordem['status'] <> 'S') {
                    echo "<a class='btn btn-secondary btn-sm' href='/gop/ordens/ordens_materiais_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                
                    </td>";
                }
                echo "</tr>";
            }
            ?>
        </tbody>
    </table>
    <hr>
    <div class="panel panel-primary class">
        <div class="panel-heading">
            <p>
            <h5>Custo Total de Material : <?php echo  $formatter->formatCurrency($c_custo_total, 'BRL'); ?></h5>
            </p>
        </div>
    </div>
</div>