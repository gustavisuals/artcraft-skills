---
name: artcraft
description: "Instala, atualiza e escolhe o app certo da suíte ArtCraft (PhotoCraft, VectorCraft, FilmCraft, EffectCraft, LightCraft, PdfCraft, DesignCraft, FigCraft, TextureCraft, MaterialCraft, WordCraft, SoundCraft, DeckCraft, CADCraft, GridCraft, Craft Anything). Use quando pedirem para instalar ou atualizar a ArtCraft, perguntarem qual app usar para uma tarefa criativa, ou quando um app da suíte não for encontrado."
---

# ArtCraft: suíte e instalador

Os 16 apps são open source, em Rust, da [ArtCraft](https://getartcraft.com/apps) (org `storytold` no GitHub). Cada um tem a sua própria skill neste pacote, com o mesmo nome do app.

## Instalar / atualizar (Windows)
```powershell
# todos os apps + launcher, em $env:ARTCRAFT_HOME ou ~/Apps/ArtCraft
powershell -ExecutionPolicy Bypass -File <esta-skill>/scripts/install.ps1
# só alguns
powershell -ExecutionPolicy Bypass -File <esta-skill>/scripts/install.ps1 -Apps photocraft,effectcraft
```
O script usa os zips portáteis (não precisa de admin) e confere cada um contra o `SHA256SUMS.txt` do release. Também pula os apps que já estão na versão mais recente. Outra opção é o **ArtCraft Launcher** (`craft-launcher`), que instala e atualiza tudo pela interface.

## Qual app usar
| Tarefa | Skill |
|---|---|
| Foto/imagem raster, PSD, lote de imagens | `photocraft` |
| Revelar RAW, curadoria de ensaio, contact sheet | `lightcraft` |
| Vetor, logo, pôster, SVG | `vectorcraft` |
| UI, telas de app/site, protótipo | `figcraft` |
| Diagramação, revista, flyer, catálogo | `designcraft` |
| Edição de vídeo, timeline, cor | `filmcraft` |
| Motion graphics, keyframes, Lottie | `effectcraft` |
| Áudio multitrack, mix, bounce | `soundcraft` |
| Textura em modelo 3D (GLB), bake PBR | `texturecraft` |
| Material procedural por nós, .sbs | `materialcraft` |
| PDF: juntar, dividir, comentar, texto | `pdfcraft` |
| Documento de texto, DOCX | `wordcraft` |
| Planilha, fórmulas, XLSX | `gridcraft` |
| Slides, apresentação | `deckcraft` |
| CAD 2D, DWG/DXF, planta, layout de palco | `cadcraft` |
| Entender e recriar um site ou app | `craft-anything` |

Fluxos que combinam apps (ex.: frames do `figcraft` → animação no `effectcraft` → trilha no `soundcraft` → montagem no `filmcraft`) trocam arquivos comuns: PNG, SVG, WAV, MP4, Lottie.
