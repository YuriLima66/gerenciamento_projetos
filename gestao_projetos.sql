CREATE TABLE departamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT
);

INSERT INTO departamentos (nome, descricao) VALUES
    ('Desenvolvimento', 'Departamento responsável pelo desenvolvimento de software.'),
    ('Marketing', 'Departamento responsável pelas ações de marketing da empresa.'),
    ('Vendas', 'Departamento responsável pelas vendas dos produtos/serviços da empresa.'),
    ('Recursos Humanos', 'Departamento responsável por gestão de pessoas.'),
    ('Financeiro', 'Departamento responsável pelas finanças da empresa.'),
    ('Logística', 'Departamento responsável pela gestão da cadeia de suprimentos.'),
    ('Produção', 'Departamento responsável pela produção de bens ou serviços.'),
    ('Pesquisa e Desenvolvimento', 'Departamento responsável por pesquisas e inovação.'),
    ('Atendimento ao Cliente', 'Departamento responsável por atender as necessidades dos clientes.'),
    ('Tecnologia da Informação', 'Departamento responsável pela infraestrutura e sistemas de tecnologia da empresa.'),
    ('Jurídico', 'Departamento responsável por questões legais da empresa.'),
    ('Administrativo', 'Departamento responsável pelas atividades administrativas da empresa.'),
    ('Comercial', 'Departamento responsável pelas atividades comerciais da empresa.'),
    ('Engenharia', 'Departamento responsável por projetos de engenharia.'),
    ('Operações', 'Departamento responsável pelas operações da empresa.'),
    ('Qualidade', 'Departamento responsável pela garantia da qualidade dos produtos/serviços.'),
    ('Segurança', 'Departamento responsável pela segurança da empresa.'),
    ('Compras', 'Departamento responsável por compras de materiais e serviços.'),
    ('Manutenção', 'Departamento responsável por manutenção de equipamentos e instalações.'),
    ('Comunicação', 'Departamento responsável pela comunicação interna e externa da empresa.');

    CREATE TABLE membros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    departamento_id INT,
    funcao VARCHAR(50),
    senha VARCHAR(255),
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

INSERT INTO membros (nome, email, departamento_id, funcao, senha) VALUES
    ('João da Silva', 'joao.silva@empresa.com', 1, 'Gerente de Projeto', '$2y$10$...'), -- Criptografe a senha
    ('Maria Santos', 'maria.santos@empresa.com', 2, 'Desenvolvedora', '$2y$10$...'), -- Criptografe a senha
    ('Pedro Oliveira', 'pedro.oliveira@empresa.com', 3, 'Analista de Vendas', '$2y$10$...'), -- Criptografe a senha
    ('Ana Rodrigues', 'ana.rodrigues@empresa.com', 4, 'Analista de RH', '$2y$10$...'), -- Criptografe a senha
    ('Carlos Pereira', 'carlos.pereira@empresa.com', 5, 'Contador', '$2y$10$...'), -- Criptografe a senha
    ('Luiza Costa', 'luiza.costa@empresa.com', 6, 'Gerente de Logística', '$2y$10$...'), -- Criptografe a senha
    ('Rafael Santos', 'rafael.santos@empresa.com', 7, 'Supervisor de Produção', '$2y$10$...'), -- Criptografe a senha
    ('Bruna Silva', 'bruna.silva@empresa.com', 8, 'Pesquisadora', '$2y$10$...'), -- Criptografe a senha
    ('Gabriel Souza', 'gabriel.souza@empresa.com', 9, 'Atendente', '$2y$10$...'), -- Criptografe a senha
    ('Fernanda Oliveira', 'fernanda.oliveira@empresa.com', 10, 'Analista de TI', '$2y$10$...'), -- Criptografe a senha
    ('Eduardo Santos', 'eduardo.santos@empresa.com', 11, 'Advogado', '$2y$10$...'), -- Criptografe a senha
    ('Beatriz Rodrigues', 'beatriz.rodrigues@empresa.com', 12, 'Assistente Administrativo', '$2y$10$...'), -- Criptografe a senha
    ('André Silva', 'andre.silva@empresa.com', 13, 'Gerente Comercial', '$2y$10$...'), -- Criptografe a senha
    ('Mariana Costa', 'mariana.costa@empresa.com', 14, 'Engenheiro Civil', '$2y$10$...'), -- Criptografe a senha
    ('Lucas Santos', 'lucas.santos@empresa.com', 15, 'Supervisor de Operações', '$2y$10$...'), -- Criptografe a senha
    ('Carolina Oliveira', 'carolina.oliveira@empresa.com', 16, 'Analista de Qualidade', '$2y$10$...'), -- Criptografe a senha
    ('Felipe Rodrigues', 'felipe.rodrigues@empresa.com', 17, 'Coordenador de Segurança', '$2y$10$...'), -- Criptografe a senha
    ('Isabela Silva', 'isabela.silva@empresa.com', 18, 'Gerente de Compras', '$2y$10$...'), -- Criptografe a senha
    ('Gustavo Santos', 'gustavo.santos@empresa.com', 19, 'Técnico de Manutenção', '$2y$10$...'), -- Criptografe a senha
    ('Letícia Costa', 'leticia.costa@empresa.com', 20, 'Analista de Comunicação', '$2y$10$...'); -- Criptografe a senha


    CREATE TABLE projetos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    data_inicio DATE,
    data_fim DATE,
    status VARCHAR(20) DEFAULT 'Em andamento',
    lider_id INT,
    departamento_id INT,
    FOREIGN KEY (lider_id) REFERENCES membros(id),
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

