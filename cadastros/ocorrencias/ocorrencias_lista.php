<?php // controle de acesso ao formulário
session_start();
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../../conexao.php");
include("../../links.php");
// verifico se usuário e operador de tem autorização de acesso
$i_id_usuario = $_SESSION["id_usuario"];
$c_sql_acesso = "select usuarios.tipo, perfil_usuarios.servicos_ocorrencias_padroes FROM usuarios
JOIN perfil_usuarios ON usuarios.id_perfil=perfil_usuarios.id
WHERE usuarios.id='$i_id_usuario'";
$result_acesso = $conection->query($c_sql_acesso);
$registro_acesso = $result_acesso->fetch_assoc();
if ($registro_acesso['tipo'] == 'Operador' && $registro_acesso['servicos_ocorrencias_padroes'] == 'N') {
    header('location: /gop/acesso.php');
}
$n_tempo_horas = '0';
$n_tempo_minutos = '0';
?>
<!doctype html>
<html lang="en">

<body>

    <script language="Javascript">
        function confirmacao(id) {
            var resposta = confirm("Deseja remover esse registro?");
            if (resposta == true) {
                window.location.href = "/gop/cadastros/ocorrencias/ocorrencias_excluir.php?id=" + id;
            }
        }
    </script>

    <script language="Javascript">
        function mensagem(msg) {
            alert(msg);
        }
    </script>


    <script>
        $(document).ready(function() {
            $('.tabocorrencias').DataTable({
                // 
                "iDisplayLength": -1,
                "order": [1, 'asc'],
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [2]
                }, {
                    'aTargets': [0],
                    "visible": true
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

    <!-- Função javascript e ajax para inclusão dos dados -->
    <script type="text/javascript">
        $(document).on('submit', '#frmadd', function(e) {
            e.preventDefault();
            var c_descricao = $('#add_descricaoField').val();
            var c_texto = $('#add_textoField').val();
            var c_texto_fechamento = $('#add_textofechamentoField').val();
            var c_tempo_hora = $('#add_tempo_horas').val();
            var c_tempo_minuto = $('#add_tempo_minutos').val();

            if (c_descricao != '') {

                $.ajax({
                    url: "ocorrencias_novo.php",
                    type: "post",
                    data: {
                        c_descricao: c_descricao,
                        c_texto: c_texto,
                        c_texto_fechamento: c_texto_fechamento,
                        c_tempo_hora: c_tempo_hora,
                        c_tempo_minuto: c_tempo_minuto

                    },
                    success: function(data) {
                        var json = JSON.parse(data);
                        var status = json.status;

                        location.reload();
                        if (status == 'true') {

                            $('#novoModal').modal('hide');
                            location.reload();
                        } else {
                            alert('falha ao incluir dados');
                        }
                    }
                });
            } else {
                alert('Preencha todos os campos obrigatórios');
            }
        });
    </script>

    <!-- Coleta dados da tabela para edição do registro -->
    <script>
        $(document).ready(function() {

            $('.editbtn').on('click', function() {

                $('#editmodal').modal('show');

                $tr = $(this).closest('tr');

                var data = $tr.children("td").map(function() {
                    return $(this).text();
                }).get();

                console.log(data);

                $('#up_idField').val(data[0]);
                $('#up_descricaoField').val(data[1]);
                $('#up_textoField').val(data[2]);
                $('#up_textofechamentoField').val(data[3]);
                $('#up_tempo_horas').val(data[4]);
                $('#up_tempo_minutos').val(data[5]);
            });
        });
    </script>

    <script type="text/javascript">
        // Função javascript e ajax para Alteração dos dados
        $(document).on('submit', '#frmup', function(e) {
            e.preventDefault();
            var c_id = $('#up_idField').val();
            var c_descricao = $('#up_descricaoField').val();
            var c_texto = $('#up_textoField').val();
            var c_texto_fechamento = $('#up_textofechamentoField').val();
            var c_tempo_minuto = $('#up_tempo_minutos').val();
            var c_tempo_hora = $('#up_tempo_horas').val();

            if (c_descricao != '') {

                $.ajax({
                    url: "ocorrencias_editar.php",
                    type: "post",
                    data: {
                        c_id: c_id,
                        c_descricao: c_descricao,
                        c_texto: c_texto,
                        c_texto_fechamento: c_texto_fechamento,
                        c_tempo_hora: c_tempo_hora,
                        c_tempo_minuto: c_tempo_minuto

                    },
                    success: function(data) {
                        var json = JSON.parse(data);
                        var status = json.status;
                        if (status == 'true') {
                            $('#editmodal').modal('hide');
                            location.reload();
                        } else {
                            alert('falha ao alterar dados');
                        }
                    }
                });

            } else {
                alert('Todos os campos devem ser preenchidos!!');
            }
        });
    </script>


    <!-- montagem da página -->
    <div class="panel panel-primary class">
        <div class="panel-heading text-center">
            <h4>GOP - Gestão Operacional</h4>
            <h5>Lista de Ocorrências Padrões<h5>
        </div>
    </div>

    <br>
    <div class="container-fluid">

        <a class="btn btn-success btn-sm" href="/gop/cadastros/ocorrencias/ocorrencia_nova.php"><span class="glyphicon glyphicon-plus"></span> Incluir</a>
        <a class="btn btn-secondary btn-sm" href="/gop/menu.php"><span class="glyphicon glyphicon-off"></span> Voltar</a>

        <hr>
        <table class="table table display table-bordered tabocorrencias">
            <thead class="thead">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Tempo hr.</th>
                    <th scope="col">Tempo Min.</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php

                // faço a Leitura da tabela com sql
                $c_sql = "SELECT ocorrencias.id, ocorrencias.descricao, ocorrencias.texto, ocorrencias.texto_fechamento, ocorrencias.tempo_hora,
                ocorrencias.tempo_minuto
                FROM ocorrencias ORDER BY ocorrencias.descricao";
                $result = $conection->query($c_sql);
                // verifico se a query foi correto
                if (!$result) {
                    die("Erro ao Executar Sql!!" . $conection->connect_error);
                }

                // insiro os registro do banco de dados na tabela 
                while ($c_linha = $result->fetch_assoc()) {

                    echo "
                    <tr'>
                    <td>$c_linha[id]</td>
                    <td>$c_linha[descricao]</td>
                    <td>$c_linha[tempo_hora]</td>
                    <td>$c_linha[tempo_minuto]</td>
                    <td>
                    <a class='btn btn-secondary btn-sm' href='/gop/cadastros/ocorrencias/ocorrencia_editar.php?id=$c_linha[id]'><span class='glyphicon glyphicon-pencil'></span> Editar</a>
                    <a class='btn btn-danger btn-sm' href='javascript:func()'onclick='confirmacao($c_linha[id])'><span class='glyphicon glyphicon-trash'></span> Excluir</a>
                    </td>

                    </tr>
                    ";
                }
                ?>


            </tbody>
        </table>
    </div>
    

</body>

</html>