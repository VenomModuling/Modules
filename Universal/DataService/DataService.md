# Data Service Module

Este módulo fornece funcionalidades para gerar, enviar e recuperar chaves associadas a um jogador dentro de um jogo Roblox. As chaves são geradas aleatoriamente e podem ser enviadas para um servidor remoto, onde são armazenadas e recuperadas posteriormente.
# Loadstring:
```lua
local Module = loadstring(game:HttpGet("https://raw.githubusercontent.com/VenomModuling/Modules/refs/heads/main/Universal/DataService.luau"))()
```
## Funcionalidades

### 1. `Module:generate(tamanho)`
Esta função gera uma chave aleatória de tamanho especificado. A chave é composta por caracteres alfanuméricos (letras maiúsculas e minúsculas, e números).

#### Parâmetros:
- `tamanho` (número): O número de caracteres que a chave gerada terá.

#### Exemplo de uso:
```lua
local chave = Module:generate(16)
print(chave)  -- Exemplo de chave gerada: "aB12Cd34Ef56Gh78"
```
### **2. `Post Key Function`**

```markdown
# Função `Module:PostKey(Key)`

Esta função envia uma chave para um servidor remoto utilizando o método HTTP `POST`. A chave é enviada juntamente com o `UserId` do jogador, ambos codificados em base64.

## Parâmetros:
- `Key` (string): A chave a ser enviada para o servidor.

## Exemplo de uso:
```lua
Module:PostKey("sua_chave_aqui")
```
### **3. `Get Key Function`**

```markdown
# Função `Module:GetKey()`

Esta função faz uma requisição HTTP `GET` para recuperar uma chave associada ao jogador no servidor remoto. A chave é buscada de acordo com o `UserId` do jogador. Se a chave for encontrada, ela é decodificada de base64 e retornada.

## Exemplo de uso:
```lua
local chave = Module:GetKey()
if chave then
    print("Chave encontrada: " .. chave)
else
    print("Nenhuma chave encontrada para o usuário.")
end
```
