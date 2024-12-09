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
        $sql .= " WHERE p.nome LIKE ? OR m.nome LIKE ?";
    }
    $stmt = $conn->prepare($sql);
    if ($termo_busca) {
        $stmt->execute(['%' . $termo_busca . '%', '%' . $termo_busca . '%']);
    } else {
        $stmt->execute();
    }
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
        $stmt = $conn->prepare("UPDATE projetos SET nome = ?, descricao = ?, data_inicio = ?, data_fim = ?, status_id = ?, membro_id = ?, departamento_id = ?, recurso_principal_id = ?, prioridade_id = ? WHERE id = ?");
        $stmt->execute([$nome, $descricao, $data_inicio, $data_fim, $status_id, $membro_id, $departamento_id, $recurso_principal_id, $prioridade_id, $id]);
        return true;
    } catch (PDOException $e) {
        error_log("Erro ao editar projeto: " . $e->getMessage());
        return false;
    }
}

function excluirProjeto($conn, $id) {
    try {
        $stmt = $conn->prepare("DELETE FROM projetos WHERE id = ?");
        $stmt->execute([$id]);
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
        /* Estilos CSS */
        .form-inline {
            flex-flow: row wrap;
            justify-content: space-between;
            width: 60vw;
        }
        .btn{
            margin: 5px;
            width: 95px;
        }
        .container{
            width: 98vw;
            padding: 10px;
        }
        .table{
            width: auto;
            margin-left: 25px;
        }
     .modal-body{
    display: flex;
   
    flex-direction: column;
    align-items: center;
    justify-content: center; 
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    gap:20px;
}
.modal-body form{
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 20px;
    width: 100%;
}
.modal-body form nav{
    display: flex;
    flex-direction:row;
   justify-content: space-around;
    gap:55px;
    width: 80%
}
label {
    text-align: center;
    width: 15%;
    white-space: nowrap;
    display: inline-block;
    margin-bottom: 0.5rem;
}


        @media (min-width: 576px) {
            .container, .container-sm {
                max-width: 90vw;
            }
        }
    </style>
    <script>
        function mostrarModalEdicao(id) {
            var modal = $('#modalEdicao');
            var projeto = $('#projeto-' + id);

            $('#nomeEdicao').val(projeto.data('nome'));
            $('#descricaoEdicao').val(projeto.data('descricao'));
            $('#data_inicioEdicao').val(projeto.data('data_inicio'));
            $('#data_fimEdicao').val(projeto.data('data_fim'));
            $('#statusEdicao').val(projeto.data('status_id'));
            $('#membroEdicao').val(projeto.data('membro_id'));
            $('#departamentoEdicao').val(projeto.data('departamento_id'));
            $('#recursoEdicao').val(projeto.data('recurso_id'));
            $('#prioridadeEdicao').val(projeto.data('prioridade_id'));
            $('#idEdicao').val(id);
            modal.modal('show');
        }

        function confirmarExclusao(id) {
            if (confirm("Tem certeza que deseja excluir este projeto?")) {
                $.post("index.php", { acao: 'excluir', id: id }, function(data) {
                    location.reload();
                });
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
            <input type="text" class="form-control" id="termo_busca" name="termo_busca" value="<?= isset($_POST['termo_busca']) ? htmlspecialchars($_POST['termo_busca']) : ''; ?>">
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
                <tr id="projeto-<?= $projeto['id']; ?>" data-nome="<?= htmlspecialchars($projeto['nome']); ?>" data-descricao="<?= htmlspecialchars($projeto['descricao']); ?>" data-data_inicio="<?= $projeto['data_inicio']; ?>" data-data_fim="<?= $projeto['data_fim']; ?>" data-status_id="<?= $projeto['status_id']; ?>" data-membro_id="<?= $projeto['membro_id']; ?>" data-departamento_id="<?= $projeto['departamento_id']; ?>" data-recurso_id="<?= $projeto['recurso_id'] ?? ''; ?>" data-prioridade_id="<?= $projeto['prioridade_id'] ?? ''; ?>">
                    <td><?= $projeto['id']; ?></td>
                    <td><?= htmlspecialchars($projeto['nome']); ?></td>
                    <td><?= htmlspecialchars($projeto['descricao']); ?></td>
                    <td><?= $projeto['data_inicio']; ?></td>
                    <td><?= $projeto['data_fim']; ?></td>
                    <td><?= htmlspecialchars($projeto['status_nome']); ?></td>
                    <td><?= htmlspecialchars($projeto['membro_nome']); ?></td>
                    <td><?= htmlspecialchars($projeto['departamento_nome']); ?></td>
                    <td><?= $projeto['recurso_nome'] ?? ''; ?></td>
                    <td><?= htmlspecialchars($projeto['prioridade_nome']) ?? ''; ?></td>
                    <td>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#modalEdicao" onclick="mostrarModalEdicao(<?= $projeto['id']; ?>)">Editar</button>
                        <button class="btn btn-danger" onclick="confirmarExclusao(<?= $projeto['id']; ?>)">Excluir</button>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>

    <!-- Modal -->
    <div class="modal fade" id="modalEdicao" tabindex="-1" role="dialog" aria-labelledby="modalEdicaoLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable" role="document">  
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalEdicaoLabel">Editar Projeto</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form method="post" action="index.php" class="form">
                        <input type="hidden" name="acao" value="editar">
                        <input type="hidden" id="idEdicao" name="id" value="">

                        <nav>
                            <label for="nomeEdicao">Nome:</label>
                            <input type="text" class="form-control" id="nomeEdicao" name="nome" required><br>
                        </nav>

                        <nav>
                            <label for="descricaoEdicao">Descrição:</label>
                            <textarea class="form-control" id="descricaoEdicao" name="descricao" required></textarea><br>
                        </nav>

                        <nav>
                            <label for="data_inicioEdicao">Data de Início:</label>
                            <input type="date" class="form-control" id="data_inicioEdicao" name="data_inicio" required><br>
                        </nav>

                        <nav>
                            <label for="data_fimEdicao">Data de Término:</label>
                            <input type="date" class="form-control" id="data_fimEdicao" name="data_fim" required><br>
                        </nav>

                        <nav>
                            <label for="statusEdicao">Status:</label>
                            <select class="form-control" id="statusEdicao" name="status_id" required>
                                <?php foreach ($status as $s): ?>
                                    <option value="<?= $s['id']; ?>"><?= htmlspecialchars($s['nome']); ?></option>
                                <?php endforeach; ?>
                            </select><br>
                        </nav>

                        <nav>
                            <label for="membroEdicao">Membro:</label>
                            <select class="form-control" id="membroEdicao" name="membro_id" required>
                                <?php foreach ($membros as $membro): ?>
                                    <option value="<?= $membro['id']; ?>"><?= htmlspecialchars($membro['nome']); ?></option>
                                <?php endforeach; ?>
                            </select><br>
                        </nav>

                        <nav>
                            <label for="departamentoEdicao">Departamento:</label>
                            <select class="form-control" id="departamentoEdicao" name="departamento_id" required>
                                <?php foreach ($departamentos as $departamento): ?>
                                    <option value="<?= $departamento['id']; ?>"><?= htmlspecialchars($departamento['nome']); ?></option>
                                <?php endforeach; ?>
                            </select><br>
                        </nav>

                        <nav>
                            <label for="recursoEdicao">Recurso:</label>
                            <select class="form-control" id="recursoEdicao" name="recurso_principal_id">
                                <option value="">Selecione um Recurso</option>
                                <?php foreach ($recursos as $recurso): ?>
                                    <option value="<?= $recurso['id']; ?>"><?= htmlspecialchars($recurso['nome']); ?></option>
                                <?php endforeach; ?>
                            </select><br>
                        </nav>

                        <nav>
                            <label for="prioridadeEdicao">Prioridade:</label>
                            <select class="form-control" id="prioridadeEdicao" name="prioridade_id" required>
                                <option value="">Selecione uma Prioridade</option>
                                <?php foreach ($prioridades as $prioridade): ?>
                                    <option value="<?= $prioridade['id']; ?>"><?= htmlspecialchars($prioridade['nome']); ?></option>
                                <?php endforeach; ?>
                            </select><br>
                        </nav>
<button type="submit" class="btn btn-success">Salvar</button>

                      
                    </form>
                </div>
                <div class="modal-footer">  
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>