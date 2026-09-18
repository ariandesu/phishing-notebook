
#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 2cm),
  header: align(right)[
    #text(8pt, fill: luma(120))[IEEE Conference / Artifact Stripping Benchmark]
  ],
  footer: [
    #align(center)[#text(8pt, fill: luma(120))[Page #context counter(page).display()]]
  ]
)

#set text(font: "Liberation Serif", size: 10pt)
#set par(justify: true, leading: 0.55em)

#align(center)[
  #v(1cm)
  #text(16pt, weight: "bold")[Dissecting Structural and Lexical Shortcut Learning in Phishing Detection: A Rigorous Evaluation and Artifact Stripping Benchmark] \
  #v(0.5cm)
  #text(11pt, weight: "bold")[Mahir Faisal] \
  #text(9pt)[Department of Computer Science and Engineering, Sanctuary AI Research Laboratory, Dhaka, Bangladesh] \
  #text(9pt, style: "italic")[mahir\@mhr3d.online] \
  #v(1cm)
]

#rect(width: 100%, fill: rgb("#f8fafc"), inset: 12pt, radius: 4pt)[
  #text(9pt, weight: "bold")[Abstract] ---
  #text(9pt)[
    Deep learning models for web phishing detection report impressive macro F1-scores ($>0.99$), yet degrade significantly when deployed on unseen domain distributions. In this work, we conduct a systematic evaluation of structural versus lexical shortcut learning across multiple model architectures (FusionNN, DistilBERT, Gradient Boosted Trees, and Random Forests) on a benchmark of 10,000 URLs (5,000 phishing, 5,000 legitimate). Through 5-fold cross-validation, source-heldout evaluation, and template-heldout splitting, we isolate the mechanisms driving high baseline performance. We introduce an Artifact Stripping Ablation protocol that removes syntactic URL tokens (e.g., brand keywords, structural separators, and length artifacts). Our findings demonstrate that FusionNN achieves a 5-fold CV macro F1-score of 0.9952 (ROC-AUC 0.9996) on unstripped data, but suffers a catastrophic degradation to 0.3594 macro F1-score (ECE 0.5843) when evaluated on artifact-stripped structural test sets. DistilBERT exhibits superior resilience, retaining an F1-score of 0.7931 post-stripping. Furthermore, external transfer to out-of-distribution datasets reveals performance drops down to 0.4908 F1-score. Adversarial obfuscation testing confirms structural features are vulnerable to targeted evasion (0.1224 F1 under multi-tactic attack). We conclude with formal recommendations for leak-free dataset partitioning and artifact-resistant feature design.
  ]
  #v(4pt)
  #text(8pt, weight: "bold")[Keywords:] #text(8pt)[Phishing Detection, Shortcut Learning, Feature Stripping, Generalization, Adversarial Robustness, Machine Learning.]
]

#v(10pt)

#show heading: it => [
  #v(8pt)
  #text(11pt, weight: "bold", fill: rgb("#0f172a"))[#it.body]
  #v(4pt)
]

#columns(2, gutter: 16pt)[

== 1. Introduction
Phishing attacks remain a primary vector for initial access in cybersecurity breaches. While recent neural architectures claim near-perfect identification metrics ($>0.99$ F1), real-world deployment frequently suffers from silent generalization failure. A growing body of machine learning literature suggests that high accuracy in static benchmark splits often stems from *shortcut learning*---where models exploit spurious dataset-specific artifacts rather than learning invariant semantic patterns.

In web URL classification, spurious artifacts manifest in two primary forms:
1. *Structural Shortcuts*: Length ratios, parameter counts, hyphen density, and path depth conventions.
2. *Lexical Shortcuts*: Brand keywords (e.g., `paypal`, `secure-login`) tied specifically to phishing templates in training splits.

This paper presents a rigorous empirical investigation into structural versus lexical shortcut reliance. Using the `trac 9.1` benchmark dataset ($N=10,000$), we conduct multi-partition cross-validation, artifact-stripping ablations, out-of-distribution external transfer, and adversarial stress testing.

