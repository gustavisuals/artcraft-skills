---
name: texturecraft
description: "Opera o TextureCraft, pintura de textura 3D (estilo Substance Painter): pintar em malha GLB, bake na GPU, render path-traced, exportar mapas PBR, pelo CLI headless, por MCP ou abrindo o app. Use quando o pedido for texturizar modelo 3D, pintar materiais em GLB, fazer bake, exportar texturas PBR, ou quando citarem TextureCraft."
---

# TextureCraft

App open source da suíte ArtCraft ([storytold/texturecraft](https://github.com/storytold/texturecraft), Rust, Windows/macOS/Linux).
Função: pintura de textura 3D (estilo Substance Painter): pintar em malha GLB, bake na GPU, render path-traced, exportar mapas PBR.

Todo item de menu é um **comando** com id e parâmetros JSON. A UI, o CLI `texturecraft-cli`, o canal de controle JSON do app e o servidor MCP chamam os mesmos comandos. Então tudo que dá para clicar também dá para automatizar.

## 1. Localizar o executável
Windows (PowerShell):
```powershell
$h = if ($env:ARTCRAFT_HOME) { $env:ARTCRAFT_HOME } else { "$HOME\Apps\ArtCraft" }
$cli = Get-ChildItem -Recurse $h, "$env:LOCALAPPDATA\Programs", "$env:ProgramFiles" -Filter texturecraft-cli.exe -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
& $cli --version
```
macOS/Linux: `command -v texturecraft-cli`.
Se não achar, instale com a skill **artcraft** (`scripts/install.ps1 -Apps texturecraft`) ou pegue o zip portátil em https://github.com/storytold/texturecraft/releases/latest.

## 2. Como trabalhar
1. **Descubra antes de chutar.** Rode `texturecraft-cli --help` e liste os comandos (`commands`, ou `tools` no PdfCraft). Os ids mudam entre versões alpha, então confirme na versão instalada.
2. **Prefira o modo headless** (`run`/`render`/`convert`/`export`). É reproduzível e não depende de janela.
3. **Não sobrescreva o original sem pedir.** Salve ao lado do original ou numa pasta `_out`.
4. **Confira o resultado.** Renderize ou inspecione a saída e olhe o arquivo antes de dizer que terminou.
5. **Para o usuário ver ao vivo**, abra o app com `--control <porta>` e use o canal de controle ou o MCP em modo bridge (clique, screenshot).

## 3. Receitas (do README; confira os flags com --help)
```sh
texturecraft.exe model.glb               # novo projeto a partir de uma malha
texturecraft-cli --help
texturecraft-cli render ...              # render path-traced na GPU
```

## 4. MCP (para uso contínuo)
```sh
claude mcp add texturecraft -- <caminho>/texturecraft-cli mcp --read-root DIR --write-root DIR   (ou --bridge 7878)
```
Sempre que o CLI aceitar raízes de leitura/escrita, use-as para restringir o agente às pastas do projeto.

> Status: alpha ou em desenvolvimento. Se um comando falhar, anote a versão e o erro e use outro caminho (outro comando, ou a UI via canal de controle).