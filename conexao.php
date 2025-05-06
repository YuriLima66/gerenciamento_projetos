<?php
// Configurações do banco de dados
$servername = "db";
$username = "root"; // **IMPORTANTE:** Não use 'root' em produção! Altere para o seu usuário.
$password = "root"; // Altere para sua senha.
$dbname = "gestao_projetos";

// Criar conexão
$conn = new mysqli($servername, $username, $password, $dbname);
$conn->set_charset('utf8mb4');

// Verificar conexão
$message = "";
if ($conn->connect_error) {
    $message = "Falha na conexão: " . $conn->connect_error;
    $toastClass = "bg-danger";
} else {
    $message = "Conexão bem-sucedida!";
    $toastClass = "bg-success";
}
?>
