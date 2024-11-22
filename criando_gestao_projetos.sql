CREATE TABLE `departamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `membros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `funcao` varchar(50) DEFAULT NULL,
  `senha` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `departamento_id` (`departamento_id`),
  CONSTRAINT `membros_ibfk_1` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `prioridades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `projetos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `lider_id` int(11) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `membro_id` int(11) DEFAULT NULL,
  `recurso_principal_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `prioridade_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lider_id` (`lider_id`),
  KEY `departamento_id` (`departamento_id`),
  KEY `membro_id` (`membro_id`),
  KEY `recurso_principal_id` (`recurso_principal_id`),
  KEY `status_id` (`status_id`),
  KEY `FK_projetos_prioridades` (`prioridade_id`),
  CONSTRAINT `FK_projetos_prioridades` FOREIGN KEY (`prioridade_id`) REFERENCES `prioridades` (`id`),
  CONSTRAINT `projetos_ibfk_1` FOREIGN KEY (`lider_id`) REFERENCES `membros` (`id`),
  CONSTRAINT `projetos_ibfk_2` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  CONSTRAINT `projetos_ibfk_3` FOREIGN KEY (`membro_id`) REFERENCES `membros` (`id`),
  CONSTRAINT `projetos_ibfk_4` FOREIGN KEY (`recurso_principal_id`) REFERENCES `recursos` (`id`),
  CONSTRAINT `projetos_ibfk_5` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `recursos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tarefas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projeto_id` int(11) DEFAULT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `prioridade_id` int(11) DEFAULT NULL,
  `responsavel_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projeto_id` (`projeto_id`),
  KEY `prioridade_id` (`prioridade_id`),
  KEY `responsavel_id` (`responsavel_id`),
  KEY `status_id` (`status_id`),
  CONSTRAINT `tarefas_ibfk_1` FOREIGN KEY (`projeto_id`) REFERENCES `projetos` (`id`),
  CONSTRAINT `tarefas_ibfk_2` FOREIGN KEY (`prioridade_id`) REFERENCES `prioridades` (`id`),
  CONSTRAINT `tarefas_ibfk_3` FOREIGN KEY (`responsavel_id`) REFERENCES `membros` (`id`),
  CONSTRAINT `tarefas_ibfk_4` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;