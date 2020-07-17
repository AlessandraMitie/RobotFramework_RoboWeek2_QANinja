***Settings***
Documentation       Código base para abrir uma sessao com o Appium Server

Library             AppiumLibrary

Resource            kws.robot

***Keywords***
# Hooks
Open Session
    # 1º parâmetro: remoteurl, que é o servidor do appium que está na minha máquna local. O endpoint é wd/hub
    # 2º parâmetro: são os capabilities
    # ... é chamado de argumento multiline, é como se fosse uma quebra de linha
    Open Application    http://localhost:4723/wd/hub
    ...                 automationName=UiAutomator2
    ...                 platformName=Android
    ...                 deviceName=Emulator
    ...                 app=${EXECDIR}/app/ninjachef.apk
    ...                 udid=emulator-5554
    ...                 adbExecTimeout=120000

Close Session
    Capture Page Screenshot
    Close Application