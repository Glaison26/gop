<?php

include 'conexao.php';

$c_sql = "select * from configuracoes";
$result_email = $conection->query($c_sql);
$registro_email = $result_email->fetch_assoc();
$c_email_envio = $registro_email['email_envio'];
$c_host_email = $registro_email['email_host'];
$c_porta_email = $registro_email['porta_smtp'];
$c_senha_email = $registro_email['senha_email'];

?>