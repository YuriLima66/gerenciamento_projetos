<?php
session_start();
require_once 'conexao.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['login'] ?? '';
    $senha = $_POST['senha'] ?? '';

    // Usando mysqli para buscar o usuário
    if ($conn->connect_error) {
        $erro = 'Erro ao conectar ao banco de dados!';
    } else {
        $stmt = $conn->prepare('SELECT id, nome, senha FROM membros WHERE email = ? LIMIT 1');
        if ($stmt) {
            $stmt->bind_param('s', $email);
            $stmt->execute();
            $result = $stmt->get_result();
            $usuario = $result->fetch_assoc();
            if ($usuario && ($senha === $usuario['senha'] || password_verify($senha, $usuario['senha']))) {
                $_SESSION['usuario_id'] = $usuario['id'];
                $_SESSION['usuario_nome'] = $usuario['nome'];
                header('Location: index.php');
                exit();
            } else {
                $erro = 'E-mail ou senha inválidos!';
            }
            $stmt->close();
        } else {
            $erro = 'Erro na consulta ao banco de dados!';
        }
    }
} else {
    $erro = 'Acesso inválido!';
}
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="./Estilos/style.css" />
</head>
<body>
    <main>
        <section id="login">
            <div id="formulario">
                <h1>Login</h1>
                <?php if (isset($erro)): ?>
                    <p style="color:red;"><?= htmlspecialchars($erro) ?></p>
                <?php endif; ?>
                <a href="login.html">Voltar</a>
            </div>
        </section>
    </main>
</body>
</html>
