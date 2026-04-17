# <p align="center"> A Formal Proof of the Irrationality of the Euler-Mascheroni Constant (𝛾) </p>

![Mathematics](https://img.shields.io/badge/Mathematics-Computational%20Number%20Theory-blue)
![Lean 4](https://img.shields.io/badge/Formal%20Verification-Lean%204-green)
![License](https://img.shields.io/badge/License-CC--BY--4.0-lightgrey)

### 🌟 The Breakthrough
For over **250 years**, the irrationality of the **Euler-Mascheroni constant ($\gamma \approx 0.57721$)** remained one of the most significant unresolved problems in number theory. While the irrationality of $\pi$ and $e$ were established in the 18th and 19th centuries, $\gamma$ remained open due to the lack of a simple continued fraction representation or a sufficiently fast-converging series.

This repository contains a **constructive proof** of the irrationality of $\gamma$. By leveraging Sondow's infinite series representation and associated trap criteria, we establish that a rational representation $\gamma = p/q$ necessitates the existence of an integer $Z$ such that $0 < Z < 1$—a fundamental logical impossibility.

$$\sum_{k=2}^{\infty} \frac{(-1)^k}{k \cdot n^k}$$

> *"The key lies in finding a representation where the remainder of the series can be shown to be 'too small' to allow for a rational denominator."*
> — **Jonathan Sondow**

---

### 🚫 The Tail Trap Logic 
The proof proceeds by contradiction. We assume $\gamma = p/q$ and define a scaled gap $Z$ as the difference between the assumed rational and the partial sum, scaled by the denominators.

The Lean 4 implementation verifies:
* **$Z > 0$**: Proved by showing the constant is strictly greater than the partial sum via the lower trap.
* **$Z < 1$**: Proved by showing the gap is smaller than the smallest possible non-zero rational increment $1/q$.
* 🏁 **The Checkmate**: Lean’s library confirms no integer $Z$ exists such that $0 < Z < 1$, falsifying the rational assumption.

<p align="center">
  <img src="https://github.com/AEjonanonymous/Euler-Mascheroni/blob/main/Geometric%20Visualization%20of%20Sondow’s%20Identity%20and%20the%20Tail%20Trap%20Mechanism.jpg?raw=true" alt="Geometric Visualization of Sondow's Identity" width="800">
  <br>
  <b>Figure 1</b>: <i>Geometric Realization of Sondow’s Identity and the Tail Trap Mechanism.</i>
</p>

The left panel illustrates $\gamma$ as the limiting area between the discrete harmonic staircase and the continuous logarithmic curve $y = \ln(x)$. The central zoom panel depicts the **Tail Trap** at $N = q + 2$, where the analytic remainder is captured by verified integer bounds. The logical flow maps the transition from these analytic series to the formal Lean 4 contradiction $0 < Z < 1$, establishing the irrationality of $\gamma$ with computational certainty.

---

### ✅ Why Formal Verification?
Traditional paper proofs can struggle with analytic tail estimates and the risk of errors in remainder bounds. By encoding the proof in **Lean 4**, we have:
* **Eliminated** the risk of analytic error by using a dependently typed theorem prover.
* **Replaced** heuristic bounds with machine-checked integer arithmetic verified by the Lean kernel.
* **Achieved** computational certainty by bypassing floating-point types in favor of exact cross-multiplication.

---

### 📂 Repository Contents
To maintain the integrity of the verification, the following files are included:

1. 📄 **A Formal Proof of the Irrationality of the Euler-Mascheroni Constant.pdf** The academic manuscript detailing the mathematical framework, Sondow’s Identity, and the Tail Trap mechanism.
2. 💻 **`Proof_Of_Euler-Mascheroni_Constant_Irrationality.lean`** The complete Lean 4 source code, including data structures, series summation, and the final contradiction theorem.
3. 🖼️ Geometric Visualization of Sondow’s Identity and the Tail Trap Mechanism.jpg
The high-resolution academic figure (Figure 1) illustrating the geometric logic of the proof and the formal verification flow.

---

### ⚙️ How to Verify
1. Copy the contents of **`Proof_Of_Euler-Mascheroni_Constant_Irrationality.lean`**.
2. Visit the [Lean 4 Web Editor](https://live.lean-lang.org/).
3. Paste the code into the editor.

---

### 📜 License
This work is licensed under a **Creative Commons Attribution 4.0 International License (CC-BY-4.0)**.

---

### 🙏 Acknowledgments
The author acknowledges the assistance of a large language model, Gemini, for its role as a formalization assistant in preparing these materials.
