# Como iniciar o desenvolvimento local:

1. Certifique-se de ter instalado e configurado seu ambiente corretamente

2. Em sua pasta de projetos, abra um terminal e clone este repositório em sua máquina.
```
git clone https://github.com/gerlandoprado/OST.git
```

Em caso de erros, utilize o Github CLI ou o Ambiente Desktop do Github para fazer o clone.

3. No diretorio raiz do projeto clonado, execute o seguinte comando do flutter:
```
flutter pub get
```

O comando vai instalar as dependências necessárias para o projeto

Caso haja dependências desatualizadas, execute:
```
flutter pub outdated

flutter pub upgrade
```

## Executando um Dispositivo ou Emulador

__Dispositivo Fisico Android__

1. Ativar o modo de Depuração em opções de desenvolvedor

2. Conectar o dispositivo movel por cabo USB e permitir o compartilhamento de dados

3. Executar o comando
```
flutter devices

// executa o aplicativo no celular
flutter run
```