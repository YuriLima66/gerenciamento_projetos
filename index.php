<?php
// Conexão com o banco de dados
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "gestao_projetos";

$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar a conexão
if ($conn->connect_error) {
  die("Falha na conexão: " . $conn->connect_error);
}

// Formulário de consulta
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $termo_busca = $_POST["termo_busca"];

  // Consulta SQL com filtro (para nome do projeto ou nome do membro)
  $sql = "SELECT p.*, m.nome AS membro_nome 
        FROM projetos p 
        JOIN membros m ON p.membro_id = m.id
        WHERE p.nome LIKE '%" . $termo_busca . "%' 
        OR m.nome LIKE '%" . $termo_busca . "%'";
  $result = $conn->query($sql);
} else {
  // Consulta SQL sem filtro
  $sql = "SELECT p.*, m.nome AS membro_nome 
        FROM projetos p 
        JOIN membros m ON p.membro_id = m.id";
  $result = $conn->query($sql);
}

?>

<!DOCTYPE html>
<html>
<head>
  <title>Gerenciamento de Projetos</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script>
    // Função para mostrar o formulário de edição
    function mostrarFormularioEdicao(id) {
      var form = document.getElementById("form-edicao-" + id);
      form.style.display = "block";
    }

    // Função para esconder o formulário de edição
    function esconderFormularioEdicao(id) {
      var form = document.getElementById("form-edicao-" + id);
      form.style.display = "none";
    }

    // Função para confirmar a exclusão
    function confirmarExclusao(id) {
      if (confirm("Tem certeza que deseja excluir este projeto?")) {
        window.location.href = "index.php?acao=excluir&id=" + id;
      }
    }

    // Função para editar o projeto (envia dados para o servidor)
    function editarProjeto(id) {
      // Obter dados do formulário
      var nome = document.getElementById("nome-edicao-" + id).value;
      var descricao = document.getElementById("descricao-edicao-" + id).value;
      var data_inicio = document.getElementById("data_inicio-edicao-" + id).value;
      var data_fim = document.getElementById("data_fim-edicao-" + id).value;
      var status = document.getElementById("status-edicao-" + id).value;
      var membro_id = document.getElementById("membro_id-edicao-" + id).value;

      // Criar URL para enviar os dados
      var url = "index.php?acao=editar&id=" + id + 
               "&nome=" + nome + 
               "&descricao=" + descricao +
               "&data_inicio=" + data_inicio +
               "&data_fim=" + data_fim +
               "&status=" + status +
               "&membro_id=" + membro_id;

      // Redirecionar para a URL (envia os dados)
      window.location.href = url;
    }
  </script>
