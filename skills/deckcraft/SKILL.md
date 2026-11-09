---
name: deckcraft
description: "Opera o DeckCraft, apresentações (estilo Keynote/PowerPoint): slides, layouts, apresentação ao vivo, pelo CLI headless, por MCP ou abrindo o app. Use quando o pedido for montar deck de slides, apresentação de proposta, renderizar slides em PNG, ou quando citarem DeckCraft."
---

# DeckCraft

App open source da suíte ArtCraft ([storytold/deckcraft](https://github.com/storytold/deckcraft), Rust, Windows/macOS/Linux).
Função: apresentações (estilo Keynote/PowerPoint): slides, layouts, apresentação ao vivo.

Todo item de menu é um **comando** com id e parâmetros JSON. A UI, o CLI `deckcraft-cli`, o canal de controle JSON do app e o servidor MCP chamam os mesmos comandos. Então tudo que dá para clicar também dá para automatizar.

## 1. Localizar o executável
Windows (PowerShell):
```powershell
$h = if ($env:ARTCRAFT_HOME) { $env:ARTCRAFT_HOME } else { "$HOME\Apps\ArtCraft" }
$cli = Get-ChildItem -Recurse $h, "$env:LOCALAPPDATA\Programs", "$env:ProgramFiles" -Filter deckcraft-cli.exe -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
& $cli --version
```
macOS/Linux: `command -v deckcraft-cli`.
Se não achar, instale com a skill **artcraft** (`scripts/install.ps1 -Apps deckcraft`) ou pegue o zip portátil em https://github.com/storytold/deckcraft/releases/latest.

## 2. Como trabalhar
1. **Descubra antes de chutar.** Rode `deckcraft-cli --help` e liste os comandos (`commands`, ou `tools` no PdfCraft). Os ids mudam entre versões alpha, então confirme na versão instalada.
2. **Prefira o modo headless** (`run`/`render`/`convert`/`export`). É reproduzível e não depende de janela.
3. **Não sobrescreva o original sem pedir.** Salve ao lado do original ou numa pasta `_out`.
4. **Confira o resultado.** Renderize ou inspecione a saída e olhe o arquivo antes de dizer que terminou.
5. **Para o usuário ver ao vivo**, abra o app com `--control <porta>` e use o canal de controle ou o MCP em modo bridge (clique, screenshot).

## 3. Receitas (do README; confira os flags com --help)
```sh
deckcraft-cli commands format.
deckcraft-cli run --sample --cmd 'slide.new={"layout":"titleOnly","title":"Hello"}' --save hello.deckcraft
deckcraft-cli render --sample --all --scale 1 out/
```

## 4. MCP (para uso contínuo)
```sh
claude mcp add deckcraft -- <caminho>/deckcraft-cli mcp --automation-read-root DIR --automation-write-root DIR
```
Sempre que o CLI aceitar raízes de leitura/escrita, use-as para restringir o agente às pastas do projeto.

> Status: alpha ou em desenvolvimento. Se um comando falhar, anote a versão e o erro e use outro caminho (outro comando, ou a UI via canal de controle).