---
name: soundcraft
description: "Opera o SoundCraft, DAW (estilo Pro Tools): multitrack, mixer, plugins CLAP/VST3, automação, MIDI, gravação, bounce, pelo CLI headless, por MCP ou abrindo o app. Use quando o pedido for mixar, editar áudio multitrack, aplicar EQ/efeitos, fazer bounce para WAV, trilha para vídeo/VJ, ou quando citarem SoundCraft."
---

# SoundCraft

App open source da suíte ArtCraft ([storytold/soundcraft](https://github.com/storytold/soundcraft), Rust, Windows/macOS/Linux).
Função: DAW (estilo Pro Tools): multitrack, mixer, plugins CLAP/VST3, automação, MIDI, gravação, bounce.

Todo item de menu é um **comando** com id e parâmetros JSON. A UI, o CLI `soundcraft-cli`, o canal de controle JSON do app e o servidor MCP chamam os mesmos comandos. Então tudo que dá para clicar também dá para automatizar.

## 1. Localizar o executável
Windows (PowerShell):
```powershell
$h = if ($env:ARTCRAFT_HOME) { $env:ARTCRAFT_HOME } else { "$HOME\Apps\ArtCraft" }
$cli = Get-ChildItem -Recurse $h, "$env:LOCALAPPDATA\Programs", "$env:ProgramFiles" -Filter soundcraft-cli.exe -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
& $cli --version
```
macOS/Linux: `command -v soundcraft-cli`.
Se não achar, instale com a skill **artcraft** (`scripts/install.ps1 -Apps soundcraft`) ou pegue o zip portátil em https://github.com/storytold/soundcraft/releases/latest.

## 2. Como trabalhar
1. **Descubra antes de chutar.** Rode `soundcraft-cli --help` e liste os comandos (`commands`, ou `tools` no PdfCraft). Os ids mudam entre versões alpha, então confirme na versão instalada.
2. **Prefira o modo headless** (`run`/`render`/`convert`/`export`). É reproduzível e não depende de janela.
3. **Não sobrescreva o original sem pedir.** Salve ao lado do original ou numa pasta `_out`.
4. **Confira o resultado.** Renderize ou inspecione a saída e olhe o arquivo antes de dizer que terminou.
5. **Para o usuário ver ao vivo**, abra o app com `--control <porta>` e use o canal de controle ou o MCP em modo bridge (clique, screenshot).

## 3. Receitas (do README; confira os flags com --help)
```sh
soundcraft-cli run --demo --cmd 'mix.volume={"track":"Kick","db":-6}' \
  --cmd 'mix.insert={"track":"Bass","plugin":"eq_7band"}' --bounce mix.wav
soundcraft-cli commands --json
soundcraft.exe --demo --control 7801
soundcraft-cli app --port 7801 ui.screenshot '{"path":"shot.png"}'
```

## 4. MCP (para uso contínuo)
```sh
claude mcp add soundcraft -- <caminho>/soundcraft-cli mcp --automation-read-root DIR --automation-write-root DIR
```
Sempre que o CLI aceitar raízes de leitura/escrita, use-as para restringir o agente às pastas do projeto.

> Status: alpha ou em desenvolvimento. Se um comando falhar, anote a versão e o erro e use outro caminho (outro comando, ou a UI via canal de controle).