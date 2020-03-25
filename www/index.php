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
    HOST_NAME=$host_name
    REMOTE_PORT=$remote_port
    USER_AGENT=$user_agent
    CITY=$user_city
    HTTP_ACCEPT=$http_accept
    HTTP_HOST=$http_host
    HTTP_CONNECTION=$http_connection
    HTTP_LANGUAGE=$http_language
}");
?>
