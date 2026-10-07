# 📌 API para um sistema de Biblioteca

Você foi contratado por uma empresa de desenvolvimento e, durante o processo seletivo, o setor responsável identificou suas excelentes habilidades em **backend**.

Sua missão é desenvolver uma **API interna para uma biblioteca**, permitindo gerenciar livros, realizar empréstimos e controlar as devoluções.

---

## 🗂 Modelo Relacional

![Modelagem do banco de dados](img-bd.png)

📥 [Clique aqui para baixar o script do banco de dados](bd.sql)

---

## 🚀 Funcionalidades

### 📚 Gerenciamento de Livros

- **Cadastro de livros**
  - Cadastrar dados na tabela `tb_livro`
  - Informar título, autor, categoria e quantidade disponível
  - O campo `liv_datacadastro` deve ser preenchido automaticamente

- **Exclusão de livros (exclusão lógica)**
  - Atualizar a situação do livro para inativo
  - Livros inativos não devem aparecer como disponíveis para empréstimo

---

### 👤 Gerenciamento de Usuários

- **Cadastro de usuários**
  - Cadastrar nome, e-mail e telefone
  - O usuário deve possuir uma situação que indique se está ativo

- **Exclusão lógica de usuários**
  - Alterar a situação do usuário para inativo
  - Usuários inativos não podem realizar novos empréstimos

---

### 📖 Empréstimos

- Registrar o empréstimo de um ou mais livros para um usuário
- Armazenar:
  - Usuário responsável
  - Data do empréstimo
  - Data prevista para devolução
  - Situação do empréstimo

- Ao realizar um empréstimo:
  - Verificar se o usuário está ativo
  - Verificar se o livro está disponível
  - Diminuir a quantidade disponível do livro

📌 **Exemplo:**

Quantidade disponível: `5`  
Quantidade emprestada: `1`  
Nova quantidade disponível: `4`

---

### 🔄 Devolução de Livros

- Registrar a devolução do livro
- Armazenar a data efetiva da devolução
- Atualizar a situação do empréstimo
- Aumentar novamente a quantidade disponível do livro

⚠️ **Regras importantes**:
- Não permitir empréstimo de livro sem estoque disponível
- Não permitir empréstimo para usuário inativo
- Um livro já devolvido não pode ser devolvido novamente
- Utilizar **transações no banco** para evitar inconsistências

---

### ⏰ Controle de Atrasos

O sistema deverá identificar empréstimos que ultrapassaram a data prevista para devolução.

Um empréstimo será considerado atrasado quando:

```text
Data atual > Data prevista para devolução
```

O sistema deverá permitir consultar:

- Empréstimos em aberto
- Empréstimos atrasados
- Empréstimos já devolvidos

📌 **Exemplo:**

Data prevista: `20/09/2026`  
Data atual: `22/09/2026`  
Situação: `Atrasado`

---

### 🔐 Autenticação (JWT)

- Autenticação baseada na tabela `tb_usuario`
- Endpoint para **gerar token JWT**
- Middleware para **validar o token**
- Todos os endpoints (exceto geração do token) devem ser protegidos
- Token expira a cada **5 horas**

---

## ✅ Resumo das Funcionalidades

- [ ] Cadastro de livros
- [ ] Exclusão lógica de livros
- [ ] Cadastro de usuários
- [ ] Exclusão lógica de usuários
- [ ] Registro de empréstimos
- [ ] Controle de disponibilidade dos livros
- [ ] Devolução de livros
- [ ] Controle de empréstimos atrasados
- [ ] Utilização de transações
- [ ] Autenticação via JWT

---

## 📦 Projeto Inicial

📥 [Clique aqui para baixar o projeto base](#)

---

## 🏁 Observações

- Livros inativos não devem ser disponibilizados para empréstimo
- Usuários inativos não podem realizar novos empréstimos
- Livros sem quantidade disponível não podem ser emprestados
- Empréstimos já devolvidos não devem ser alterados para uma nova devolução
- Operações que alteram simultaneamente empréstimos e estoque devem utilizar **transações no banco**

---

## 🎯 Desafio

Ao finalizar a API, implemente também os seguintes endpoints:

```text
POST   /login
POST   /livros
GET    /livros
PUT    /livros/:id
DELETE /livros/:id

POST   /usuarios
GET    /usuarios
PUT    /usuarios/:id
DELETE /usuarios/:id

POST   /emprestimos
GET    /emprestimos
GET    /emprestimos/atrasados

PUT    /emprestimos/:id/devolver
```

O objetivo é praticar a criação de uma API completa, trabalhando com **CRUD, regras de negócio, banco de dados, transações e autenticação JWT**.
