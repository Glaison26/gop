<?php
$valor = 'teste0';
$string = filter_var($valor, FILTER_SANITIZE_NUMBER_INT);
echo $string;
?>


