---
name: vectorcraft
description: "Opera o VectorCraft, ilustração vetorial (estilo Illustrator): pathfinder, blends, efeitos ao vivo, máscaras de recorte, artboards, pelo CLI headless, por MCP ou abrindo o app. Use quando o pedido for criar ou editar vetores, logos, pôsteres, ícones; exportar SVG/PNG/PDF a partir de vetor, ou quando citarem VectorCraft."
---

# VectorCraft

App open source da suíte ArtCraft ([storytold/vectorcraft](https://github.com/storytold/vectorcraft), Rust, Windows/macOS/Linux).
Função: ilustração vetorial (estilo Illustrator): pathfinder, blends, efeitos ao vivo, máscaras de recorte, artboards.

Todo item de menu é um **comando** com id e parâmetros JSON. A UI, o CLI `vectorcraft-cli`, o canal de controle JSON do app e o servidor MCP chamam os mesmos comandos. Então tudo que dá para clicar também dá para automatizar.

## 1. Localizar o executável
Windows (PowerShell):
```powershell
$h = if ($env:ARTCRAFT_HOME) { $env:ARTCRAFT_HOME } else { "$HOME\Apps\ArtCraft" }
$cli = Get-ChildItem -Recurse $h, "$env:LOCALAPPDATA\Programs", "$env:ProgramFiles" -Filter vectorcraft-cli.exe -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
& $cli --version
```
macOS/Linux: `command -v vectorcraft-cli`.
Se não achar, instale com a skill **artcraft** (`scripts/install.ps1 -Apps vectorcraft`) ou pegue o zip portátil em https://github.com/storytold/vectorcraft/releases/latest.

## 2. Como trabalhar
1. **Descubra antes de chutar.** Rode `vectorcraft-cli --help` e liste os comandos (`commands`, ou `tools` no PdfCraft). Os ids mudam entre versões alpha, então confirme na versão instalada.
2. **Prefira o modo headless** (`run`/`render`/`convert`/`export`). É reproduzível e não depende de janela.
3. **Não sobrescreva o original sem pedir.** Salve ao lado do original ou numa pasta `_out`.
4. **Confira o resultado.** Renderize ou inspecione a saída e olhe o arquivo antes de dizer que terminou.
5. **Para o usuário ver ao vivo**, abra o app com `--control <porta>` e use o canal de controle ou o MCP em modo bridge (clique, screenshot).

## 3. Receitas (do README; confira os flags com --help)
```sh
vectorcraft-cli commands                 # todos os comandos e parâmetros
vectorcraft-cli --help                   # subcomandos (run/render/export)
vectorcraft.exe arquivo.vectorcraft      # abrir no app
```

## 4. MCP (para uso contínuo)
```sh
claude mcp add vectorcraft -- <caminho>/vectorcraft-cli mcp --automation-read-root DIR --automation-write-root DIR
```
Sempre que o CLI aceitar raízes de leitura/escrita, use-as para restringir o agente às pastas do projeto.

> Status: alpha ou em desenvolvimento. Se um comando falhar, anote a versão e o erro e use outro caminho (outro comando, ou a UI via canal de controle).