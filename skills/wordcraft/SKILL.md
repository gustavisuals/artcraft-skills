---
name: wordcraft
description: "Opera o WordCraft, processador de texto (estilo Word): estilos, formatação, listas, macros, abre/salva DOCX, pelo CLI headless, por MCP ou abrindo o app. Use quando o pedido for escrever, formatar ou converter documentos de texto/DOCX localmente, ou quando citarem WordCraft."
---

# WordCraft

App open source da suíte ArtCraft ([storytold/wordcraft](https://github.com/storytold/wordcraft), Rust, Windows/macOS/Linux).
Função: processador de texto (estilo Word): estilos, formatação, listas, macros, abre/salva DOCX.

Todo item de menu é um **comando** com id e parâmetros JSON. A UI, o CLI `wordcraft-cli`, o canal de controle JSON do app e o servidor MCP chamam os mesmos comandos. Então tudo que dá para clicar também dá para automatizar.

## 1. Localizar o executável
Windows (PowerShell):
```powershell
$h = if ($env:ARTCRAFT_HOME) { $env:ARTCRAFT_HOME } else { "$HOME\Apps\ArtCraft" }
$cli = Get-ChildItem -Recurse $h, "$env:LOCALAPPDATA\Programs", "$env:ProgramFiles" -Filter wordcraft-cli.exe -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
& $cli --version
```
macOS/Linux: `command -v wordcraft-cli`.
Se não achar, instale com a skill **artcraft** (`scripts/install.ps1 -Apps wordcraft`) ou pegue o zip portátil em https://github.com/storytold/wordcraft/releases/latest.

## 2. Como trabalhar
1. **Descubra antes de chutar.** Rode `wordcraft-cli --help` e liste os comandos (`commands`, ou `tools` no PdfCraft). Os ids mudam entre versões alpha, então confirme na versão instalada.
2. **Prefira o modo headless** (`run`/`render`/`convert`/`export`). É reproduzível e não depende de janela.
3. **Não sobrescreva o original sem pedir.** Salve ao lado do original ou numa pasta `_out`.
4. **Confira o resultado.** Renderize ou inspecione a saída e olhe o arquivo antes de dizer que terminou.
5. **Para o usuário ver ao vivo**, abra o app com `--control <porta>` e use o canal de controle ou o MCP em modo bridge (clique, screenshot).

## 3. Receitas (do README; confira os flags com --help)
```sh
wordcraft-cli --help
wordcraft.exe --sample --control 7981
```
Ferramentas MCP: list_commands, execute, batch, type_text, select_text, inspect_document, render_page, save_document.

## 4. MCP (para uso contínuo)
```sh
claude mcp add wordcraft -- <caminho>/wordcraft-cli mcp --automation-read-root DIR --automation-write-root DIR
```
Sempre que o CLI aceitar raízes de leitura/escrita, use-as para restringir o agente às pastas do projeto.

> Status: alpha ou em desenvolvimento. Se um comando falhar, anote a versão e o erro e use outro caminho (outro comando, ou a UI via canal de controle).