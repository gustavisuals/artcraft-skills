---
name: craft-anything
description: "Opera o Craft Anything, exploração e recriação de software: inspeciona sites/binários (320 ferramentas, Ghidra opcional) e reconstrói, pelo CLI headless, por MCP ou abrindo o app. Use quando o pedido for entender como um site/app funciona, engenharia reversa de referência, recriar um site, ou quando citarem Craft Anything."
---

# Craft Anything

App open source da suíte ArtCraft ([storytold/craft-anything](https://github.com/storytold/craft-anything), Rust, Windows/macOS/Linux).
Função: exploração e recriação de software: inspeciona sites/binários (320 ferramentas, Ghidra opcional) e reconstrói.

Todo item de menu é um **comando** com id e parâmetros JSON. A UI, o CLI `craft-anything-cli`, o canal de controle JSON do app e o servidor MCP chamam os mesmos comandos. Então tudo que dá para clicar também dá para automatizar.

## 1. Localizar o executável
Windows (PowerShell):
```powershell
$h = if ($env:ARTCRAFT_HOME) { $env:ARTCRAFT_HOME } else { "$HOME\Apps\ArtCraft" }
$cli = Get-ChildItem -Recurse $h, "$env:LOCALAPPDATA\Programs", "$env:ProgramFiles" -Filter craft-anything-cli.exe -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
& $cli --version
```
macOS/Linux: `command -v craft-anything-cli`.
Se não achar, instale com a skill **artcraft** (`scripts/install.ps1 -Apps craft-anything`) ou pegue o zip portátil em https://github.com/storytold/craft-anything/releases/latest.

## 2. Como trabalhar
1. **Descubra antes de chutar.** Rode `craft-anything-cli --help` e liste os comandos (`commands`, ou `tools` no PdfCraft). Os ids mudam entre versões alpha, então confirme na versão instalada.
2. **Prefira o modo headless** (`run`/`render`/`convert`/`export`). É reproduzível e não depende de janela.
3. **Não sobrescreva o original sem pedir.** Salve ao lado do original ou numa pasta `_out`.
4. **Confira o resultado.** Renderize ou inspecione a saída e olhe o arquivo antes de dizer que terminou.
5. **Para o usuário ver ao vivo**, abra o app com `--control <porta>` e use o canal de controle ou o MCP em modo bridge (clique, screenshot).

## 3. Receitas (do README; confira os flags com --help)
```sh
craft-anything-cli commands
craft-anything-cli rebuild https://example.com "Recreate this website"
```
Resultados são registros de evidência; os grandes vêm paginados (core_evidence_browse).

## 4. MCP (para uso contínuo)
```sh
claude mcp add craft-anything -- <caminho>/craft-anything-cli mcp
```
Sempre que o CLI aceitar raízes de leitura/escrita, use-as para restringir o agente às pastas do projeto.

> Status: alpha ou em desenvolvimento. Se um comando falhar, anote a versão e o erro e use outro caminho (outro comando, ou a UI via canal de controle).