CREATE TABLE `departamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,  
  `nome` varchar(255) NOT NULL,         
  `descricao` text DEFAULT NULL,         
  PRIMARY KEY (`id`)                     
) 

CREATE TABLE `membros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,  -- Define a coluna 'id' como inteiro, com 11 dígitos, não nula e com auto-incremento (chave primária gerada automaticamente)
  `nome` varchar(255) NOT NULL,          -- Define a coluna 'nome' como string de no máximo 255 caracteres, não nula
  `email` varchar(255) NOT NULL,         -- Define a coluna 'email' como string de no máximo 255 caracteres, não nula
  `departamento_id` int(11) DEFAULT NULL, -- Define a coluna 'departamento_id' como inteiro, com 11 dígitos, podendo ser nula (chave estrangeira para departamentos)
  `funcao` varchar(50) DEFAULT NULL,     -- Define a coluna 'funcao' como string de no máximo 50 caracteres, podendo ser nula
  `senha` varchar(255) DEFAULT NULL,     -- Define a coluna 'senha' como string de no máximo 255 caracteres, podendo ser nula
  PRIMARY KEY (`id`),                     -- Define 'id' como chave primária, garantindo unicidade e indexação
  UNIQUE KEY `email` (`email`),          -- Define 'email' como chave única, garantindo que não haja emails repetidos
  KEY `departamento_id` (`departamento_id`), -- Cria um índice na coluna 'departamento_id' para otimizar consultas
  CONSTRAINT `membros_ibfk_1` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`) -- Define 'departamento_id' como chave estrangeira, referenciando a tabela 'departamentos'
) 

DROP TABLE IF EXISTS`prioridades`;

CREATE TABLE `prioridades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,  -- Define a coluna 'id' como inteiro, com 11 dígitos, não nula e com auto-incremento (chave primária gerada automaticamente)
  `nome` varchar(255) NOT NULL,          -- Define a coluna 'nome' como string de no máximo 255 caracteres, não nula
  `descricao` text DEFAULT NULL,         -- Define a coluna 'descricao' como texto de tamanho variável, podendo ser nula (valor padrão NULL)
  PRIMARY KEY (`id`)                     -- Define 'id' como chave primária, garantindo unicidade e indexação
) 

DROP TABLE IF EXISTS`projetos`;

CREATE TABLE `projetos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,  -- Define a coluna 'id' como inteiro, com 11 dígitos, não nula e com auto-incremento (chave primária gerada automaticamente)
  `nome` varchar(255) NOT NULL,          -- Define a coluna 'nome' como string de no máximo 255 caracteres, não nula
  `descricao` text DEFAULT NULL,         -- Define a coluna 'descricao' como texto de tamanho variável, podendo ser nula (valor padrão NULL)
  `data_inicio` date DEFAULT NULL,       -- Define a coluna 'data_inicio' como data, podendo ser nula (valor padrão NULL)
  `data_fim` date DEFAULT NULL,         -- Define a coluna 'data_fim' como data, podendo ser nula (valor padrão NULL)
  `lider_id` int(11) DEFAULT NULL,       -- Define a coluna 'lider_id' como inteiro, com 11 dígitos, podendo ser nula (chave estrangeira para membros)
  `departamento_id` int(11) DEFAULT NULL, -- Define a coluna 'departamento_id' como inteiro, com 11 dígitos, podendo ser nula (chave estrangeira para departamentos)
  `membro_id` int(11) DEFAULT NULL,       -- Define a coluna 'membro_id' como inteiro, com 11 dígitos, podendo ser nula (chave estrangeira para membros)
  `recurso_principal_id` int(11) DEFAULT NULL, -- Define a coluna 'recurso_principal_id' como inteiro, com 11 dígitos, podendo ser nula (chave estrangeira para recursos)
  `status_id` int(11) DEFAULT NULL,       -- Define a coluna 'status_id' como inteiro, com 11 dígitos, podendo ser nula (chave estrangeira para status)
  `prioridade_id` int(11) DEFAULT NULL,   -- Define a coluna 'prioridade_id' como inteiro, com 11 dígitos, podendo ser nula (chave estrangeira para prioridades)
  PRIMARY KEY (`id`),                     -- Define 'id' como chave primária, garantindo unicidade e indexação
  KEY `lider_id` (`lider_id`),           -- Cria um índice na coluna 'lider_id' para otimizar consultas
  KEY `departamento_id` (`departamento_id`), -- Cria um índice na coluna 'departamento_id' para otimizar consultas
  KEY `membro_id` (`membro_id`),         -- Cria um índice na coluna 'membro_id' para otimizar consultas
  KEY `recurso_principal_id` (`recurso_principal_id`), -- Cria um índice na coluna 'recurso_principal_id' para otimizar consultas
  KEY `status_id` (`status_id`),         -- Cria um índice na coluna 'status_id' para otimizar consultas
  KEY `FK_projetos_prioridades` (`prioridade_id`), -- Cria um índice na coluna 'prioridade_id' para otimizar consultas
  CONSTRAINT `FK_projetos_prioridades` FOREIGN KEY (`prioridade_id`) REFERENCES `prioridades` (`id`), -- Define 'prioridade_id' como chave estrangeira, referenciando a tabela 'prioridades'
  CONSTRAINT `projetos_ibfk_1` FOREIGN KEY (`lider_id`) REFERENCES `membros` (`id`), -- Define 'lider_id' como chave estrangeira, referenciando a tabela 'membros'
  CONSTRAINT `projetos_ibfk_2` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`), -- Define 'departamento_id' como chave estrangeira, referenciando a tabela 'departamentos'
  CONSTRAINT `projetos_ibfk_3` FOREIGN KEY (`membro_id`) REFERENCES `membros` (`id`), -- Define 'membro_id' como chave estrangeira, referenciando a tabela 'membros'
  CONSTRAINT `projetos_ibfk_4` FOREIGN KEY (`recurso_principal_id`) REFERENCES `recursos` (`id`), -- Define 'recurso_principal_id' como chave estrangeira, referenciando a tabela 'recursos'
  CONSTRAINT `projetos_ibfk_5` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`)  -- Define 'status_id' como chave estrangeira, referenciando a tabela 'status'
) 

DROP TABLE IF EXISTS`recursos`;


CREATE TABLE `recursos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,  -- Define a coluna 'id' como inteiro, com 11 dígitos, não nula e com auto-incremento (chave primária gerada automaticamente)
  `tipo` varchar(50) NOT NULL,          -- Define a coluna 'tipo' como string de no máximo 50 caracteres, não nula
  `nome` varchar(255) NOT NULL,          -- Define a coluna 'nome' como string de no máximo 255 caracteres, não nula
  `descricao` text DEFAULT NULL,         -- Define a coluna 'descricao' como texto de tamanho variável, podendo ser nula (valor padrão NULL)
  `quantidade` int(11) DEFAULT NULL,     -- Define a coluna 'quantidade' como inteiro, com 11 dígitos, podendo ser nula (valor padrão NULL)
  PRIMARY KEY (`id`)                     -- Define 'id' como chave primária, garantindo unicidade e indexação
) 

