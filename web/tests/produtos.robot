***Settings***
Documentation   Cadastro de produtos/pratos
...             Sendo um cozinheiro amador
...             Quero cadastrar meus melhores pratos
...             Para que eu possa cozinha-los para outras pessoas

Resource    ../resources/base.robot

# Test Setup: tudo que vai ser executado antes do Test Case
Test Setup      Login Session       lele@gmail.com
# Test Teardown: tudo que vai ser executado depois do Test Case
Test Teardown   Close Session

***Variables***
&{nhoque}=      img=nhoque.jpg      nome=Nhoque molho páprica        tipo=Massas    preco=20.00

***Test Cases***
Novos pratos
    Dado que "${nhoque}" é um dos meus pratos
    Quando faço o cadastro desse item
    Então devo ver este prato no meu dashboard