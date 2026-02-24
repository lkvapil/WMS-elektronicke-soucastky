# WMS – Elektronické součástky

> **Warehouse Management System** pro evidenci a správu skladu elektronických součástek.

---

## 📋 Obsah repozitáře

```
WMS-elektronicke-soucastky/
├── docs/                        # LaTeX dokumentace
│   ├── main.tex                 # Hlavní dokument
│   ├── literatura.bib           # Bibliografie (Biber)
│   ├── chapters/
│   │   ├── uvod.tex             # Kap. 1 – Úvod a motivace
│   │   ├── pozadavky.tex        # Kap. 2 – Analýza požadavků (FR + NFR)
│   │   ├── architektura.tex     # Kap. 3 – Architektura systému
│   │   ├── datovy_model.tex     # Kap. 4 – Datový model a DB schéma
│   │   ├── popis_procesu.tex    # Kap. 5 – Popis klíčových procesů
│   │   └── zaver.tex            # Kap. 6 – Závěr a roadmap
│   └── images/                  # Vygenerované PNG diagramy (gitignore)
│
├── diagrams/                    # PlantUML zdrojové soubory
│   ├── 01_use_case.puml         # Use Case diagram
│   ├── 02_class_diagram.puml    # Třídní diagram
│   ├── 03_er_diagram.puml       # ER diagram (Entity-Relationship)
│   ├── 04_sequence_prijem.puml  # Sekvenční diagram – Příjem
│   ├── 05_sequence_vydej.puml   # Sekvenční diagram – Výdej
│   ├── 06_activity_inventura.puml # Diagram aktivit – Inventura
│   ├── 07_component_diagram.puml  # Komponentový diagram
│   └── 08_deployment_diagram.puml # Deployment diagram (Docker)
│
├── Makefile                     # Automatizace build procesu
└── README.md                    # Tento soubor
```

---

## 🚀 Rychlý start

### Požadavky

| Nástroj | Verze | Instalace (macOS) |
|---------|-------|-------------------|
| PlantUML | ≥ 1.2024 | `brew install plantuml` |
| latexmk | ≥ 4.75 | `brew install basictex` + `tlmgr install latexmk` |
| Biber | ≥ 2.18 | `tlmgr install biber` |

### Generování diagramů

```bash
# Všechny diagramy najednou (PNG)
make diagrams

# Nebo ručně přes plantuml
plantuml -tpng diagrams/*.puml -o docs/images/
```

### Kompilace PDF dokumentace

```bash
# Diagramy + PDF
make all

# Pouze PDF (pokud jsou diagramy již vygenerovány)
make pdf-only
```

### Výsledný soubor

Po úspěšném buildu naleznete dokumentaci v:
```
docs/main.pdf
```

---

## 📊 Přehled PlantUML diagramů

| # | Soubor | Typ | Popis |
|---|--------|-----|-------|
| 1 | `01_use_case.puml` | Use Case | Aktéři a případy užití systému |
| 2 | `02_class_diagram.puml` | Class | Třídy, atributy, metody a vztahy |
| 3 | `03_er_diagram.puml` | ER | Databázové entity a kardinalita |
| 4 | `04_sequence_prijem.puml` | Sequence | Tok příjmu součástek na sklad |
| 5 | `05_sequence_vydej.puml` | Sequence | Tok výdeje součástek na projekt |
| 6 | `06_activity_inventura.puml` | Activity | Průběh inventurního cyklu |
| 7 | `07_component_diagram.puml` | Component | Softwarové komponenty a vazby |
| 8 | `08_deployment_diagram.puml` | Deployment | Nasazení pomocí Docker Compose |

---

## 🏗️ Technologický stack

| Vrstva | Technologie |
|--------|-------------|
| Frontend | React 18 + TypeScript + Vite |
| Backend | Python 3.11 + FastAPI + SQLAlchemy |
| Databáze | PostgreSQL 15 |
| Cache / Queue | Redis 7 + Celery |
| Object Storage | MinIO (S3-compatible) |
| Kontejnerizace | Docker + Docker Compose |
| Dokumentace | LaTeX + PlantUML |

---

## 📦 Hlavní funkce systému

- **Evidence součástek** – katalog s parametry (hodnota, pouzdro, výrobce, datasheet)
- **Správa skladu** – hierarchická skladová místa (sekce → regál → přihrádka)
- **Příjem a výdej** – pohyby zásob s vazbou na objednávky a projekty
- **Inventura** – řízený cyklus fyzického sčítání s korekcemi
- **Objednávky** – správa dodavatelů a nákupních objednávek
- **Reporty** – stav skladu, pohyby, ocenění, součástky pod limitem
- **Upozornění** – automatické notifikace při podkročení minimálního stavu
- **Audit log** – sledovatelnost všech změn v systému

---

## 🔧 Konfigurace prostředí

Zkopírujte `.env.example` → `.env` a nastavte:

```env
DATABASE_URL=postgresql://wms:password@localhost:5432/wms_db
REDIS_URL=redis://localhost:6379/0
SECRET_KEY=your-super-secret-jwt-key
MINIO_ROOT_USER=minioadmin
MINIO_ROOT_PASSWORD=minioadmin
SMTP_HOST=localhost
SMTP_PORT=587
```

---

## 📄 Licence

Projektová dokumentace pro vzdělávací účely. © 2026 Lukáš Kvapil
