*** Settings ***
Documentation               Receber pedidos
...                         Sendo um cozinheiro que possui produtos no dashboard
...                         Quero receber solicitação de preparo dos meus produtos
...                         Para que eu possa envia-los aos meus clientes

Resource                    ../resources/base.robot

Library                     RequestsLibrary
Library                     OperatingSystem

Test Setup                  Open Session
Test Teardown               Close Session

*** Test Cases ***
Receber novo pedido
    Dado que "eduguedes@gmail.com" é a minha conta de cozinheiro
    E "fernando@bol.com.br" é o email do meu cliente
    E que "Lamen" está cadastrado no meu dashboard
    Quando o cliente solicita o preparo desse prato
    Então devo receber uma notificação de pedido desse produto
    E posso aceitar ou rejeitar esse pedido

*** Keywords ***
Dado que "${email_cozinheiro}" é a minha conta de cozinheiro
    Set Test Variable       ${email_cozinheiro}

    &{headers}=             Create Dictionary       Content-Type=application/json
    &{payload}=             Create Dictionary       email=${email_cozinheiro}
    # Usou o & porque o tipo da variável criada é um dicionário

    Create Session          api             http://ninjachef-api-qaninja-io.umbler.net
    ${resp}=                Post Request    api         /sessions       data=${payload}     headers=${headers}
    Sleep                   15
    Status Should Be        200             ${resp}  

    ${token_cozinheiro}     Convert To String          ${resp.json()['_id']}  
    Set Test Variable       ${token_cozinheiro}

E "${email_cliente}" é o email do meu cliente
    Set Test Variable       ${email_cliente}

    &{headers}=             Create Dictionary       Content-Type=application/json
    &{payload}=             Create Dictionary       email=${email_cliente}

    Create Session          api             http://ninjachef-api-qaninja-io.umbler.net
    ${resp}=                Post Request    api         /sessions       data=${payload}     headers=${headers}
    Sleep                   15
    Status Should Be        200             ${resp}  

    ${token_cliente}        Convert To String          ${resp.json()['_id']}  
    Set Test Variable       ${token_cliente}

E que "${produto}" está cadastrado no meu dashboard
    Set Test Variable       ${produto}

    &{payload}              Create Dictionary       name=${produto}     plate=Tipo      price=20.00

    ${image_file}=          Get Binary File         ${EXECDIR}/resources/images/lamen.jpg
    &{files}                Create Dictionary       thumbnail=${image_file}

    &{headers}=             Create Dictionary       user_id=${token_cozinheiro}

    Create Session          api             http://ninjachef-api-qaninja-io.umbler.net
    # Enviar foto do produto através do objeto files, e o payload (contendo nome, tipo e preço) através do objeto data, headers vai passar o token para poder cadastrar
    ${resp}=                Post Request    api         /products       files=${files}     data=${payload}      headers=${headers}
    Status Should Be        200             ${resp}

    ${produto_id}           Convert To String          ${resp.json()['_id']}  
    Set Test Variable       ${produto_id}

    Go To                   ${base_url}

    Input Text              ${CAMPO_EMAIL}        ${email_cozinheiro}
    Click Element           ${BOTAO_ENTRAR}

    Wait Until Page Contains Element    ${DIV_DASH}

Quando o cliente solicita o preparo desse prato
    &{headers}=             Create Dictionary       Content-Type=application/json       user_id=${token_cliente}
    &{payload}=             Create Dictionary       payment=Dinheiro

    Create Session          api             http://ninjachef-api-qaninja-io.umbler.net
    ${resp}=                Post Request    api         /products/${produto_id}/orders       data=${payload}     headers=${headers}
    Status Should Be        200             ${resp}

    Sleep                   5