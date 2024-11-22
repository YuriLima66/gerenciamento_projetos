CREATE database gestao_projetos;

CREATE TABLE `departamentos` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departamentos`
--

INSERT INTO `departamentos` (`id`, `nome`, `descricao`) VALUES
(1, 'Desenvolvimento', 'Departamento responsável pelo desenvolvimento de software.'),
(2, 'Marketing', 'Departamento responsável pelas ações de marketing da empresa.'),
(3, 'Vendas', 'Departamento responsável pelas vendas dos produtos/serviços da empresa.'),
(4, 'Recursos Humanos', 'Departamento responsável por gestão de pessoas.'),
(5, 'Financeiro', 'Departamento responsável pelas finanças da empresa.'),
(6, 'Logística', 'Departamento responsável pela gestão da cadeia de suprimentos.'),
(7, 'Produção', 'Departamento responsável pela produção de bens ou serviços.'),
(8, 'Pesquisa e Desenvolvimento', 'Departamento responsável por pesquisas e inovação.'),
(9, 'Atendimento ao Cliente', 'Departamento responsável por atender as necessidades dos clientes.'),
(10, 'Tecnologia da Informação', 'Departamento responsável pela infraestrutura e sistemas de tecnologia da empresa.'),
(11, 'Jurídico', 'Departamento responsável por questões legais da empresa.'),
(12, 'Administrativo', 'Departamento responsável pelas atividades administrativas da empresa.'),
(13, 'Comercial', 'Departamento responsável pelas atividades comerciais da empresa.'),
(14, 'Engenharia', 'Departamento responsável por projetos de engenharia.'),
(15, 'Operações', 'Departamento responsável pelas operações da empresa.'),
(16, 'Qualidade', 'Departamento responsável pela garantia da qualidade dos produtos/serviços.'),
(17, 'Segurança', 'Departamento responsável pela segurança da empresa.'),
(18, 'Compras', 'Departamento responsável por compras de materiais e serviços.'),
(19, 'Manutenção', 'Departamento responsável por manutenção de equipamentos e instalações.'),
(20, 'Comunicação', 'Departamento responsável pela comunicação interna e externa da empresa.');

-- --------------------------------------------------------

--
-- Table structure for table `membros`
--

CREATE TABLE `membros` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `funcao` varchar(50) DEFAULT NULL,
  `senha` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `membros`
--

INSERT INTO `membros` (`id`, `nome`, `email`, `departamento_id`, `funcao`, `senha`) VALUES
(1, 'João da Silva', 'joao.silva@empresa.com', 1, 'Gerente de Projeto', 'senha_criptografada'),
(2, 'Maria Santos', 'maria.santos@empresa.com', 2, 'Desenvolvedora', 'senha_criptografada'),
(3, 'Pedro Oliveira', 'pedro.oliveira@empresa.com', 3, 'Analista de Vendas', 'senha_criptografada'),
(4, 'Ana Rodrigues', 'ana.rodrigues@empresa.com', 4, 'Analista de RH', 'senha_criptografada'),
(5, 'Carlos Pereira', 'carlos.pereira@empresa.com', 5, 'Contador', 'senha_criptografada'),
(6, 'Luiza Costa', 'luiza.costa@empresa.com', 6, 'Gerente de Logística', 'senha_criptografada'),
(7, 'Rafael Santos', 'rafael.santos@empresa.com', 7, 'Supervisor de Produção', 'senha_criptografada'),
(8, 'Bruna Silva', 'bruna.silva@empresa.com', 8, 'Pesquisadora', 'senha_criptografada'),
(9, 'Gabriel Souza', 'gabriel.souza@empresa.com', 9, 'Atendente', 'senha_criptografada'),
(10, 'Fernanda Oliveira', 'fernanda.oliveira@empresa.com', 10, 'Analista de TI', 'senha_criptografada'),
(11, 'Eduardo Santos', 'eduardo.santos@empresa.com', 11, 'Advogado', 'senha_criptografada'),
(12, 'Beatriz Rodrigues', 'beatriz.rodrigues@empresa.com', 12, 'Assistente Administrativo', 'senha_criptografada'),
(13, 'André Silva', 'andre.silva@empresa.com', 13, 'Gerente Comercial', 'senha_criptografada'),
(14, 'Mariana Costa', 'mariana.costa@empresa.com', 14, 'Engenheiro Civil', 'senha_criptografada'),
(15, 'Lucas Santos', 'lucas.santos@empresa.com', 15, 'Supervisor de Operações', 'senha_criptografada'),
(16, 'Carolina Oliveira', 'carolina.oliveira@empresa.com', 16, 'Analista de Qualidade', 'senha_criptografada'),
(17, 'Felipe Rodrigues', 'felipe.rodrigues@empresa.com', 17, 'Coordenador de Segurança', 'senha_criptografada'),
(18, 'Isabela Silva', 'isabela.silva@empresa.com', 18, 'Gerente de Compras', 'senha_criptografada'),
(19, 'Gustavo Santos', 'gustavo.santos@empresa.com', 19, 'Técnico de Manutenção', 'senha_criptografada'),
(20, 'Letícia Costa', 'leticia.costa@empresa.com', 20, 'Analista de Comunicação', 'senha_criptografada');

-- --------------------------------------------------------

--
-- Table structure for table `prioridades`
--

CREATE TABLE `prioridades` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prioridades`
--

