CREATE TABLE tb_usuario (
    usu_cod      INT AUTO_INCREMENT PRIMARY KEY,
    usu_nome     VARCHAR(100) NOT NULL,
    usu_email    VARCHAR(100) NOT NULL UNIQUE,
    usu_telefone VARCHAR(20),
    usu_senha    VARCHAR(255) NOT NULL,   -- armazena o hash bcrypt, nunca a senha pura
    usu_ativo    BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =========================================
-- TABELA DE LIVROS
-- =========================================

CREATE TABLE tb_livro (
    liv_cod          INT AUTO_INCREMENT PRIMARY KEY,
    liv_titulo       VARCHAR(150) NOT NULL,
    liv_autor        VARCHAR(100) NOT NULL,
    liv_categoria    VARCHAR(80)  NOT NULL,
    liv_quantidade   INT NOT NULL DEFAULT 0,   -- quantidade DISPONÍVEL
    liv_ativo        BOOLEAN NOT NULL DEFAULT TRUE,
    liv_datacadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_liv_quantidade CHECK (liv_quantidade >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =========================================
-- TABELA DE EMPRÉSTIMOS
-- =========================================

CREATE TABLE tb_emprestimo (
    emp_cod            INT AUTO_INCREMENT PRIMARY KEY,
    usu_cod            INT NOT NULL,
    emp_dataemprestimo DATE NOT NULL,
    emp_dataprevista   DATE NOT NULL,
    emp_datadevolucao  DATE NULL,
    emp_situacao       VARCHAR(20) NOT NULL DEFAULT 'ABERTO',

    CONSTRAINT fk_emprestimo_usuario
        FOREIGN KEY (usu_cod)
        REFERENCES tb_usuario(usu_cod),

    -- "ATRASADO" não é gravado: é calculado na consulta
    CONSTRAINT chk_emp_situacao
        CHECK (emp_situacao IN ('ABERTO', 'DEVOLVIDO')),

    CONSTRAINT chk_emp_datas
        CHECK (emp_dataprevista >= emp_dataemprestimo),

    -- devolvido <=> tem data de devolução
    CONSTRAINT chk_emp_devolucao
        CHECK (
            (emp_situacao = 'ABERTO'    AND emp_datadevolucao IS NULL) OR
            (emp_situacao = 'DEVOLVIDO' AND emp_datadevolucao IS NOT NULL)
        )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =========================================
-- TABELA DE ITENS DO EMPRÉSTIMO
-- =========================================

CREATE TABLE tb_itememprestimo (
    ite_cod        INT AUTO_INCREMENT PRIMARY KEY,
    emp_cod        INT NOT NULL,
    liv_cod        INT NOT NULL,
    ite_quantidade INT NOT NULL DEFAULT 1,

    CONSTRAINT fk_item_emprestimo
        FOREIGN KEY (emp_cod)
        REFERENCES tb_emprestimo(emp_cod),

    CONSTRAINT fk_item_livro
        FOREIGN KEY (liv_cod)
        REFERENCES tb_livro(liv_cod),

    CONSTRAINT uq_item_emprestimo_livro
        UNIQUE (emp_cod, liv_cod),

    CONSTRAINT chk_ite_quantidade
        CHECK (ite_quantidade > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =========================================
-- USUÁRIO ADMINISTRADOR PARA TESTES
-- E-mail: admin@biblioteca.com
-- Senha:  123456 (armazenada como hash bcrypt)
-- =========================================

INSERT INTO tb_usuario (usu_nome, usu_email, usu_telefone, usu_senha, usu_ativo)
VALUES (
    'Administrador',
    'admin@biblioteca.com',
    '(18) 99999-9999',
    '$2b$10$9BQGPMr55q3Ra2eU6lvyOe7V9eqgsd00AbqjoFIbOVTQ3Z8ctVTXm',
    TRUE
);


-- =========================================
-- LIVROS PARA TESTES
-- =========================================

INSERT INTO tb_livro (liv_titulo, liv_autor, liv_categoria, liv_quantidade)
VALUES
    ('Dom Casmurro', 'Machado de Assis', 'Romance',     5),
    ('O Hobbit',     'J. R. R. Tolkien', 'Fantasia',    3),
    ('Clean Code',   'Robert C. Martin', 'Programação', 4);