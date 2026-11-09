---
name: effectcraft
description: "Opera o EffectCraft, motion graphics e VFX (estilo After Effects): composições, keyframes, expressões JS (wiggle, loopOut), texto, render, export Lottie, pelo CLI headless, por MCP ou abrindo o app. Use quando o pedido for animar, criar motion graphics, keyframes, render de composição para MP4, exportar Lottie, ou quando citarem EffectCraft."
---

# EffectCraft

App open source da suíte ArtCraft ([storytold/effectcraft](https://github.com/storytold/effectcraft), Rust, Windows/macOS/Linux).
Função: motion graphics e VFX (estilo After Effects): composições, keyframes, expressões JS (wiggle, loopOut), texto, render, export Lottie.

Todo item de menu é um **comando** com id e parâmetros JSON. A UI, o CLI `effectcraft-cli`, o canal de controle JSON do app e o servidor MCP chamam os mesmos comandos. Então tudo que dá para clicar também dá para automatizar.

## 1. Localizar o executável
Windows (PowerShell):
```powershell
$h = if ($env:ARTCRAFT_HOME) { $env:ARTCRAFT_HOME } else { "$HOME\Apps\ArtCraft" }
$cli = Get-ChildItem -Recurse $h, "$env:LOCALAPPDATA\Programs", "$env:ProgramFiles" -Filter effectcraft-cli.exe -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
& $cli --version
```
macOS/Linux: `command -v effectcraft-cli`.
Se não achar, instale com a skill **artcraft** (`scripts/install.ps1 -Apps effectcraft`) ou pegue o zip portátil em https://github.com/storytold/effectcraft/releases/latest.

## 2. Como trabalhar
1. **Descubra antes de chutar.** Rode `effectcraft-cli --help` e liste os comandos (`commands`, ou `tools` no PdfCraft). Os ids mudam entre versões alpha, então confirme na versão instalada.
2. **Prefira o modo headless** (`run`/`render`/`convert`/`export`). É reproduzível e não depende de janela.
3. **Não sobrescreva o original sem pedir.** Salve ao lado do original ou numa pasta `_out`.
4. **Confira o resultado.** Renderize ou inspecione a saída e olhe o arquivo antes de dizer que terminou.
5. **Para o usuário ver ao vivo**, abra o app com `--control <porta>` e use o canal de controle ou o MCP em modo bridge (clique, screenshot).

## 3. Receitas (do README; confira os flags com --help)
```sh
effectcraft-cli set Main '#1' transform/position '[100,360]' --time 0 main.ecproj --save
effectcraft-cli render --comp Main --out main.mp4
effectcraft-cli exec file.exportLottie '{"comp":"Main","path":"main.json"}' main.ecproj
effectcraft.exe --control 9877          # app + canal de controle (comandos só-UI exigem isso)
```

## 4. MCP (para uso contínuo)
```sh
claude mcp add effectcraft -- <caminho>/effectcraft-cli mcp   (ou --bridge 9877 para o app aberto)
```
Sempre que o CLI aceitar raízes de leitura/escrita, use-as para restringir o agente às pastas do projeto.

> Status: alpha ou em desenvolvimento. Se um comando falhar, anote a versão e o erro e use outro caminho (outro comando, ou a UI via canal de controle).