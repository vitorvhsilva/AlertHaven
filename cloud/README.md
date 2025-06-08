#  Global Solution 2025/1 - Cloud & DevOps

## Disciplina: DevOps Tools & Cloud Computing

Este repositório contém os artefatos desenvolvidos para a disciplina de **Cloud & DevOps**, como parte do projeto **Global Solution 2025/1** do curso de **Análise e Desenvolvimento de Sistemas** - 2º Ano (FIAP).

---


## Alunos

| Nome Completo         | RM      | Turma |
|-----------------------|---------|-------|
| Brendon de Paula       | RM559196 | 2TDSPY |
| João Ganança     | RM556405 | 2TDSPY |
| Vitor Hugo | RM558961 | 2TDSPY |

---

## Tema Geral: Eventos Extremos

O projeto propõe soluções tecnológicas para cenários impactados por desastres naturais, utilizando práticas modernas de desenvolvimento, containerização e orquestração de ambientes em nuvem.

---

## Objetivo da Disciplina

- **Conteinerizar** a API desenvolvida em Java (Spring Boot) ou .NET.
- Criar **dois containers**: um para a aplicação e outro para o banco de dados.
- Garantir persistência de dados, uso de boas práticas de Docker e evidências da execução via terminal.

---

## Estrutura do Projeto

```bash
├── API_JAVA/AlertHaven # Código-fonte da aplicação Java (Spring Boot)
├── Dockerfile # Dockerfile para conteinerização da aplicação
├── atualizar_usuario.json # JSON de exemplo para teste de atualização de usuário (PUT)
├── comandos.txt # Comandos utilizados para criar o ambiente
├── cria_vm.sh # Script de para criação de máquina virtual na nuvem
├── criar_usuario.json # JSON de exemplo para teste de criação de usuário (POST)
├── rotas.txt # Lista de rotas/endpoints disponíveis na API
```

## Requisitos Técnicos Atendidos

Abaixo estão os requisitos exigidos pela disciplina **Cloud & DevOps** e como eles foram atendidos neste projeto:

### API
- [x] API REST com suporte completo a operações **CRUD** 

### Banco de Dados
- [x] Banco de dados executado em **container separado** (PostgreSQL)

### Dockerfile Personalizado
- [x] Utilização de **usuário não-root**
- [x] Definição de **diretório de trabalho** (`WORKDIR`)
- [x] Uso de **variáveis de ambiente** (`ENV`)
- [x] Exposição de **porta para acesso externo** (`EXPOSE`)
- [x] Configuração de **volume para persistência** dos dados

### Execução e Evidências
- [x] **Logs acessíveis via terminal** (`docker logs`)
- [x] Containers executando em **modo background** (`-d` no `docker-compose` ou `docker run`)
