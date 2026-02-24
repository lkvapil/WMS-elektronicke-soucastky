# .latexmkrc – konfigurace pro latexmk + LaTeX Workshop
# Hlavní soubor: main.tex (v adresáři docs/)

# Použij pdflatex
$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';

# Použij biber místo BibTeX
$bibtex_use = 2;
$biber = 'biber %O %S';

# Výstupní adresář (vedlejší soubory)
$out_dir = '.';

# Opakování dokud se dokument ustálí
$max_repeat = 5;
