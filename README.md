# Sistema de Avaliação e Divulgação de Restaurantes

---

## **Visão Geral**

Este projeto é uma API para um sistema de avaliação e divulgação de restaurantes. Usuários podem se cadastrar, autenticar e interagir com restaurantes, menus e avaliações, criando, lendo, atualizando e excluindo registros de forma segura e seguindo regras de negócio bem definidas.

---

## **Funcionalidades**

- **Autenticação de Usuários**:
  - Criação de contas.
  - Login e logout.
  
- **Gerenciamento de Restaurantes**:
  - CRUD (Create, Read, Update, Delete).
  - Restrições: Apenas o criador pode editar ou excluir o restaurante.

- **Gerenciamento de Menus**:
  - CRUD de menus associados a restaurantes.
  - Restrições: Apenas o criador do restaurante pode adicionar ou gerenciar menus.

- **Gerenciamento de Avaliações**:
  - CRUD de avaliações associadas a restaurantes.
  - Restrições: Apenas o autor pode editar ou excluir suas avaliações.

- **Regras de Negócio**:
  - Exclusão de um restaurante exclui todos os menus e avaliações associados.
  - A associação de menus é restrita ao criador do restaurante.

---

## **Tecnologias Utilizadas**

- **Linguagem**: Ruby
- **Framework**: Ruby on Rails
- **Banco de Dados**: PostgreSQL
- **Autenticação**: Devise
- **Testes**: RSpec

---

## Como rodar

- bundle install
- rails db:create
- rails db:migrate
- rails db:seed
- rails server
