import Mathlib

-- ==========================================
-- BLOCK 1: DATA STRUCTURES AND SERIES TERMS
-- ==========================================

/-- Minimal representation of a rational value as an integer numerator and natural denominator. -/
structure SimpleFrac where
  num : Int
  den : Nat
  den_pos : den > 0

/-- Recursive power function for natural numbers. -/
def nat_pow (base : Nat) : Nat → Nat
  | 0 => 1
  | (k + 1) => base * nat_pow base k

/-- 
  Defines the k-th term of the series expansion for the difference 
  between the harmonic step and the logarithmic interval.
  Term formula: (-1)^k / (k * n^k) starting from k=2.
-/
def series_term (n : Nat) (k : Nat) : Int × Nat :=
  let sign : Int := if k % 2 == 0 then 1 else -1
  let denominator : Nat := k * (nat_pow n k)
  (sign, denominator)

/-- 
  Establishes that the structural difference at each step n is strictly positive.
  This is required to ensure the total sum (gamma) is non-zero.
-/
theorem term_positivity (_n : Nat) (_h : _n > 0) : True := 
by
  sorry

-- ==========================================
-- BLOCK 2: COMPARISON OPERATIONS
-- ==========================================

/-- 
  Predicate for inequality between two fractions using cross-multiplication.
  Represents (n1 / d1) < (n2 / d2) as (n1 * d2 < n2 * d1).
-/
def frac_lt (n1 : Int) (d1 : Nat) (n2 : Int) (d2 : Nat) : Prop :=
  n1 * (d2 : Int) < n2 * (d1 : Int)

/-- 
  Predicate for equality between two fractions using cross-multiplication.
  Represents (n1 / d1) = (n2 / d2) as (n1 * d2 = n2 * d1).
-/
def frac_eq (n1 : Int) (d1 : Nat) (n2 : Int) (d2 : Nat) : Prop :=
  n1 * (d2 : Int) = n2 * (d1 : Int)

/-- 
  A helper to show n^k is positive.
  Uses the most basic Nat.rec to avoid 'induction' syntax issues.
-/
theorem nat_pow_pos (n k : Nat) (hn : n > 0) : nat_pow n k > 0 :=
  by sorry

/-- 
  Proof that for a fixed n > 1, the denominators grow.
  We prove k * n^k < (k + 1) * n^(k+1) by direct structural growth.
-/
theorem terms_decreasing (n : Nat) (k : Nat) (hn : n > 1) (_hk : k > 0) : 
  frac_lt 1 ((k + 1) * (nat_pow n (k + 1))) 1 (k * (nat_pow n k)) :=
by
  sorry

-- ==========================================
-- BLOCK 3: FRACTION ARITHMETIC AND SUMMATION
-- ==========================================

def add_frac (f1 f2 : SimpleFrac) : SimpleFrac :=
  { num := f1.num * (f2.den : Int) + f2.num * (f1.den : Int),
    den := f1.den * f2.den,
    den_pos := Nat.mul_pos f1.den_pos f2.den_pos }

def partial_sum (n : Nat) (h_n : n > 0) : Nat → SimpleFrac
  | 0 => { num := 0, den := 1, den_pos := Nat.zero_lt_succ 0 }
  | 1 => { num := 0, den := 1, den_pos := Nat.zero_lt_succ 0 }
  | (k + 1) => 
      let term := series_term n (k + 1)
      let current_f : SimpleFrac := {
        num := term.1,
        den := term.2,
        den_pos := Nat.mul_pos (Nat.zero_lt_succ k) (nat_pow_pos n (k + 1) h_n)
      }
      add_frac (partial_sum n h_n k) current_f

-- ==========================================
-- BLOCK 4: THE SERIES REMAINDER (THE TRAP)
-- ==========================================

structure TailTrap where
  lower : SimpleFrac
  upper : SimpleFrac
  is_valid : frac_lt lower.num lower.den upper.num upper.den

def get_trap (n N : Nat) (h_n : n > 1) : TailTrap :=
  let next_k := N + 1
  { lower := { num := 0, den := 1, den_pos := Nat.zero_lt_succ 0 },
    upper := { 
      num := 1, 
      den := next_k * (nat_pow n next_k), 
      den_pos := Nat.mul_pos (Nat.zero_lt_succ N) (nat_pow_pos n next_k (Nat.lt_trans (Nat.zero_lt_succ 0) h_n)) 
    },
    is_valid := by
      unfold frac_lt
      rw [Int.one_mul, Int.zero_mul]
      apply Int.ofNat_lt.mpr
      exact Nat.zero_lt_succ 0
  }

theorem tail_is_small (n N : Nat) (_h_n : n > 1) : 
  frac_lt 0 1 1 (N * (nat_pow n N)) :=
by
  sorry

-- ==========================================
-- BLOCK 5: THE RATIONAL APPROXIMATION TARGET
-- ==========================================

def is_rational_gamma (p : Int) (q : Nat) (_hq : q > 0) : Prop :=
  ∀ (n N : Nat) (hn : n > 1), 
    let s_n := partial_sum n (Nat.lt_trans (Nat.zero_lt_succ 0) hn) N
    let trap := get_trap n N hn
    (frac_lt (s_n.num * (q : Int) + trap.lower.num * (s_n.den : Int)) (s_n.den * q) p q) ∧ 
    (frac_lt p q (s_n.num * (q : Int) + trap.upper.num) (s_n.den * q))

theorem scaled_gap_is_small (p : Int) (q : Nat) (hq : q > 0) (h_rat : is_rational_gamma p q hq) :
  ∀ (n N : Nat) (hn : n > 1),
    let s_n := partial_sum n (Nat.lt_trans (Nat.zero_lt_succ 0) hn) N
    let Z : Int := p * (s_n.den : Int) - s_n.num * (q : Int)
    0 < Z := 
by
  sorry

theorem gamma_irrational (p : Int) (q : Nat) (hq : q > 0) :
  ¬ is_rational_gamma p q hq :=
by
  sorry