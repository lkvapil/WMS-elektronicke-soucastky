# ══════════════════════════════════════════════════════════════════════════════
#  WMS Elektronické součástky – Makefile
# ══════════════════════════════════════════════════════════════════════════════
#  Použití:
#    make diagrams     – Generuje PNG obrázky ze všech PUML souborů
#    make pdf          – Kompiluje LaTeX dokumentaci do PDF
#    make all          – Diagramy + PDF
#    make clean        – Smaže vygenerované soubory
#    make help         – Zobrazí tuto nápovědu
# ══════════════════════════════════════════════════════════════════════════════

.PHONY: all diagrams pdf clean help

# ── Konfigurace ──────────────────────────────────────────────────────────────
PLANTUML    := plantuml
PUML_DIR    := diagrams
IMG_DIR     := docs/images
TEX_DIR     := docs
TEX_MAIN    := main
LATEXMK     := latexmk
LATEXMK_FLAGS := -pdf -biber -interaction=nonstopmode -cd

PUML_FILES  := $(wildcard $(PUML_DIR)/*.puml)
PNG_FILES   := $(patsubst $(PUML_DIR)/%.puml, $(IMG_DIR)/%.png, $(PUML_FILES))

# ── Výchozí cíl ───────────────────────────────────────────────────────────────
all: diagrams pdf

# ── Diagramy: PUML → PNG ─────────────────────────────────────────────────────
diagrams: $(PNG_FILES)

$(IMG_DIR)/%.png: $(PUML_DIR)/%.puml | $(IMG_DIR)
	@echo "  [PlantUML] Generuji $< → $@"
	$(PLANTUML) -tpng "$<" -o "$(abspath $(IMG_DIR))"

$(IMG_DIR):
	mkdir -p $(IMG_DIR)

# Alternativně: generovat vše najednou
diagrams-all: | $(IMG_DIR)
	$(PLANTUML) -tpng $(PUML_DIR)/*.puml -o "$(abspath $(IMG_DIR))"
	@echo "  ✓ Všechny diagramy vygenerovány do $(IMG_DIR)/"

# ── SVG verze diagramů ───────────────────────────────────────────────────────
diagrams-svg: | $(IMG_DIR)
	$(PLANTUML) -tsvg $(PUML_DIR)/*.puml -o "$(abspath $(IMG_DIR))"
	@echo "  ✓ SVG diagramy vygenerovány do $(IMG_DIR)/"

# ── LaTeX → PDF ───────────────────────────────────────────────────────────────
pdf: diagrams
	@echo "  [LaTeX] Kompiluji dokumentaci..."
	$(LATEXMK) $(LATEXMK_FLAGS) $(TEX_DIR)/$(TEX_MAIN).tex
	@echo "  ✓ PDF vygeneráno: $(TEX_DIR)/$(TEX_MAIN).pdf"

# Rychlá kompilace bez generování diagramů (diagramy musí existovat)
pdf-only:
	$(LATEXMK) $(LATEXMK_FLAGS) $(TEX_DIR)/$(TEX_MAIN).tex

# ── Úklid ─────────────────────────────────────────────────────────────────────
clean:
	@echo "  [clean] Odstraňuji vygenerované soubory..."
	$(LATEXMK) -C -cd $(TEX_DIR)/$(TEX_MAIN).tex
	rm -f $(TEX_DIR)/*.bbl $(TEX_DIR)/*.run.xml
	@echo "  ✓ Hotovo"

clean-all: clean
	@echo "  [clean-all] Odstraňuji i PNG diagramy..."
	rm -f $(IMG_DIR)/*.png $(IMG_DIR)/*.svg
	@echo "  ✓ Hotovo"

# ── Nápověda ─────────────────────────────────────────────────────────────────
help:
	@echo ""
	@echo "  WMS Elektronické součástky – dostupné příkazy:"
	@echo ""
	@echo "  make all          Diagramy + PDF dokumentace"
	@echo "  make diagrams     Pouze PNG diagramy (z .puml souborů)"
	@echo "  make diagrams-svg Pouze SVG diagramy"
	@echo "  make pdf          LaTeX → PDF (automaticky spustí diagrams)"
	@echo "  make pdf-only     PDF bez regenerace diagramů"
	@echo "  make clean        Smaže LaTeX pomocné soubory"
	@echo "  make clean-all    Smaže LaTeX soubory + vygenerované obrázky"
	@echo ""
	@echo "  Požadavky: plantuml, latexmk, biber, lualatex/pdflatex"
	@echo "  macOS:  brew install plantuml basictex"
	@echo "  Ubuntu: apt install plantuml texlive-full"
	@echo ""
