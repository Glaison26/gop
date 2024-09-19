<?php
include_once "lib_gop.php";


?>

<div class="container-fluid">

    <a class="btn btn-success btn-sm" href="#"><span class="glyphicon glyphicon-plus"></span> Incluir</a>


    <hr>
    <table class="table table display table-bordered tabmateriais">
        <thead class="thead">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Material</th>
                <th scope="col">Qtd.</th>
                <th scope="col">Unidade</th>
                <th scope="col">Valor</th>
                <th scope="col">Opções</th>
            </tr>
        </thead>
        <tbody>
            <?php

            // faço a Leitura da tabela com sql
            $c_sql = "SELECT ordens_materiais.id, materiais.descricao as material, unidades.abreviatura as unidade, ordens_materiais.quantidade, ordens_materiais.valor FROM ordens_materiais
                    JOIN materiais ON ordens_materiais.id_material=materiais.id
                    JOIN unidades ON ordens_materiais.id_unidade=unidades.id
                    WHERE ordens_materiais.id_ordem='24'";
            $result = $conection->query($c_sql);
            // verifico se a query foi correto
            if (!$result) {
                die("Erro ao Executar Sql!!" . $conection->connect_error);
            }

            // insiro os registro do banco de dados na tabela 
            while ($c_linha = $result->fetch_assoc()) {
                $c_custo = mask($c_linha['valor'], 'R$#########');
                echo "
                    <tr class='info'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[material]</td>
                    <td>$c_linha[quantidade]</td>
                    <td>$c_linha[unidade]</td>
                    <td>$c_custo</td>
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/materiais_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>

                    </tr>
                    ";
            }
            ?>
        </tbody>
    </table>
</div>