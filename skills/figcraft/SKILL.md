---
name: figcraft
description: "Opera o FigCraft, design de interface (estilo Figma): frames, auto layout, componentes, vector networks, protótipos; arquivos .figcraft, pelo CLI headless, por MCP ou abrindo o app. Use quando o pedido for desenhar telas de app/site, UI, wireframes, protótipos; exportar telas em PNG/SVG, ou quando citarem FigCraft."
---

# FigCraft

App open source da suíte ArtCraft ([storytold/figcraft](https://github.com/storytold/figcraft), Rust, Windows/macOS/Linux).
Função: design de interface (estilo Figma): frames, auto layout, componentes, vector networks, protótipos; arquivos .figcraft.

Todo item de menu é um **comando** com id e parâmetros JSON. A UI, o CLI `figcraft-cli`, o canal de controle JSON do app e o servidor MCP chamam os mesmos comandos. Então tudo que dá para clicar também dá para automatizar.

## 1. Localizar o executável
Windows (PowerShell):
```powershell
$h = if ($env:ARTCRAFT_HOME) { $env:ARTCRAFT_HOME } else { "$HOME\Apps\ArtCraft" }
$cli = Get-ChildItem -Recurse $h, "$env:LOCALAPPDATA\Programs", "$env:ProgramFiles" -Filter figcraft-cli.exe -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
& $cli --version
```
macOS/Linux: `command -v figcraft-cli`.
Se não achar, instale com a skill **artcraft** (`scripts/install.ps1 -Apps figcraft`) ou pegue o zip portátil em https://github.com/storytold/figcraft/releases/latest.

## 2. Como trabalhar
1. **Descubra antes de chutar.** Rode `figcraft-cli --help` e liste os comandos (`commands`, ou `tools` no PdfCraft). Os ids mudam entre versões alpha, então confirme na versão instalada.
2. **Prefira o modo headless** (`run`/`render`/`convert`/`export`). É reproduzível e não depende de janela.
3. **Não sobrescreva o original sem pedir.** Salve ao lado do original ou numa pasta `_out`.
4. **Confira o resultado.** Renderize ou inspecione a saída e olhe o arquivo antes de dizer que terminou.
5. **Para o usuário ver ao vivo**, abra o app com `--control <porta>` e use o canal de controle ou o MCP em modo bridge (clique, screenshot).

## 3. Receitas (do README; confira os flags com --help)
```sh
figcraft-cli render landing.figcraft -o landing.png --scale 2
figcraft-cli export landing.figcraft -o out/ --format svg
figcraft-cli run build-card.json --out card.figcraft     # script de comandos sem janela
figcraft-cli commands --filter autoLayout
```

## 4. MCP (para uso contínuo)
```sh
claude mcp add figcraft -- <caminho>/figcraft-cli mcp   (ou --attach 47800 com figcraft --control 47800)
```
Sempre que o CLI aceitar raízes de leitura/escrita, use-as para restringir o agente às pastas do projeto.

> Status: alpha ou em desenvolvimento. Se um comando falhar, anote a versão e o erro e use outro caminho (outro comando, ou a UI via canal de controle).