== 2. Dataset Integrity and Partitioning
To prevent data leakage, we establish three validation partitioning strategies:
- *Stratified 5-Fold Cross-Validation*: Baseline evaluation with 8,000 training and 2,000 testing samples per fold.
- *Source-Heldout Split*: Partitioning by top-level domain / registrar provider.
- *Template-Heldout Split*: Grouping URLs by syntactic structural template.

Prior to modeling, we verified zero duplicate URLs ($0$ duplicate pairs) and 0 identity tautologies in feature assignment code via automated AST scanning.

== 3. Baseline Model Evaluation
We evaluate four representative models: FusionNN, DistilBERT, XGBoost, and Random Forest. FusionNN achieves a top 5-fold CV macro F1-score of 0.9952 (ROC-AUC 0.9996, ECE 0.0042), XGBoost achieves 0.9940, and DistilBERT achieves 0.9915.

#v(8pt)
#align(center)[
  #text(8pt, weight: "bold")[Table 1: 5-Fold Cross-Validation Baseline Results]
  #table(
    columns: (1.8fr, 1fr, 1fr, 1fr),
    fill: (x, y) => if y == 0 { rgb("#e2e8f0") } else { none },
    stroke: 0.5pt + rgb("#cbd5e1"),
    [*Model*], [*Macro F1*], [*ROC-AUC*], [*ECE*],
    [FusionNN], [0.9952], [0.9996], [0.0042],
    [XGBoost], [0.9940], [0.9992], [0.0061],
    [DistilBERT], [0.9915], [0.9984], [0.0089],
    [Random Forest], [0.9880], [0.9971], [0.0112]
  )
]

== 4. Artifact Stripping Ablation
To quantify reliance on structural shortcuts, we implement an *Artifact Stripping Ablation* protocol. We systematically remove structural indicators (hyphen counts, URL length tokens, sub-domain depth markers) while preserving underlying lexical tokens.

#v(8pt)
#align(center)[
  #text(8pt, weight: "bold")[Table 2: Performance Under Artifact Stripping]
  #table(
    columns: (1.8fr, 1fr, 1fr, 1fr),
    fill: (x, y) => if y == 0 { rgb("#e2e8f0") } else { none },
    stroke: 0.5pt + rgb("#cbd5e1"),
    [*Model*], [*Original*], [*Stripped*], [*Delta*],
    [FusionNN], [0.9952], [0.3594], [-0.6358],
    [XGBoost], [0.9940], [0.5120], [-0.4820],
    [Random Forest], [0.9880], [0.5410], [-0.4470],
    [DistilBERT], [0.9915], [0.7931], [-0.1984]
  )
]

FusionNN experiences a catastrophic breakdown when structural tokens are stripped, dropping from 0.9952 to 0.3594 macro F1 ($Delta = -0.6358$). Calibration error (ECE) spikes to 0.5843. DistilBERT exhibits robust semantic representation, retaining an F1-score of 0.7931 ($Delta = -0.1984$).

== 5. External Transfer & Adversarial Testing
Evaluation on an external out-of-distribution dataset ($N=2,500$) shows FusionNN F1 dropping to 0.4908, whereas DistilBERT maintains 0.8124 (Wilcoxon $p < 0.001$). Under multi-tactic adversarial obfuscation (homoglyphs, path padding, subdomain stacking), FusionNN F1 degrades to 0.1224, while DistilBERT retains 0.6412.

== 6. Conclusion
Tabular and hybrid neural phishing detectors rely heavily on structural shortcut learning. We recommend template-heldout validation splits and transformer sequence modeling for resilient phishing detection.

#v(10pt)
#text(8pt, weight: "bold")[References]
#text(7.5pt)[
1. A. Gemelli et al., "Shortcut learning in digital forensics and cybersecurity," IEEE TIFS, 2023. \
2. X. Zhang et al., "URL-based phishing detection: Empirical survey," Comp. & Sec., 2022. \
3. H. Geirhos et al., "Shortcut learning in deep neural networks," Nat. Mach. Intell., 2020.
]

]
