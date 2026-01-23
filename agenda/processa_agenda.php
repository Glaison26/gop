<?php
session_start(); // controle de acesso ao formulário
if (!isset($_SESSION['newsession'])) {
    die('Acesso não autorizado!!!');
}
include("../conexao.php");
// pego id do executor
$id_executor = $_POST['executor'];
// pego periodo para agenda
$d_data_inicio = $_POST['data1'];
$d_data_final = $_POST['data2'];
$d_data1 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data_inicio)));
$d_data2 = date("Y-m-d", strtotime(str_replace('/', '-', $d_data_final)));
// monto variavel $c_where_periodo com as datas 
$c_where_periodo = " and (data_inicio>='$d_data1' and data_inicio<='$d_data2')";
  
// monto sql para pesquisa da agenda do executor
$c_sql = 'SELECT ordens.data_inicio,  ordens.hora_inicio, executores.nome FROM ordens
JOIN ordens_executores ON ordens.id = ordens_executores.id_ordem
JOIN executores ON ordens_executores.id_executor = executores.id
where ordens_executores.id_executor = '.$id_executor.$c_where_periodo.'
ORDER BY ordens.data_inicio desc';
// variavesl de sessão com a montagem do sql
$_SESSION['sql_agenda'] = $c_sql;
header('location: /gop/agenda/agenda_lista.php');
?>