INSERT INTO projetos (nome, descricao, data_inicio, data_fim, lider_id, departamento_id) VALUES
    ('Sistema de Gestão de Estoque', 'Desenvolvimento de um sistema web para gerenciar o estoque da empresa.', '2023-03-15', '2023-06-30', 1, 1),
    ('Novo Site da Empresa', 'Criação de um novo site responsivo para a empresa.', '2023-04-01', '2023-07-15', 2, 2),
    ('Campanha de Marketing Digital', 'Implementação de uma campanha de marketing digital para aumentar a visibilidade da empresa.', '2023-05-01', '2023-08-31', 3, 2),
    ('Sistema de Recrutamento Online', 'Desenvolvimento de um sistema online para gerenciar processos de recrutamento.', '2023-06-01', '2023-09-30', 4, 4),
    ('Relatório Anual de Finanças', 'Elaboração do relatório anual de finanças da empresa.', '2023-07-01', '2023-10-31', 5, 5),
    ('Implementação de um novo sistema de logística', 'Implementação de um novo sistema de logística para otimizar a cadeia de suprimentos.', '2023-08-01', '2023-11-30', 6, 6),
    ('Modernização da linha de produção', 'Modernização da linha de produção para aumentar a eficiência e qualidade.', '2023-09-01', '2023-12-31', 7, 7),
    ('Pesquisa de novos materiais', 'Pesquisa de novos materiais para desenvolver produtos inovadores.', '2023-10-01', '2024-01-31', 8, 8),
    ('Implementação de um novo sistema de atendimento ao cliente', 'Implementação de um novo sistema de atendimento ao cliente para melhorar a experiência do cliente.', '2023-11-01', '2024-02-28', 9, 9),
    ('Migração para a nuvem', 'Migração dos sistemas da empresa para a nuvem.', '2023-12-01', '2024-03-31', 10, 10),
    ('Atualização do sistema jurídico', 'Atualização do sistema jurídico para garantir conformidade com as leis.', '2024-01-01', '2024-04-30', 11, 11),
    ('Reestruturação da área administrativa', 'Reestruturação da área administrativa para otimizar os processos.', '2024-02-01', '2024-05-31', 12, 12),
    ('Lançamento de um novo produto', 'Lançamento de um novo produto no mercado.', '2024-03-01', '2024-06-30', 13, 13),
    ('Construção de uma nova fábrica', 'Construção de uma nova fábrica para aumentar a capacidade de produção.', '2024-04-01', '2024-07-31', 14, 14),
    ('Implementação de um novo sistema de gestão de operações', 'Implementação de um novo sistema de gestão de operações para otimizar os processos.', '2024-05-01', '2024-08-31', 15, 15),
    ('Implementação de um sistema de gestão de qualidade', 'Implementação de um sistema de gestão de qualidade para garantir a qualidade dos produtos/serviços.', '2024-06-01', '2024-09-30', 16, 16),
    ('Implementação de um sistema de segurança', 'Implementação de um sistema de segurança para proteger a empresa e seus funcionários.', '2024-07-01', '2024-10-31', 17, 17),
    ('Modernização do sistema de compras', 'Modernização do sistema de compras para otimizar os processos.', '2024-08-01', '2024-11-30', 18, 18),
    ('Manutenção preventiva dos equipamentos', 'Manutenção preventiva dos equipamentos para garantir o bom funcionamento.', '2024-09-01', '2024-12-31', 19, 19),
    ('Lançamento de uma nova campanha de comunicação', 'Lançamento de uma nova campanha de comunicação para comunicar os valores da empresa.', '2024-10-01', '2025-01-31', 20, 20);

    CREATE TABLE prioridades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT
);