</head>
<body>

  <div class="container">
    <h1>Gerenciamento de Projetos</h1>

    <!-- Formulário de consulta -->
    <form method="post" class="mb-3">
      <div class="form-group">
        <label for="termo_busca">Pesquisar por nome do projeto ou nome do colaborador:</label>
        <input type="text" class="form-control" id="termo_busca" name="termo_busca">
      </div>
      <button type="submit" class="btn btn-primary">Pesquisar</button>
    </form>

    <!-- Tabela -->
    <table class="table table-striped table-hover">
      <thead>
        <tr>
          <th>ID</th>
          <th>Nome</th>
          <th>Descrição</th>
          <th>Data de Início</th>
          <th>Data de Término</th>
          <th>Status</th>
          <th>Membro Responsável</th>
          <th>Ações</th>
        </tr>
      </thead>
      <tbody>
        <?php
        if ($result->num_rows > 0) {
          while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row["id"] . "</td>";
            echo "<td>" . $row["nome"] . "</td>";
            echo "<td>" . $row["descricao"] . "</td>";
            echo "<td>" . $row["data_inicio"] . "</td>";
            echo "<td>" . $row["data_fim"] . "</td>";
            echo "<td>" . $row["status"] . "</td>";
            echo "<td>" . $row["membro_nome"] . "</td>";
            echo "<td>";
            echo "<div class='btn-group'>";
            echo "<button class='btn btn-primary' onclick='mostrarFormularioEdicao(" . $row["id"] . ")'>Editar</button>";
            echo "<button class='btn btn-danger' onclick='confirmarExclusao(" . $row["id"] . ")'>Excluir</button>";
            echo "</div>";
            echo "</td>";
            echo "</tr>";

            // Formulário de edição (oculto por padrão)
            echo "<tr id='form-edicao-" . $row["id"] . "' style='display: none'>";
            echo "<td colspan='7'>";
            echo "<form class='form-inline'>";
            echo "<div class='form-group mx-sm-3 mb-2'>";
            echo "<label for='nome-edicao-" . $row["id"] . "'>Nome:</label>";
            echo "<input type='text' class='form-control' id='nome-edicao-" . $row["id"] . "' value='" . $row["nome"] . "'><br>";
            echo "</div>";
            echo "<div class='form-group mx-sm-3 mb-2'>";
            echo "<label for='descricao-edicao-" . $row["id"] . "'>Descrição:</label>";
            echo "<textarea class='form-control' id='descricao-edicao-" . $row["id"] . "'>" . $row["descricao"] . "</textarea><br>";
            echo "</div>";
            echo "<div class='form-group mx-sm-3 mb-2'>";
            echo "<label for='data_inicio-edicao-" . $row["id"] . "'>Data de Início:</label>";
            echo "<input type='date' class='form-control' id='data_inicio-edicao-" . $row["id"] . "' value='" . $row["data_inicio"] . "'><br>";
            echo "</div>";
            echo "<div class='form-group mx-sm-3 mb-2'>";
            echo "<label for='data_fim-edicao-" . $row["id"] . "'>Data de Término:</label>";
            echo "<input type='date' class='form-control' id='data_fim-edicao-" . $row["id"] . "' value='" . $row["data_fim"] . "'><br>";
            echo "</div>";
            echo "<div class='form-group mx-sm-3 mb-2'>";
            echo "<label for='status-edicao-" . $row["id"] . "'>Status:</label>";
            echo "<select class='form-control' id='status-edicao-" . $row["id"] . "'>";
            echo "<option value='Em andamento' " . ($row["status"] == "Em andamento" ? "selected" : "") . ">Em andamento</option>";
            echo "<option value='Concluído' " . ($row["status"] == "Concluído" ? "selected" : "") . ">Concluído</option>";
            echo "<option value='Cancelado' " . ($row["status"] == "Cancelado" ? "selected" : "") . ">Cancelado</option>";
            echo "</select><br>";
            echo "</div>";
            echo "<div class='form-group mx-sm-3 mb-2'>";
            echo "<label for='membro_id-edicao-" . $row["id"] . "'>Membro Responsável:</label>";
            echo "<select class='form-control' id='membro_id-edicao-" . $row["id"] . "'>";
            // código PHP para exibir os membros disponíveis
            $sql_membros = "SELECT id, nome FROM membros";
            $result_membros = $conn->query($sql_membros);
            if ($result_membros->num_rows > 0) {
              while ($row_membro = $result_membros->fetch_assoc()) {
                echo "<option value='" . $row_membro["id"] . "' " . ($row["membro_id"] == $row_membro["id"] ? "selected" : "") . ">" . $row_membro["nome"] . "</option>";
              }
            }
            echo "</select><br>";
            echo "</div>";
            echo "<button type='button' class='btn btn-success' onclick='editarProjeto(" . $row["id"] . ")'>Salvar</button>";
            echo " <button type='button' class='btn btn-secondary' onclick='esconderFormularioEdicao(" . $row["id"] . ")'>Cancelar</button>";
            echo "</form>";
            echo "</td>";
            echo "</tr>";
          }
        } else {
          echo "<tr><td colspan='7'>Nenhum projeto encontrado.</td></tr>";
        }
        ?>
      </tbody>
    </table>

    <?php
    // Tratar a ação de edição
    if (isset($_GET["acao"]) && $_GET["acao"] == "editar") {
      $id = $_GET["id"];
      $nome = $_GET["nome"];
      $descricao = $_GET["descricao"];
      $data_inicio = $_GET["data_inicio"];
      $data_fim = $_GET["data_fim"];
      $status = $_GET["status"];
      $membro_id = $_GET["membro_id"];

      // Atualizar o projeto no banco de dados
      $sql = "UPDATE projetos SET nome='$nome', descricao='$descricao', data_inicio='$data_inicio', data_fim='$data_fim', status='$status', membro_id='$membro_id' WHERE id=$id";
      if ($conn->query($sql) === TRUE) {
        echo "<script>alert('Projeto atualizado com sucesso!');</script>";
      } else {
        echo "<script>alert('Erro ao atualizar projeto: " . $conn->error . "');</script>";
      }
    }

    // Tratar a ação de exclusão
    if (isset($_GET["acao"]) && $_GET["acao"] == "excluir") {
      $id = $_GET["id"];

      // Excluir o projeto do banco de dados
      $sql = "DELETE FROM projetos WHERE id=$id";
      if ($conn->query($sql) === TRUE) {
        echo "<script>alert('Projeto excluído com sucesso!');</script>";
      } else {
        echo "<script>alert('Erro ao excluir projeto: " . $conn->error . "');</script>";
      }
    }

    // Fechar a conexão
    $conn->close();
    ?>

  </div>

</body>
</html>