INSERT INTO `prioridades` (`id`, `nome`, `descricao`) VALUES
(1, 'Alta', 'Tarefa com alta prioridade, requer atenção imediata.'),
(2, 'Média', 'Tarefa com prioridade média, deve ser concluída em tempo hábil.'),
(3, 'Baixa', 'Tarefa com baixa prioridade, pode ser concluída em um prazo mais longo.');

-- --------------------------------------------------------

--
-- Table structure for table `projetos`
--

CREATE TABLE `projetos` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `lider_id` int(11) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `membro_id` int(11) DEFAULT NULL,
  `recurso_principal_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `prioridade_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `projetos`
--

INSERT INTO `projetos` (`id`, `nome`, `descricao`, `data_inicio`, `data_fim`, `lider_id`, `departamento_id`, `membro_id`, `recurso_principal_id`, `status_id`, `prioridade_id`) VALUES
(1, 'Sistema de Gestão de Estoque', 'Desenvolvimento de um sistema web para gerenciar o estoque da empresa.', '2023-03-15', '2023-06-30', 1, 1, 1, 1, 2, NULL),
(2, 'Novo Site da Empresa', 'Criação de um novo site responsivo para a empresa.', '2023-04-01', '2023-07-15', 2, 2, 2, 6, 1, NULL),
(3, 'Campanha de Marketing Digital', 'Implementação de uma campanha de marketing digital para aumentar a visibilidade da empresa.', '2023-05-01', '2023-08-31', 3, 2, 3, 7, 1, NULL),
(4, 'Sistema de Recrutamento Online', 'Desenvolvimento de um sistema online para gerenciar processos de recrutamento.', '2023-06-01', '2023-09-30', 4, 4, 4, 1, 1, NULL),
(5, 'Relatório Anual de Finanças', 'Elaboração do relatório anual de finanças da empresa.', '2023-07-01', '2023-10-31', 5, 5, 5, 7, 1, NULL),
(6, 'Implementação de um novo sistema de logística', 'Implementação de um novo sistema de logística para otimizar a cadeia de suprimentos.', '2023-08-01', '2023-11-30', 6, 6, 6, 13, 1, NULL),
(7, 'Modernização da linha de produção', 'Modernização da linha de produção para aumentar a eficiência e qualidade.', '2023-09-01', '2023-12-31', 7, 7, 7, 1, 1, NULL),
(8, 'Pesquisa de novos materiais', 'Pesquisa de novos materiais para desenvolver produtos inovadores.', '2023-10-01', '2024-01-31', 8, 8, 8, 2, 1, NULL),
(9, 'Implementação de um novo sistema de atendimento ao cliente', 'Implementação de um novo sistema de atendimento ao cliente para melhorar a experiência do cliente.', '2023-11-01', '2024-02-28', 9, 9, 9, 1, 1, NULL),
(10, 'Migração para a nuvem', 'Migração dos sistemas da empresa para a nuvem.', '2023-12-01', '2024-03-31', 10, 10, 10, 17, 1, NULL),
(11, 'Atualização do sistema jurídico', 'Atualização do sistema jurídico para garantir conformidade com as leis.', '2024-01-01', '2024-04-30', 11, 11, 11, 7, 1, NULL),
(12, 'Reestruturação da área administrativa', 'Reestruturação da área administrativa para otimizar os processos.', '2024-02-01', '2024-05-31', 12, 12, 12, 7, 1, NULL),
(13, 'Lançamento de um novo produto', 'Lançamento de um novo produto no mercado.', '2024-03-01', '2024-06-30', 13, 13, 13, 1, 1, NULL),
(14, 'Construção de uma nova fábrica', 'Construção de uma nova fábrica para aumentar a capacidade de produção.', '2024-04-01', '2024-07-31', 14, 14, 14, 1, 1, NULL),
(15, 'Implementação de um novo sistema de gestão de operações', 'Implementação de um novo sistema de gestão de operações para otimizar os processos.', '2024-05-01', '2024-08-31', 15, 15, 15, 13, 1, NULL),
(16, 'Implementação de um sistema de gestão de qualidade', 'Implementação de um sistema de gestão de qualidade para garantir a qualidade dos produtos/serviços.', '2024-06-01', '2024-09-30', 16, 16, 16, 1, 1, NULL),
(17, 'Implementação de um sistema de segurança', 'Implementação de um sistema de segurança para proteger a empresa e seus funcionários.', '2024-07-01', '2024-10-31', 17, 17, 17, 1, 1, NULL),
(18, 'Modernização do sistema de compras', 'Modernização do sistema de compras para otimizar os processos.', '2024-08-01', '2024-11-30', 18, 18, 18, 1, 1, NULL),
(19, 'Manutenção preventiva dos equipamentos', 'Realizar manutenção preventiva dos equipamentos para garantir o bom funcionamento.', '2024-09-01', '2024-12-31', 19, 19, 19, 1, 1, NULL),
(20, 'Lançamento de uma nova campanha de comunicação', 'Lançamento de uma nova campanha de comunicação para comunicar os valores da empresa.', '2024-10-01', '2025-01-31', 20, 20, 20, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `recursos`
--

CREATE TABLE `recursos` (
  `id` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recursos`
--

INSERT INTO `recursos` (`id`, `tipo`, `nome`, `descricao`, `quantidade`) VALUES
(1, 'Hardware', 'Computadores', 'Computadores desktop para uso dos desenvolvedores.', 10),
(2, 'Software', 'Licença do Software X', 'Licença para uso do software X para desenvolvimento.', 5),
(3, 'Material', 'Papel A4', 'Papel A4 para impressões.', 1000),
(4, 'Software', 'Licença do Software Y', 'Licença para uso do software Y para gestão de projetos.', 3),
(5, 'Material', 'Canetas', 'Canetas para uso diário.', 500),
(6, 'Hardware', 'Impressoras', 'Impressoras para uso geral.', 5),
(7, 'Software', 'Pacote Office', 'Licença do pacote Office para uso geral.', 10),
(8, 'Material', 'Pasta A4', 'Pastas para organizar documentos.', 200),
(9, 'Hardware', 'Monitores', 'Monitores para uso nos computadores.', 15),
(10, 'Software', 'Antivirus', 'Licença do antivírus para os computadores.', 10),
(11, 'Material', 'Cartuchos de Tinta', 'Cartuchos de tinta para as impressoras.', 100),
(12, 'Hardware', 'Roteador', 'Roteador para a rede interna da empresa.', 2),
(13, 'Software', 'Sistema de Gestão de Projetos', 'Licença do sistema de gestão de projetos.', 5),
(14, 'Material', 'Caderno', 'Cadernos para anotações.', 100),
(15, 'Hardware', 'Câmeras de Segurança', 'Câmeras de segurança para monitorar a empresa.', 10),
(16, 'Software', 'Sistema de Controle de Acesso', 'Licença do sistema de controle de acesso.', 2),
(17, 'Material', 'Chaves', 'Chaves para acesso às dependências da empresa.', 50),
(18, 'Hardware', 'Servidor', 'Servidor para armazenar dados da empresa.', 2),
(19, 'Software', 'Sistema de CRM', 'Licença do sistema de CRM para gerenciar clientes.', 3),
(20, 'Material', 'Fita Adesiva', 'Fita adesiva para uso geral.', 100);

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id`, `nome`, `descricao`) VALUES
(1, 'Em andamento', 'Tarefa/Projeto em fase de execução.'),
(2, 'Concluída', 'Tarefa/Projeto finalizado.'),
(3, 'Bloqueada', 'Tarefa/Projeto com execução bloqueada por algum motivo.'),
(4, 'Cancelado', 'Tarefa/Projeto cancelado.'),
(5, 'Aguardando Aprovação', 'Tarefa/Projeto aguardando aprovação.'),
(6, 'Planejamento', 'Tarefa/Projeto em fase de planejamento.'),
(7, 'Em Teste', 'Tarefa/Projeto em fase de testes.'),
(8, 'Pendente', 'Tarefa/Projeto pendente de alguma ação.'),
(9, 'Concluída Parcialmente', 'Tarefa/Projeto concluído parcialmente.');



CREATE TABLE `tarefas` (
  `id` int(11) NOT NULL,
  `projeto_id` int(11) DEFAULT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `prioridade_id` int(11) DEFAULT NULL,
  `responsavel_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `tarefas` (`id`, `projeto_id`, `nome`, `descricao`, `data_inicio`, `data_fim`, `prioridade_id`, `responsavel_id`, `status_id`) VALUES
(22, 1, 'Desenvolver módulo de cadastro de produtos', 'Criar telas e funcionalidades para cadastro de produtos no sistema de gestão de estoque.', '2023-03-15', '2023-04-15', 1, 2, 1),
(23, 1, 'Implementar integração com sistema de pagamento', 'Integrar o sistema de gestão de estoque com um gateway de pagamento.', '2023-04-16', '2023-05-15', 2, 2, 5),
(24, 2, 'Criar design do novo site', 'Desenvolver o design do novo site da empresa, incluindo layout e elementos visuais.', '2023-04-01', '2023-04-30', 1, 2, 1),
(25, 3, 'Criar conteúdo para a campanha', 'Criar textos, imagens e vídeos para a campanha de marketing digital.', '2023-05-01', '2023-05-31', 2, 3, 1),
(26, 4, 'Criar formulário de inscrição online', 'Desenvolver um formulário online para candidatos se inscreverem para vagas.', '2023-06-01', '2023-06-30', 1, 4, 1),
(27, 5, 'Elaboração do relatório financeiro', 'Elaboração do relatório financeiro anual da empresa.', '2023-07-01', '2023-10-31', 1, 5, 1),
(28, 6, 'Análise de processos logísticos', 'Análise dos processos logísticos atuais para identificar áreas de melhoria.', '2023-08-01', '2023-08-31', 2, 6, 1),
(29, 7, 'Pesquisa de novas tecnologias de produção', 'Pesquisa de novas tecnologias de produção para aumentar a eficiência.', '2023-09-01', '2023-10-31', 1, 7, 1),
(30, 8, 'Testes de novos materiais', 'Realizar testes de novos materiais para avaliar sua viabilidade.', '2023-10-01', '2023-11-30', 2, 8, 1),
(31, 9, 'Desenvolver protótipo do novo sistema', 'Desenvolver um protótipo do novo sistema de atendimento ao cliente.', '2023-11-01', '2023-12-31', 1, 9, 1),
(32, 10, 'Migração de dados', 'Migrar os dados dos sistemas atuais para a nuvem.', '2023-12-01', '2024-01-31', 1, 10, 1),
(33, 11, 'Atualização do sistema jurídico', 'Atualização do sistema jurídico para garantir conformidade com as leis.', '2024-01-01', '2024-02-28', 2, 11, 1),
(34, 12, 'Reestruturação da área administrativa', 'Reestruturação da área administrativa para otimizar os processos.', '2024-02-01', '2024-03-31', 1, 12, 1),
(35, 13, 'Design do novo produto', 'Desenvolver o design do novo produto.', '2024-03-01', '2024-04-30', 1, 13, 1),
(36, 14, 'Planejamento da construção da fábrica', 'Planejamento da construção da nova fábrica.', '2024-04-01', '2024-05-31', 2, 14, 1),
(37, 15, 'Análise dos processos de operação', 'Análise dos processos de operação atuais para identificar áreas de melhoria.', '2024-05-01', '2024-06-30', 1, 15, 1),
(38, 16, 'Definição dos padrões de qualidade', 'Definição dos padrões de qualidade para os produtos/serviços.', '2024-06-01', '2024-07-31', 2, 16, 1),
(39, 17, 'Implementação de medidas de segurança', 'Implementação de medidas de segurança para proteger a empresa e seus funcionários.', '2024-07-01', '2024-08-31', 1, 17, 1),
(40, 18, 'Automatização do sistema de compras', 'Automatização do sistema de compras para otimizar os processos.', '2024-08-01', '2024-09-30', 2, 18, 1),
(41, 19, 'Manutenção preventiva dos equipamentos', 'Realizar manutenção preventiva dos equipamentos para garantir o bom funcionamento.', '2024-09-01', '2024-10-31', 1, 19, 1),
(42, 20, 'Lançamento de uma nova campanha de comunicação', 'Lançamento de uma nova campanha de comunicação para comunicar os valores da empresa.', '2024-10-01', '2025-01-31', 2, 20, 1);


ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `membros`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `departamento_id` (`departamento_id`);


ALTER TABLE `prioridades`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `projetos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lider_id` (`lider_id`),
  ADD KEY `departamento_id` (`departamento_id`),
  ADD KEY `membro_id` (`membro_id`),
  ADD KEY `recurso_principal_id` (`recurso_principal_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `FK_projetos_prioridades` (`prioridade_id`);


ALTER TABLE `recursos`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `tarefas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projeto_id` (`projeto_id`),
  ADD KEY `prioridade_id` (`prioridade_id`),
  ADD KEY `responsavel_id` (`responsavel_id`),
  ADD KEY `status_id` (`status_id`);


ALTER TABLE `departamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

ALTER TABLE `membros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;


ALTER TABLE `prioridades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;


ALTER TABLE `projetos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;


ALTER TABLE `recursos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;


ALTER TABLE `status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;


ALTER TABLE `tarefas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;


ALTER TABLE `membros`
  ADD CONSTRAINT `membros_ibfk_1` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`);


ALTER TABLE `projetos`
  ADD CONSTRAINT `FK_projetos_prioridades` FOREIGN KEY (`prioridade_id`) REFERENCES `prioridades` (`id`),
  ADD CONSTRAINT `projetos_ibfk_1` FOREIGN KEY (`lider_id`) REFERENCES `membros` (`id`),
  ADD CONSTRAINT `projetos_ibfk_2` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `projetos_ibfk_3` FOREIGN KEY (`membro_id`) REFERENCES `membros` (`id`),
  ADD CONSTRAINT `projetos_ibfk_4` FOREIGN KEY (`recurso_principal_id`) REFERENCES `recursos` (`id`),
  ADD CONSTRAINT `projetos_ibfk_5` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);


ALTER TABLE `tarefas`
  ADD CONSTRAINT `tarefas_ibfk_1` FOREIGN KEY (`projeto_id`) REFERENCES `projetos` (`id`),
  ADD CONSTRAINT `tarefas_ibfk_2` FOREIGN KEY (`prioridade_id`) REFERENCES `prioridades` (`id`),
  ADD CONSTRAINT `tarefas_ibfk_3` FOREIGN KEY (`responsavel_id`) REFERENCES `membros` (`id`),
  ADD CONSTRAINT `tarefas_ibfk_4` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);
COMMIT;

