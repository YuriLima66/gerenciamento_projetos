<?php
header('Content-Type: text/html; charset=utf-8');
session_start();
if (!isset($_SESSION['usuario_id'])) {
    header('Location: login.html');
    exit();
}
require_once 'conexao.php';

// Funções CRUD para membros
function getMembros($conn, $termo_busca = null)
{
    $sql = "SELECT m.*, d.nome AS departamento_nome FROM membros m LEFT JOIN departamentos d ON m.departamento_id = d.id";
    if ($termo_busca) {
        $sql .= " WHERE m.nome LIKE ? OR m.email LIKE ?";
    }
    $stmt = $conn->prepare($sql);
    if ($termo_busca) {
        $like = '%' . $termo_busca . '%';
        $stmt->bind_param('ss', $like, $like);
        $stmt->execute();
        $result = $stmt->get_result();
    } else {
        $stmt->execute();
        $result = $stmt->get_result();
    }
    return $result->fetch_all(MYSQLI_ASSOC);
}

function getDepartamentos($conn)
{
    $result = $conn->query("SELECT id, nome FROM departamentos");
    return $result->fetch_all(MYSQLI_ASSOC);
}

function criarMembro($conn, $nome, $email, $departamento_id, $funcao, $senha)
{
    $senha_hash = password_hash($senha, PASSWORD_DEFAULT);
    $stmt = $conn->prepare("INSERT INTO membros (nome, email, departamento_id, funcao, senha) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param('ssiss', $nome, $email, $departamento_id, $funcao, $senha_hash);
    return $stmt->execute();
}

function editarMembro($conn, $id, $nome, $email, $departamento_id, $funcao, $senha = null)
{
    if ($senha) {
        $senha_hash = password_hash($senha, PASSWORD_DEFAULT);
        $stmt = $conn->prepare("UPDATE membros SET nome=?, email=?, departamento_id=?, funcao=?, senha=? WHERE id=?");
        $stmt->bind_param('ssissi', $nome, $email, $departamento_id, $funcao, $senha_hash, $id);
    } else {
        $stmt = $conn->prepare("UPDATE membros SET nome=?, email=?, departamento_id=?, funcao=? WHERE id=?");
        $stmt->bind_param('ssisi', $nome, $email, $departamento_id, $funcao, $id);
    }
    return $stmt->execute();
}

function excluirMembro($conn, $id)
{
    $stmt = $conn->prepare("DELETE FROM membros WHERE id=?");
    $stmt->bind_param('i', $id);
    return $stmt->execute();
}

// Processar ações
if (isset($_POST['acao'])) {
    switch ($_POST['acao']) {
        case 'criar':
            $nome = $_POST['nome'];
            $email = $_POST['email'];
            $departamento_id = $_POST['departamento_id'];
            $funcao = $_POST['funcao'];
            $senha = $_POST['senha'];
            if (criarMembro($conn, $nome, $email, $departamento_id, $funcao, $senha)) {
                echo "<script>alert('Usuário criado com sucesso!'); window.location.href='usuarios.php';</script>";
            } else {
                echo "<script>alert('Erro ao criar usuário!');</script>";
            }
            break;
        case 'editar':
            $id = $_POST['id'];
            $nome = $_POST['nome'];
            $email = $_POST['email'];
            $departamento_id = $_POST['departamento_id'];
            $funcao = $_POST['funcao'];
            $senha = $_POST['senha'] ?? null;
            if (editarMembro($conn, $id, $nome, $email, $departamento_id, $funcao, $senha)) {
                echo "<script>alert('Usuário atualizado com sucesso!'); window.location.href='usuarios.php';</script>";
            } else {
                echo "<script>alert('Erro ao atualizar usuário!');</script>";
            }
            break;
        case 'excluir':
            $id = $_POST['id'];
            if (excluirMembro($conn, $id)) {
                echo "<script>alert('Usuário excluído com sucesso!'); window.location.href='usuarios.php';</script>";
            } else {
                echo "<script>alert('Erro ao excluir usuário!');</script>";
            }
            break;
    }
}

$termo_busca = $_POST['termo_busca'] ?? null;
$membros = getMembros($conn, $termo_busca);
$departamentos = getDepartamentos($conn);
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Gerenciar Usuários</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<!-- Menu de Navegação -->
<nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
  <a class="navbar-brand" href="#">Gestão de Projetos</a>
  <div class="collapse navbar-collapse">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="index.php">Projetos</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="usuarios.php">Usuários</a>
      </li>
    </ul>
  </div>
</nav>
<div class="container mt-4">
    <h1>Gerenciamento de Usuários</h1>
    <button class="btn btn-success mb-3" data-toggle="modal" data-target="#modalCriar">Novo Usuário</button>
    <form method="post" class="form-inline mb-3">
        <input type="text" name="termo_busca" class="form-control mr-2" placeholder="Buscar por nome ou email" value="<?= htmlspecialchars($termo_busca ?? '') ?>">
        <button type="submit" class="btn btn-primary">Buscar</button>
    </form>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Email</th>
            <th>Departamento</th>
            <th>Função</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach ($membros as $m): ?>
            <tr data-id="<?= $m['id'] ?>" data-nome="<?= htmlspecialchars($m['nome']) ?>" data-email="<?= htmlspecialchars($m['email']) ?>" data-departamento_id="<?= $m['departamento_id'] ?>" data-funcao="<?= htmlspecialchars($m['funcao']) ?>">
                <td><?= $m['id'] ?></td>
                <td><?= htmlspecialchars($m['nome']) ?></td>
                <td><?= htmlspecialchars($m['email']) ?></td>
                <td><?= htmlspecialchars($m['departamento_nome'] ?? '') ?></td>
                <td><?= htmlspecialchars($m['funcao']) ?></td>
                <td>
                    <button class="btn btn-primary btn-editar" data-toggle="modal" data-target="#modalEditar">Editar</button>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="acao" value="excluir">
                        <input type="hidden" name="id" value="<?= $m['id'] ?>">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Tem certeza que deseja excluir este usuário?')">Excluir</button>
                    </form>
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>

<!-- Modal Criar -->
<div class="modal fade" id="modalCriar" tabindex="-1" role="dialog" aria-labelledby="modalCriarLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form method="post">
                <input type="hidden" name="acao" value="criar">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalCriarLabel">Novo Usuário</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Nome</label>
                        <input type="text" name="nome" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Departamento</label>
                        <select name="departamento_id" class="form-control" required>
                            <option value="">Selecione</option>
                            <?php foreach ($departamentos as $d): ?>
                                <option value="<?= $d['id'] ?>"><?= htmlspecialchars($d['nome']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Função</label>
                        <input type="text" name="funcao" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Senha</label>
                        <input type="password" name="senha" class="form-control" required minlength="8">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Criar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal Editar -->
<div class="modal fade" id="modalEditar" tabindex="-1" role="dialog" aria-labelledby="modalEditarLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form method="post">
                <input type="hidden" name="acao" value="editar">
                <input type="hidden" name="id" id="edit-id">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalEditarLabel">Editar Usuário</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Nome</label>
                        <input type="text" name="nome" id="edit-nome" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" id="edit-email" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Departamento</label>
                        <select name="departamento_id" id="edit-departamento_id" class="form-control" required>
                            <option value="">Selecione</option>
                            <?php foreach ($departamentos as $d): ?>
                                <option value="<?= $d['id'] ?>"><?= htmlspecialchars($d['nome']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Função</label>
                        <input type="text" name="funcao" id="edit-funcao" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Nova Senha (deixe em branco para não alterar)</label>
                        <input type="password" name="senha" class="form-control" minlength="8">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Salvar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
$(document).on('click', '.btn-editar', function() {
    var tr = $(this).closest('tr');
    $('#edit-id').val(tr.data('id'));
    $('#edit-nome').val(tr.data('nome'));
    $('#edit-email').val(tr.data('email'));
    $('#edit-departamento_id').val(tr.data('departamento_id'));
    $('#edit-funcao').val(tr.data('funcao'));
});
</script>
</body>
</html>
