# artcraft-skills

Skills de agente para operar a suíte open source [ArtCraft](https://getartcraft.com/apps) (16 apps criativos em Rust) pelo CLI headless, por MCP ou abrindo o app. Funcionam no Claude Code, Codex, Cursor e nos outros agentes suportados pelo [skills CLI](https://github.com/vercel-labs/skills).

```bash
npx skills add gustavisuals/artcraft-skills -g
```

Ou só algumas:

```bash
npx skills add gustavisuals/artcraft-skills --skill photocraft --skill effectcraft -g
```

## Skills

- **artcraft**: instala e atualiza a suíte (`scripts/install.ps1`) e indica qual app usar para cada tarefa.
- **photocraft**, **lightcraft**, **vectorcraft**, **figcraft**, **designcraft**: imagem, foto/RAW, vetor, UI e diagramação.
- **filmcraft**, **effectcraft**, **soundcraft**: vídeo, motion graphics e áudio.
- **texturecraft**, **materialcraft**: texturas e materiais 3D.
- **pdfcraft**, **wordcraft**, **gridcraft**, **deckcraft**, **cadcraft**: PDF, texto, planilha, slides e CAD.
- **craft-anything**: explorar e recriar software.

Cada skill localiza o executável sozinha (`$ARTCRAFT_HOME`, `~/Apps/ArtCraft`, Program Files). Antes de usar, lista os comandos da versão instalada, prefere o modo headless e confere a saída.

Os apps ArtCraft são alpha e mudam rápido. As receitas vêm dos READMEs oficiais; abra uma issue se algum comando mudou.

Feito por [GUSTɅVISUALS](https://github.com/gustavisuals) · Brotherhood Studios. Não é afiliado à ArtCraft. Licença MIT.