INSERT INTO prioridades (nome, descricao) VALUES
    ('Alta', 'Tarefa com alta prioridade, requer atenção imediata.'),
    ('Média', 'Tarefa com prioridade média, deve ser concluída em tempo hábil.'),
    ('Baixa', 'Tarefa com baixa prioridade, pode ser concluída em um prazo mais longo.');

    CREATE TABLE recursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    quantidade INT
);

INSERT INTO recursos (tipo, nome, descricao, quantidade) VALUES
    ('Hardware', 'Computadores', 'Computadores desktop para uso dos desenvolvedores.', 10),
    ('Software', 'Licença do Software X', 'Licença para uso do software X para desenvolvimento.', 5),
    ('Material', 'Papel A4', 'Papel A4 para impressões.', 1000),
    ('Software', 'Licença do Software Y', 'Licença para uso do software Y para gestão de projetos.', 3),
    ('Material', 'Canetas', 'Canetas para uso diário.', 500),
    ('Hardware', 'Impressoras', 'Impressoras para uso geral.', 5),
    ('Software', 'Pacote Office', 'Licença do pacote Office para uso geral.', 10),
    ('Material', 'Pasta A4', 'Pastas para organizar documentos.', 200),
    ('Hardware', 'Monitores', 'Monitores para uso nos computadores.', 15),
    ('Software', 'Antivirus', 'Licença do antivírus para os computadores.', 10),
    ('Material', 'Cartuchos de Tinta', 'Cartuchos de tinta para as impressoras.', 100),
    ('Hardware', 'Roteador', 'Roteador para a rede interna da empresa.', 2),
    ('Software', 'Sistema de Gestão de Projetos', 'Licença do sistema de gestão de projetos.', 5),
    ('Material', 'Caderno', 'Cadernos para anotações.', 100),
    ('Hardware', 'Câmeras de Segurança', 'Câmeras de segurança para monitorar a empresa.', 10),
    ('Software', 'Sistema de Controle de Acesso', 'Licença do sistema de controle de acesso.', 2),
    ('Material', 'Chaves', 'Chaves para acesso às dependências da empresa.', 50),
    ('Hardware', 'Servidor', 'Servidor para armazenar dados da empresa.', 2),
    ('Software', 'Sistema de CRM', 'Licença do sistema de CRM para gerenciar clientes.', 3),
    ('Material', 'Fita Adesiva', 'Fita adesiva para uso geral.', 100);


    CREATE TABLE status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT
);


INSERT INTO status (nome, descricao) VALUES
    ('Em andamento', 'Tarefa/Projeto em fase de execução.'),
    ('Concluída', 'Tarefa/Projeto finalizado.'),
    ('Bloqueada', 'Tarefa/Projeto com execução bloqueada por algum motivo.'),
    ('Cancelado', 'Tarefa/Projeto cancelado.'),
    ('Aguardando Aprovação', 'Tarefa/Projeto aguardando aprovação.'),
    ('Planejamento', 'Tarefa/Projeto em fase de planejamento.'),
    ('Em Teste', 'Tarefa/Projeto em fase de testes.'),
    ('Pendente', 'Tarefa/Projeto pendente de alguma ação.'),
    ('Concluída Parcialmente', 'Tarefa/Projeto concluído parcialmente.');


    CREATE TABLE tarefas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    projeto_id INT,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    data_inicio DATE,
    data_fim DATE,
    status VARCHAR(20) DEFAULT 'Em andamento',
    prioridade_id INT,
    responsavel_id INT,
    FOREIGN KEY (projeto_id) REFERENCES projetos(id),
    FOREIGN KEY (prioridade_id) REFERENCES prioridades(id),
    FOREIGN KEY (responsavel_id) REFERENCES membros(id)
);