DROP TABLE IF EXISTS`status`;


CREATE TABLE `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,  -- Define a coluna 'id' como inteiro, com 11 dígitos, não nula e com auto-incremento (chave primária gerada automaticamente)
  `nome` varchar(255) NOT NULL,          -- Define a coluna 'nome' como string de no máximo 255 caracteres, não nula
  `descricao` text DEFAULT NULL,         -- Define a coluna 'descricao' como texto de tamanho variável, podendo ser nula (valor padrão NULL)
  PRIMARY KEY (`id`)                     -- Define 'id' como chave primária, garantindo unicidade e indexação
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; -- Especifica o motor de armazenamento InnoDB, o conjunto de caracteres e o cotejamento.


DROP TABLE IF EXISTS`tarefas`;


CREATE TABLE `tarefas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,  -- Define a coluna 'id' como inteiro, com 11 dígitos, não nula e com auto-incremento (chave primária gerada automaticamente)
  `projeto_id` int(11) DEFAULT NULL,     -- Define a coluna 'projeto_id' como inteiro, com 11 dígitos, podendo ser nula (chave estrangeira para projetos)
  `nome` varchar(255) NOT NULL,          -- Define a coluna 'nome' como string de no máximo 255 caracteres, não nula
  `descricao` text DEFAULT NULL,         -- Define a coluna 'descricao' como texto de tamanho variável, podendo ser nula (valor padrão NULL)
  `data_inicio` date DEFAULT NULL,       -- Define a coluna 'data_inicio' como data, podendo ser nula (valor padrão NULL)
  `data_fim` date DEFAULT NULL,         -- Define a coluna 'data_fim' como data, podendo ser nula (valor padrão NULL)
  `prioridade_id` int(11) DEFAULT NULL,   -- Define a coluna 'prioridade_id' como inteiro, com 11 dígitos, podendo ser nula (chave estrangeira para prioridades)
  `responsavel_id` int(11) DEFAULT NULL, -- Define a coluna 'responsavel_id' como inteiro, com 11 dígitos, podendo ser nula (chave estrangeira para membros)
  `status_id` int(11) DEFAULT NULL,       -- Define a coluna 'status_id' como inteiro, com 11 dígitos, podendo ser nula (chave estrangeira para status)
  PRIMARY KEY (`id`),                     -- Define 'id' como chave primária, garantindo unicidade e indexação
  KEY `projeto_id` (`projeto_id`),       -- Cria um índice na coluna 'projeto_id' para otimizar consultas
  KEY `prioridade_id` (`prioridade_id`), -- Cria um índice na coluna 'prioridade_id' para otimizar consultas
  KEY `responsavel_id` (`responsavel_id`), -- Cria um índice na coluna 'responsavel_id' para otimizar consultas
  KEY `status_id` (`status_id`),         -- Cria um índice na coluna 'status_id' para otimizar consultas
  CONSTRAINT `tarefas_ibfk_1` FOREIGN KEY (`projeto_id`) REFERENCES `projetos` (`id`), -- Define 'projeto_id' como chave estrangeira, referenciando a tabela 'projetos'
  CONSTRAINT `tarefas_ibfk_2` FOREIGN KEY (`prioridade_id`) REFERENCES `prioridades` (`id`), -- Define 'prioridade_id' como chave estrangeira, referenciando a tabela 'prioridades'
  CONSTRAINT `tarefas_ibfk_3` FOREIGN KEY (`responsavel_id`) REFERENCES `membros` (`id`), -- Define 'responsavel_id' como chave estrangeira, referenciando a tabela 'membros'
  CONSTRAINT `tarefas_ibfk_4` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`)  -- Define 'status_id' como chave estrangeira, referenciando a tabela 'status'
) 