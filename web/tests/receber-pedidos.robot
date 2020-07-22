*** Settings ***
Documentation               Receber pedidos
...                         Sendo um cozinheiro que possui produtos no dashboard
...                         Quero receber solicitação de preparo dos meus produtos
...                         Para que eu possa envia-los aos meus clientes

Resource                    ../resources/base.robot

Library                     RequestsLibrary

Test Setup                  Open Session
Test Teardown               Close Session

*** Test Cases ***
Receber novo pedido
    Dado que "eduguedes@gmail.com" é a minha conta de cozinheiro
    E "fernando@bol.com.br" é o email do meu cliente
    E que "Carne de Jaca Louca" está cadastrado no meu dashboard
    Quando o cliente solicita o preparo desse prato
    Então devo receber uma notificação de pedido desse produto
    E posso aceitar ou rejeitar esse pedido

*** Keywords ***
Dado que "${email_cozinheiro}" é a minha conta de cozinheiro
    Set Test Variable       ${email_cozinheiro}

    &{headers}=             Create Dictionary       Content-Type=application/json
    &{payload}=             Create Dictionary       email=${email_cozinheiro}
    # Usou o & porque o tipo da variável criada é um dicionário

    Create Session          api             http://ninjachef-qaninja-io.umbler.net
    ${resp}=                Post Request    api         /sessions       data=${payload}     headers=${headers}
    Sleep                   15
    Status Should Be        200             ${resp}  

    Log To Console          ${resp.json()[_id]}  

E "${email_cliente}" é o email do meu cliente
    Set Test Variable       ${email_cliente}

E que "${produto}" está cadastrado no meu dashboard
    Set Test Variable       ${produto}