---
name: filmcraft
description: "Opera o FilmCraft, editor de vídeo não linear (estilo Premiere): timeline, cortes, Lumetri/grade, mixer de áudio, títulos, export, pelo CLI headless, por MCP ou abrindo o app. Use quando o pedido for montar, cortar, colorir, mixar ou exportar vídeo; edição de timeline; legendas, ou quando citarem FilmCraft."
---

# FilmCraft

App open source da suíte ArtCraft ([storytold/filmcraft](https://github.com/storytold/filmcraft), Rust, Windows/macOS/Linux).
Função: editor de vídeo não linear (estilo Premiere): timeline, cortes, Lumetri/grade, mixer de áudio, títulos, export.

Todo item de menu é um **comando** com id e parâmetros JSON. A UI, o CLI `filmcraft-cli`, o canal de controle JSON do app e o servidor MCP chamam os mesmos comandos. Então tudo que dá para clicar também dá para automatizar.

## 1. Localizar o executável
Windows (PowerShell):
```powershell
$h = if ($env:ARTCRAFT_HOME) { $env:ARTCRAFT_HOME } else { "$HOME\Apps\ArtCraft" }
$cli = Get-ChildItem -Recurse $h, "$env:LOCALAPPDATA\Programs", "$env:ProgramFiles" -Filter filmcraft-cli.exe -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
& $cli --version
```
macOS/Linux: `command -v filmcraft-cli`.
Se não achar, instale com a skill **artcraft** (`scripts/install.ps1 -Apps filmcraft`) ou pegue o zip portátil em https://github.com/storytold/filmcraft/releases/latest.

## 2. Como trabalhar
1. **Descubra antes de chutar.** Rode `filmcraft-cli --help` e liste os comandos (`commands`, ou `tools` no PdfCraft). Os ids mudam entre versões alpha, então confirme na versão instalada.
2. **Prefira o modo headless** (`run`/`render`/`convert`/`export`). É reproduzível e não depende de janela.
3. **Não sobrescreva o original sem pedir.** Salve ao lado do original ou numa pasta `_out`.
4. **Confira o resultado.** Renderize ou inspecione a saída e olhe o arquivo antes de dizer que terminou.
5. **Para o usuário ver ao vivo**, abra o app com `--control <porta>` e use o canal de controle ou o MCP em modo bridge (clique, screenshot).

## 3. Receitas (do README; confira os flags com --help)
```sh
filmcraft-cli commands                   # 650+ comandos (timeline.place, effects.setParam, ...)
filmcraft-cli --help
filmcraft.exe --control 7990             # app com canal de controle JSON (engine.execute, ui.screenshot)
```
Exemplo de chamada (canal de controle ou ferramenta MCP):
```json
{"method":"engine.execute","params":{"command":"effects.setParam","params":{"clip":87,"effect":"lumetri","param":"curve_luma","value":[[0,0],[0.25,0.21],[0.75,0.82],[1,1]]}}}
```

## 4. MCP (para uso contínuo)
```sh
claude mcp add filmcraft -- <caminho>/filmcraft-cli mcp
```
Sempre que o CLI aceitar raízes de leitura/escrita, use-as para restringir o agente às pastas do projeto.

> Status: alpha ou em desenvolvimento. Se um comando falhar, anote a versão e o erro e use outro caminho (outro comando, ou a UI via canal de controle).