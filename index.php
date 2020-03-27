<?php
//whether ip is from cloudflare
if (!empty($_SERVER['HTTP_CF_CONNECTING_IP']))  
  {
    $ip_address = $_SERVER['HTTP_CF_CONNECTING_IP'];
  }
echo $ip_address;
?>
