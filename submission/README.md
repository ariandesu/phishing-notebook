# IEEE Submission Package & Artifact Reproduction

This directory contains the manuscript, publication figures, and evidence audit for:

> **Dissecting Structural and Lexical Shortcut Learning in Phishing Detection: A Rigorous Evaluation and Artifact Stripping Benchmark**  
> *Mahir Faisal (Sanctuary AI Research Laboratory)*

## Directory Structure
```
submission/
├── IEEE_Paper.pdf        # Compiled two-column IEEE paper PDF
├── manuscript.tex        # Complete IEEE LaTeX source
├── manuscript.typ        # Typst source file
├── figures/              # High-resolution publication figures (Fig 1–5)
│   ├── fig1_artifact_inventory.png
│   ├── fig2_cv_f1.png
│   ├── fig3_confusion_matrix.png
│   ├── fig4_adversarial.png
│   └── fig5_calibration.png
├── claim_audit.json      # Machine-readable evidence-to-claim mapping
├── claim_audit.md        # Human-readable evidence verification audit
└── README.md             # Package documentation
```

## Reproduction & Verification
All underlying execution data, model weights, and quality gate scans reside in `evidence/`.
- Cross-validation results: `evidence/results/main_cv_summary.csv`
- Artifact stripping metrics: `evidence/results/stripping_ablation_summary.csv`
- External transfer metrics: `evidence/results/external_results.csv`
- Quality Gate status: `evidence/audit/gate_summary.json` (21/21 PASS, 0 tautologies)
