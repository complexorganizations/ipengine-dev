<?php
  {
    $ip_address = $_SERVER['REMOTE_ADDR'];
    $user_agent = $_SERVER['HTTP_USER_AGENT'];
    $host_name = $_SERVER['REMOTE_HOST'];
    $remote_port = $_SERVER['REMOTE_PORT'];
    $http_accept = $_SERVER['HTTP_ACCEPT'];
    $http_host = $_SERVER['HTTP_HOST'];
    $http_connection = $_SERVER['HTTP_CONNECTION'];
    $http_language = $_SERVER['HTTP_ACCEPT_LANGUAGE'];

  }
echo nl2br("{
    IP=$ip_address
    Host_Name:=$host_name
    Remote_Port=$remote_port
    User Agent: $user_agent
    City:
    HTTP ACCEPT: $http_accept
    HTTP HOST: $http_host
    HTTP Connection: $http_connection
    HTTP Language: $http_language
}");
?>