INSERT INTO tarefas (projeto_id, nome, descricao, data_inicio, data_fim, prioridade_id, responsavel_id, status) VALUES
    (1, 'Desenvolver módulo de cadastro de produtos', 'Criar telas e funcionalidades para cadastro de produtos no sistema de gestão de estoque.', '2023-03-15', '2023-04-15', 1, 2, 'Em andamento'),
    (1, 'Implementar integração com sistema de pagamento', 'Integrar o sistema de gestão de estoque com um gateway de pagamento.', '2023-04-16', '2023-05-15', 2, 2, 'Planejamento'),
    (2, 'Criar design do novo site', 'Desenvolver o design do novo site da empresa, incluindo layout e elementos visuais.', '2023-04-01', '2023-04-30', 1, 2, 'Em andamento'),
    (3, 'Criar conteúdo para a campanha', 'Criar textos, imagens e vídeos para a campanha de marketing digital.', '2023-05-01', '2023-05-31', 2, 3, 'Em andamento'),
    (4, 'Criar formulário de inscrição online', 'Desenvolver um formulário online para candidatos se inscreverem para vagas.', '2023-06-01', '2023-06-30', 1, 4, 'Em andamento'),
    (5, 'Elaboração do relatório financeiro', 'Elaboração do relatório financeiro anual da empresa.', '2023-07-01', '2023-10-31', 1, 5, 'Em andamento'),
    (6, 'Análise de processos logísticos', 'Análise dos processos logísticos atuais para identificar áreas de melhoria.', '2023-08-01', '2023-08-31', 2, 6, 'Em andamento'),
    (7, 'Pesquisa de novas tecnologias de produção', 'Pesquisa de novas tecnologias de produção para aumentar a eficiência.', '2023-09-01', '2023-10-31', 1, 7, 'Em andamento'),
    (8, 'Testes de novos materiais', 'Realizar testes de novos materiais para avaliar sua viabilidade.', '2023-10-01', '2023-11-30', 2, 8, 'Em andamento'),
    (9, 'Desenvolver protótipo do novo sistema', 'Desenvolver um protótipo do novo sistema de atendimento ao cliente.', '2023-11-01', '2023-12-31', 1, 9, 'Em andamento'),
    (10, 'Migração de dados', 'Migrar os dados dos sistemas atuais para a nuvem.', '2023-12-01', '2024-01-31', 1, 10, 'Em andamento'),
    (11, 'Atualização do sistema jurídico', 'Atualização do sistema jurídico para garantir conformidade com as leis.', '2024-01-01', '2024-02-28', 2, 11, 'Em andamento'),
    (12, 'Reestruturação da área administrativa', 'Reestruturação da área administrativa para otimizar os processos.', '2024-02-01', '2024-03-31', 1, 12, 'Em andamento'),
    (13, 'Design do novo produto', 'Desenvolver o design do novo produto.', '2024-03-01', '2024-04-30', 1, 13, 'Em andamento'),
    (14, 'Planejamento da construção da fábrica', 'Planejamento da construção da nova fábrica.', '2024-04-01', '2024-05-31', 2, 14, 'Em andamento'),
    (15, 'Análise dos processos de operação', 'Análise dos processos de operação atuais para identificar áreas de melhoria.', '2024-05-01', '2024-06-30', 1, 15, 'Em andamento'),
    (16, 'Definição dos padrões de qualidade', 'Definição dos padrões de qualidade para os produtos/serviços.', '2024-06-01', '2024-07-31', 2, 16, 'Em andamento'),
    (17, 'Implementação de medidas de segurança', 'Implementação de medidas de segurança para proteger a empresa e seus funcionários.', '2024-07-01', '2024-08-31', 1, 17, 'Em andamento'),
    (18, 'Automatização do sistema de compras', 'Automatização do sistema de compras para otimizar os processos.', '2024-08-01', '2024-09-30', 2, 18, 'Em andamento'),
    (19, 'Manutenção preventiva dos equipamentos', 'Realizar manutenção preventiva dos equipamentos para garantir o bom funcionamento.', '2024-09-01', '2024-10-31', 1, 19, 'Em andamento'),
    (20, 'Criação do material de comunicação', 'Criação de materiais para comunicar os valores da empresa.', '2024-10-01', '2024-11-30', 2, 20, 'Em andamento');