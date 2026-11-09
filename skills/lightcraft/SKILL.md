---
name: lightcraft
description: "Opera o LightCraft, biblioteca de fotos e revelador RAW (estilo Lightroom): culling, revelação, máscaras (SAM 3), presets, contact sheet, impressão, pelo CLI headless, por MCP ou abrindo o app. Use quando o pedido for revelar RAW/DNG, tratar fotos em lote, curadoria de ensaio, máscaras de céu/objeto, folha de contato em PDF, ou quando citarem LightCraft."
---

# LightCraft

App open source da suíte ArtCraft ([storytold/lightcraft](https://github.com/storytold/lightcraft), Rust, Windows/macOS/Linux).
Função: biblioteca de fotos e revelador RAW (estilo Lightroom): culling, revelação, máscaras (SAM 3), presets, contact sheet, impressão.

Todo item de menu é um **comando** com id e parâmetros JSON. A UI, o CLI `lightcraft-cli`, o canal de controle JSON do app e o servidor MCP chamam os mesmos comandos. Então tudo que dá para clicar também dá para automatizar.

## 1. Localizar o executável
Windows (PowerShell):
```powershell
$h = if ($env:ARTCRAFT_HOME) { $env:ARTCRAFT_HOME } else { "$HOME\Apps\ArtCraft" }
$cli = Get-ChildItem -Recurse $h, "$env:LOCALAPPDATA\Programs", "$env:ProgramFiles" -Filter lightcraft-cli.exe -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
& $cli --version
```
macOS/Linux: `command -v lightcraft-cli`.
Se não achar, instale com a skill **artcraft** (`scripts/install.ps1 -Apps lightcraft`) ou pegue o zip portátil em https://github.com/storytold/lightcraft/releases/latest.

## 2. Como trabalhar
1. **Descubra antes de chutar.** Rode `lightcraft-cli --help` e liste os comandos (`commands`, ou `tools` no PdfCraft). Os ids mudam entre versões alpha, então confirme na versão instalada.
2. **Prefira o modo headless** (`run`/`render`/`convert`/`export`). É reproduzível e não depende de janela.
3. **Não sobrescreva o original sem pedir.** Salve ao lado do original ou numa pasta `_out`.
4. **Confira o resultado.** Renderize ou inspecione a saída e olhe o arquivo antes de dizer que terminou.
5. **Para o usuário ver ao vivo**, abra o app com `--control <porta>` e use o canal de controle ou o MCP em modo bridge (clique, screenshot).

## 3. Receitas (do README; confira os flags com --help)
```sh
lightcraft-cli render in.dng -o out.jpg --set light.exposure=0.7
lightcraft-cli run --import in.dng develop.set control=light.exposure value=0.7 app.export path=out.jpg longEdge=2048
lightcraft-cli run --import PASTA library.selectAll export.contactSheet path=Contact.pdf paper=a4 columns=3 rows=4 captions=true
lightcraft.exe --control 7980 PASTA      # app com canal de controle
```

## 4. MCP (para uso contínuo)
```sh
claude mcp add lightcraft -- <caminho>/lightcraft-cli mcp PASTA_DE_FOTOS
```
Sempre que o CLI aceitar raízes de leitura/escrita, use-as para restringir o agente às pastas do projeto.

> Status: alpha ou em desenvolvimento. Se um comando falhar, anote a versão e o erro e use outro caminho (outro comando, ou a UI via canal de controle).