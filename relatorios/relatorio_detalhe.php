<?php
session_start(); // controle de acesso ao formulário
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
// pego id do executor
$id_executor = $_POST['executor'];
if ($id_executor == '0')
    $c_sql_executor = "select * from executores";
else
    $c_sql_executor = "select * from executores where id=" . $id_executor;
$result = $conection->query($c_sql_executor);
$c_result = $result->fetch_assoc();


// pego periodo para agenda
$d_data_inicio = $_POST['data1'];
$d_data_final = $_POST['data2'];
$d_data1 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data_inicio)));
$d_data2 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data_final)));
// monto variavel $c_where_periodo com as datas 
$c_where_periodo = "(data_inicio>='$d_data1' and data_inicio<='$d_data2')";
?>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        .executor {
            margin-bottom: 30px;
        }

        .executor h2 {
            background-color: #f0f0f0;
            padding: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th,
        td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>

<body>
    <h2> Detalhado de Executores de Serviço no período de <?php echo date("d-m-Y", strtotime(str_replace('/', '-', $d_data_inicio)))  . ' a ' . date("d-m-Y", strtotime(str_replace('/', '-', $d_data_final)))?> </h2>

    <?php
    $i_total_ocorrencia = 0;
    if ($id_executor == '0') {
        $c_sql_ocorrencias = "select id, nome from executores";
        $result_executores = $conection->query($c_sql_ocorrencias);

        while ($executor = $result_executores->fetch_assoc()) {
            exibirExecutor($executor['id'], $executor['nome'], $c_where_periodo, $conection);
        }
    } else {
        exibirExecutor($id_executor, $c_result['nome'], $c_where_periodo, $conection);
    }

    function exibirExecutor($id, $nome, $where, $conn)
    {
        $i_total_ocorrencia = 0;
        echo "<div class='executor'>";
        echo "<h3>Executor: " . htmlspecialchars($nome) . "</h3>";

        $sql = "SELECT ocorrencias.descricao, COUNT(ordens_executores.id_executor) AS quantidade FROM ordens
    JOIN ocorrencias ON ordens.id_ocorrencia=ocorrencias.id
    JOIN  ordens_executores ON ordens.id=ordens_executores.id_ordem 
            where ordens_executores.id_executor=$id and " . $where . " 
            group by ocorrencias.descricao order by quantidade desc";


        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            echo "<table><tr><th>Descrição da Ocorrência</th><th>Número de Ocorrências</th></tr>";
            while ($row = $result->fetch_assoc()) {
                echo "<tr><td>" . htmlspecialchars($row['descricao']) . "</td>";
                echo "<td>" . $row['quantidade'] . "</td></tr>";
                $i_total_ocorrencia = $i_total_ocorrencia + $row['quantidade'];
            }
            echo "</table>";
            echo "<p><strong>Total de ocorrências: " . $i_total_ocorrencia . "</strong></p>";
        } else {
            echo "<p>Nenhuma ocorrência encontrada.</p>";
        }
    }

    ?>
   <div class="container mt-3">
        <form action="ordens_emissao_email.php?id=<?php echo $c_id; ?>" method="post">
            <div class='no-print' style='text-align: center; margin-top: 30px;'>
               
        </form>
        <button onclick='window.print()' style='padding: 10px 20px; background: #3498db; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 1rem;'>
            🖨️ Imprimir
        </button>

        <!-- botão para fechar a aba aberta -->
        <button onclick='window.close()' style='padding: 10px 20px; background: #95a5a6; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 1rem; margin-left: 10px;'>
            ✖️ Fechar
        </button>
    </div>

</body>


  <style>
    body {
        font-family: 'Times New Roman', serif;
        max-width: 800px;
        margin: 0 auto;
        padding: 40px;
        line-height: 1.6;
        color: #333;
        background: white;
    }

    .header {
        text-align: center;
        margin-bottom: 40px;
        border-bottom: 3px solid #2c3e50;
        padding-bottom: 20px;
    }

    .logo {
        font-size: 2.5rem;
        color: #2c3e50;
        margin-bottom: 10px;
    }

    .clinica-nome {
        font-size: 1.8rem;
        font-weight: bold;
        color: #2c3e50;
        margin-bottom: 5px;
    }

    .clinica-info {
        font-size: 1rem;
        color: #666;
    }

    .titulo {
        text-align: center;
        font-size: 2rem;
        font-weight: bold;
        color: #2c3e50;
        margin: 40px 0;
        text-transform: uppercase;
        letter-spacing: 2px;
    }

    .conteudo {
        font-size: 1.2rem;
        text-align: justify;
        margin: 30px 0;
        padding: 20px;
        background: #f8f9fa;
        border-left: 5px solid #3498db;
    }

    .paciente {
        font-weight: bold;
        color: #2c3e50;
    }

    .assinatura {
        margin-top: 60px;
        text-align: center;
    }

    .linha-assinatura {
        border-top: 2px solid #333;
        width: 300px;
        margin: 40px auto 10px;
    }

    .profissional-info {
        font-size: 1rem;
        color: #666;
    }

    .rodape {
        margin-top: 50px;
        text-align: center;
        font-size: 0.9rem;
        color: #888;
        border-top: 1px solid #ddd;
        padding-top: 20px;
    }

    .data-emissao {
        text-align: right;
        margin-top: 30px;
        font-size: 1.1rem;
        color: #666;
    }

    @media print {
        body {
            padding: 20px;
        }

        .no-print {
            display: none;
        }
    }
</style>

</style>

</html>