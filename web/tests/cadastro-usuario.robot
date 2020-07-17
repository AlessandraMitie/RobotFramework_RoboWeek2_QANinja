***Settings***
Documentation   Suíte dos testes de cadastro

Resource    ../resources/base.robot

# Test Setup: tudo que vai ser executado antes do Test Case
Test Setup      Open Session
# Test Teardown: tudo que vai ser executado depois do Test Case
Test Teardown   Close Session

# BDD
***Test Cases***
Cadastro simples
    Dado que acesso a página principal
    Quando submeto o meu email "alessandra@gmail.com"
    Então devo ser autenticado

Email incorreto
    Dado que acesso a página principal
    Quando submeto o meu email "alessandra&yahoo.com"
    Então devo ver a mensagem "Oops. Informe um email válido!"

Email não informado
    Dado que acesso a página principal
    Quando submeto o meu email "${EMPTY}"
    Então devo ver a mensagem "Oops. Informe um email válido!"