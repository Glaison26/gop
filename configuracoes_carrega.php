<?php

include 'conexao.php';

$c_sql = "select * from configuracoes";
$result = $conection->query($c_sql);
$registro = $result->fetch_assoc();
$c_email_envio = $registro['email_envio'];
$c_host_email = $registro['email_host'];
$c_porta_email = $registro['porta_smtp'];
$c_senha_email = $registro['senha_email'];

?>