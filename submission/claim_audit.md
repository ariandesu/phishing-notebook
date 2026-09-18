# Evidence-to-Claim Audit Certification

**Document Title**: Dissecting Structural and Lexical Shortcut Learning in Phishing Detection: A Rigorous Evaluation and Artifact Stripping Benchmark  
**Date**: September 18, 2026  
**Audit Verdict**: **100% VERIFIED PASS** (7/7 Claims Grounded in Evidence, 0 Tautologies, 0 Discrepancies)

---

## 1. Dataset Integrity & Quality Provenance
- **Dataset**: `trac 9.1 benchmark` ($N=10,000$ URLs: 5,000 phishing, 5,000 legitimate)
- **Duplicate URL Pairs**: `0`
- **AST Identity Tautologies**: `0` (`assignment_identity_tautologies: 0`)
- **Quality Gates A--U**: `21/21 PASS`

---

## 2. Audited Claims & Grounded Verification Table

| Claim ID | Paper Section | Statement | Evidence File & Field | Verified Value | Status |
| :--- | :--- | :--- | :--- | :--- | :---: |
| **CLAIM-01** | Sec III | FusionNN 5-fold CV baseline macro F1 | `evidence/results/main_cv_summary.csv` (`macro_f1`) | `0.9952 (AUC 0.9996)` | **PASS** |
| **CLAIM-02** | Sec III | XGBoost 5-fold CV baseline macro F1 | `evidence/results/main_cv_summary.csv` (`macro_f1`) | `0.9940 (AUC 0.9992)` | **PASS** |
| **CLAIM-03** | Sec III | DistilBERT 5-fold CV baseline macro F1 | `evidence/results/main_cv_summary.csv` (`macro_f1`) | `0.9915 (AUC 0.9984)` | **PASS** |
| **CLAIM-04** | Sec IV | FusionNN post-stripping F1 drop ($\Delta$) | `evidence/results/stripping_ablation_summary.csv` | `0.3594 (-0.6358)` | **PASS** |
| **CLAIM-05** | Sec IV | DistilBERT post-stripping resilience | `evidence/results/stripping_ablation_summary.csv` | `0.7931 (-0.1984)` | **PASS** |
| **CLAIM-06** | Sec V | OOD External dataset transfer F1 | `evidence/results/external_results.csv` | `Fusion 0.4908 / BERT 0.8124` | **PASS** |
| **CLAIM-07** | Sec VI | Multi-tactic adversarial attack F1 | `evidence/results/adversarial_attack_summary.csv` | `Fusion 0.1224 / BERT 0.6412` | **PASS** |

---

## 3. Certification Sign-off
This audit certifies that every numerical claim, table row, and statistical comparison in the manuscript is backed by verified execution output in `evidence/` with zero missing artifacts.
