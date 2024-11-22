<?php

// Configurações do banco de dados
$servername = "localhost";
$username = "root"; // **IMPORTANTE:** Não use 'root' em produção! Altere para o seu usuário.
$password = ""; // Altere para sua senha.
$dbname = "gestao_projetos";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname;charset=utf8mb4", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Falha na conexão: " . $e->getMessage());
}

// Funções
function getProjetos($conn, $termo_busca = null) {
    $sql = "SELECT p.*, m.nome AS membro_nome, s.nome AS status_nome, d.nome AS departamento_nome, 
                   r.nome AS recurso_nome, r.id AS recurso_id,
                   pr.nome AS prioridade_nome, pr.id AS prioridade_id
            FROM projetos p
            JOIN membros m ON p.membro_id = m.id
            LEFT JOIN status s ON p.status_id = s.id
            JOIN departamentos d ON p.departamento_id = d.id
            LEFT JOIN recursos r ON p.recurso_principal_id = r.id
            LEFT JOIN prioridades pr ON p.prioridade_id = pr.id";
    if ($termo_busca) {
        $sql .= " WHERE p.nome LIKE :termo_busca OR m.nome LIKE :termo_busca";
    }

    $stmt = $conn->prepare($sql);
    if ($termo_busca) {
        $stmt->bindValue(':termo_busca', '%' . $termo_busca . '%', PDO::PARAM_STR);
    }
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function getMembros($conn) {
    $stmt = $conn->query("SELECT id, nome FROM membros");
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function getStatus($conn) {
    $stmt = $conn->query("SELECT id, nome FROM status");
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function getDepartamentos($conn) {
    $stmt = $conn->query("SELECT id, nome FROM departamentos");
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function getRecursos($conn) {
    $stmt = $conn->query("SELECT id, nome FROM recursos");
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function getPrioridades($conn) {
    $stmt = $conn->query("SELECT id, nome FROM prioridades");
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}


function editarProjeto($conn, $id, $nome, $descricao, $data_inicio, $data_fim, $status_id, $membro_id, $departamento_id, $recurso_principal_id, $prioridade_id) {
    try {
        $sql = "UPDATE projetos SET nome = :nome, descricao = :descricao, data_inicio = :data_inicio, data_fim = :data_fim, status_id = :status_id, membro_id = :membro_id, departamento_id = :departamento_id, recurso_principal_id = :recurso_principal_id, prioridade_id = :prioridade_id WHERE id = :id";
        $stmt = $conn->prepare($sql);
        $stmt->bindValue(':nome', $nome, PDO::PARAM_STR);
        $stmt->bindValue(':descricao', $descricao, PDO::PARAM_STR);
        $stmt->bindValue(':data_inicio', $data_inicio, PDO::PARAM_STR);
        $stmt->bindValue(':data_fim', $data_fim, PDO::PARAM_STR);
        $stmt->bindValue(':status_id', $status_id, PDO::PARAM_INT);
        $stmt->bindValue(':membro_id', $membro_id, PDO::PARAM_INT);
        $stmt->bindValue(':departamento_id', $departamento_id, PDO::PARAM_INT);
        $stmt->bindValue(':recurso_principal_id', $recurso_principal_id, PDO::PARAM_INT);
        $stmt->bindValue(':prioridade_id', $prioridade_id, PDO::PARAM_INT);
        $stmt->bindValue(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return true;
    } catch (PDOException $e) {
        error_log("Erro ao editar projeto: " . $e->getMessage());
        return false;
    }
}

function excluirProjeto($conn, $id) {
    try {
        $sql = "DELETE FROM projetos WHERE id = :id";
        $stmt = $conn->prepare($sql);
        $stmt->bindValue(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return true;
    } catch (PDOException $e) {
        error_log("Erro ao excluir projeto: " . $e->getMessage());
        return false;
    }
}


// Processar ações (editar, excluir)
if (isset($_POST['acao'])) {
    switch ($_POST['acao']) {
        case 'editar':
            $id = $_POST['id'];
            $nome = $_POST['nome'];
            $descricao = $_POST['descricao'];
            $data_inicio = $_POST['data_inicio'];
            $data_fim = $_POST['data_fim'];
            $status_id = $_POST['status_id'];
            $membro_id = $_POST['membro_id'];
            $departamento_id = $_POST['departamento_id'];
            $recurso_principal_id = $_POST['recurso_principal_id'];
            $prioridade_id = $_POST['prioridade_id'];

            if (editarProjeto($conn, $id, $nome, $descricao, $data_inicio, $data_fim, $status_id, $membro_id, $departamento_id, $recurso_principal_id, $prioridade_id)) {
                echo "<script>alert('Projeto atualizado com sucesso!'); window.location.href='index.php';</script>";
            } else {
                echo "<script>alert('Erro ao atualizar projeto!');</script>";
            }
            break;

        case 'excluir':
            $id = $_POST['id'];
            if (excluirProjeto($conn, $id)) {
                echo "<script>alert('Projeto excluído com sucesso!'); window.location.href='index.php';</script>";
            } else {
                echo "<script>alert('Erro ao excluir projeto!');</script>";
            }
            break;
    }
}

// Obter os dados
$termo_busca = isset($_POST['termo_busca']) ? $_POST['termo_busca'] : null;
$projetos = getProjetos($conn, $termo_busca);
$membros = getMembros($conn);
$status = getStatus($conn);
$departamentos = getDepartamentos($conn);
$recursos = getRecursos($conn);
$prioridades = getPrioridades($conn);


?>
<!DOCTYPE html>
<html>
<head>
    <title>Gerenciamento de Projetos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .edit-form {
            display: none;
            background-color: #f8f9fa;
            padding: 20px;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            margin-bottom: 10px;
        }
         .form-inline {
            flex-flow: row wrap;
            justify-content: space-between;
            width: 60vw;
        }
      
      
        
        
    </style>
    <script>
        function mostrarFormularioEdicao(id) {
            var form = document.getElementById("form-edicao-" + id);
            form.style.display = "block";
        }

        function esconderFormularioEdicao(id) {
            var form = document.getElementById("form-edicao-" + id);
            form.style.display = "none";
        }

        function confirmarExclusao(id) {
            if (confirm("Tem certeza que deseja excluir este projeto?")) {
                var form = document.createElement('form');
                form.method = 'post';
                form.action = 'index.php'; // Ou o URL apropriado para o seu script PHP

                var acaoInput = document.createElement('input');
                acaoInput.type = 'hidden';
                acaoInput.name = 'acao';
                acaoInput.value = 'excluir';
                form.appendChild(acaoInput);

                var idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = id;
                form.appendChild(idInput);

                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h1>Gerenciamento de Projetos</h1>

    <form method="post" class="mb-3">
        <div class="form-group">
            <label for="termo_busca">Pesquisar:</label>
            <input type="text" class="form-control" id="termo_busca" name="termo_busca" value="<?= isset($_POST['termo_busca']) ? $_POST['termo_busca'] : ''; ?>">
        </div>
        <button type="submit" class="btn btn-primary">Pesquisar</button>
    </form>

    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Descrição</th>
            <th>Data de Início</th>
            <th>Data de Término</th>
            <th>Status</th>
            <th>Membro</th>
            <th>Departamento</th>
            <th>Recurso Principal</th>
            <th>Prioridade</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach ($projetos as $projeto): ?>
            <tr>
                <td><?= $projeto['id']; ?></td>
                <td><?= $projeto['nome']; ?></td>
                <td><?= $projeto['descricao']; ?></td>
                <td><?= $projeto['data_inicio']; ?></td>
                <td><?= $projeto['data_fim']; ?></td>
                <td><?= $projeto['status_nome']; ?></td>
                <td><?= $projeto['membro_nome']; ?></td>
                <td><?= $projeto['departamento_nome']; ?></td>
                <td><?= $projeto['recurso_nome'] ?? ''; ?></td>
                <td><?= $projeto['prioridade_nome'] ?? ''; ?></td>
                <td>
                    <button class="btn btn-primary" onclick="mostrarFormularioEdicao(<?= $projeto['id']; ?>)">Editar</button>
                    <button class="btn btn-danger" onclick="confirmarExclusao(<?= $projeto['id']; ?>)">Excluir</button>
                </td>
            </tr>
            <tr id="form-edicao-<?= $projeto['id']; ?>" class="edit-form">
                <td colspan="11">
                    <form method="post" class="form-inline">
                        <input type="hidden" name="acao" value="editar">
                        <input type="hidden" name="id" value="<?= $projeto['id']; ?>">

                        <label for="nome-edicao-<?= $projeto['id']; ?>">Nome:</label>
                        <input type="text" class="form-control" id="nome-edicao-<?= $projeto['id']; ?>" name="nome" value="<?= $projeto['nome']; ?>"><br>

                        <label for="descricao-edicao-<?= $projeto['id']; ?>">Descrição:</label>
                        <textarea class="form-control" id="descricao-edicao-<?= $projeto['id']; ?>" name="descricao"><?= $projeto['descricao']; ?></textarea><br>

                        <label for="data_inicio-edicao-<?= $projeto['id']; ?>">Data de Início:</label>
                        <input type="date" class="form-control" id="data_inicio-edicao-<?= $projeto['id']; ?>" name="data_inicio" value="<?= $projeto['data_inicio']; ?>"><br>

                        <label for="data_fim-edicao-<?= $projeto['id']; ?>">Data de Término:</label>
                        <input type="date" class="form-control" id="data_fim-edicao-<?= $projeto['id']; ?>" name="data_fim" value="<?= $projeto['data_fim']; ?>"><br>

                        <label for="status-edicao-<?= $projeto['id']; ?>">Status:</label>
                        <select class="form-control" id="status-edicao-<?= $projeto['id']; ?>" name="status_id">
                            <?php foreach ($status as $s): ?>
                                <option value="<?= $s['id']; ?>" <?= ($s['id'] == $projeto['status_id']) ? 'selected' : ''; ?>><?= $s['nome']; ?></option>
                            <?php endforeach; ?>
                        </select><br>

                        <label for="membro_id-edicao-<?= $projeto['id']; ?>">Membro Responsável:</label>
                        <select class="form-control" id="membro_id-edicao-<?= $projeto['id']; ?>" name="membro_id">
                            <?php foreach ($membros as $membro): ?>
                                <option value="<?= $membro['id']; ?>" <?= ($membro['id'] == $projeto['membro_id']) ? 'selected' : ''; ?>><?= $membro['nome']; ?></option>
                            <?php endforeach; ?>
                        </select><br>

                        <label for="departamento_id-edicao-<?= $projeto['id']; ?>">Departamento:</label>
                        <select class="form-control" id="departamento_id-edicao-<?= $projeto['id']; ?>" name="departamento_id">
                            <?php foreach ($departamentos as $departamento): ?>
                                <option value="<?= $departamento['id']; ?>" <?= ($departamento['id'] == $projeto['departamento_id']) ? 'selected' : ''; ?>><?= $departamento['nome']; ?></option>
                            <?php endforeach; ?>
                        </select><br>

                        <label for="recurso_principal_id-edicao-<?= $projeto['id']; ?>">Recurso Principal:</label>
                        <select class="form-control" id="recurso_principal_id-edicao-<?= $projeto['id']; ?>" name="recurso_principal_id">
                            <option value="">Selecione um Recurso</option>  
                            <?php foreach ($recursos as $recurso): ?>
                                <option value="<?= $recurso['id']; ?>" <?= ($recurso['id'] == $projeto['recurso_id']) ? 'selected' : ''; ?>><?= $recurso['nome']; ?></option>
                            <?php endforeach; ?>
                        </select><br>

                        <label for="prioridade_id-edicao-<?= $projeto['id']; ?>">Prioridade:</label>
                        <select class="form-control" id="prioridade_id-edicao-<?= $projeto['id']; ?>" name="prioridade_id">
                           <option value="">Selecione uma Prioridade</option>
                            <?php foreach ($prioridades as $prioridade): ?>
                                <option value="<?= $prioridade['id']; ?>" <?= ($prioridade['id'] == $projeto['prioridade_id']) ? 'selected' : ''; ?>><?= $prioridade['nome']; ?></option>
                            <?php endforeach; ?>
                        </select><br>


                        <button type="submit" class="btn btn-success">Salvar</button>
                        <button type="button" class="btn btn-secondary" onclick="esconderFormularioEdicao(<?= $projeto['id']; ?>)">Cancelar</button>
                    </form>
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>