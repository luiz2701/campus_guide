# Guia de setup de ambiente de desenvolvimento - Campus Guide

## Passo 1 - Instalar Android Studio

Acesse o site https://developer.android.com/studio?hl=pt-br

Clique em **Baixar o Android Studio Panda 4**

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/20264dcd68d7457ccd74003ca38da35fc8ba7f19/screenshots/Captura%20de%20tela%202026-05-05%20074512.png)

Aceite os termos e clique para fazer o download

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20074530.png)

Após terminado o download, abra o instalador

Clique em next 

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20075458.png)

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20075539.png)

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20075630.png)

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20075554.png)

**Accept** e **next**

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20075646.png)

**Finish**

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20080424.png)

Com o Android Studio aberto, clique em **More Actions** -> **SDK Manager**

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20080502.png)

Clique em **SDK Tools**

Garanta que os pacotes **Android SDK Build-Tools**, **Android SDK Command-line Tools (latest)**, e **Android SDK Plataform-Tools** estão instalados, se algum desses pacotes não estiver instalado selecione-o e clique em **apply** para começar a instalação

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20080642.png)

## Passo 2 - Instalar o Flutter

Abra o seu **Visual Studio Code**

Em **extensões** pesquise por **Flutter**

Clique em **Instalar**

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20082450.png)

Após instalado, use as teclas **Ctrl+Shift+P** para abrir a **Paleta de comandos**, alternativamente, você pode acessar a paleta clicando em **Exibir**

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20082710.png)

Digite **Flutter** e clique em **New Project**

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20082802.png)

O vs code vai abrir um pop up dizendo que não foi possível localizar um Flutter SDK, clique em **Download SDK**

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20082829.png)

Escolha onde você quer instalar o Flutter, recomendo a pasta **/C:**

Clique em Clone Flutter

Assim que a instalação terminar, o vs code vai abrir outro pop up, perguntando se você quer adicionar o **Flutter** ao **PATH**, clique em **Add SDK to PATH**

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20084022.png)

## Passo 3 - Corrijindo possíveis erros

Já com o projeto aberto, no terminal rode o comando `flutter doctor`

Possíveis erros: 

`Android license status unknown`, para corrigir, rode o comando `flutter doctor --android-licenses`, **y -> Enter** até acabar

`Visual Studio not installed; this is necessary to develop Windows apps.`, para corrigir, acesse o site **https://visualstudio.microsoft.com/pt-br/downloads/** e instale a versão community

`The current Visual Studio installation is incomplete`, para corrigir, acesse seu **Visual Studio Installer** e clique em **modificar**

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/63ad484655598070889fecf3bdcd8feaca646a40/screenshots/Captura%20de%20tela%202026-05-05%20110516.png)
Em **Cargas de trabalho**, selecione **Desenvolvimento para desktop com C++** e **SDK do Windows 11**. CLique em **Instalar**

![image alt](https://github.com/KauaaRodrigo/campus_guide/blob/84721f013d1e487d5e8ca14ae1fff96743451bec/screenshots/Captura%20de%20tela%202026-05-05%20085542.png)

Após finalizado, volte no vs code e novamente rode `flutter doctor`, se todos os problemas estiverem corrigidos, rode o projeto com **F5**

## Observações

Pode ser que ao abrir o projeto, seu vs code ja alerte que não há um Flutter SDK instalado, se isso ocorrer você pode seguir com a instalação do SDK normalmente, mas lembre-se que ainda é necessário instalar a extensão
