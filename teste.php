<?php
$c_valor = 'R$16,40';
$c_valor = str_replace ( 'R$' , '' , $c_valor );
$c_valor = str_replace ( ',' , '.' , $c_valor);
$c_valor = ltrim($c_valor);
//$c_valor = substr($c_valor, 2, -1);
echo $c_valor;
?>