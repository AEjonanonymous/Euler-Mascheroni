import Lake
open Lake DSL

package «EulerMascheroni» where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «Proof_Of_Euler-Mascheroni_Constant_Irrationality» where
  srcDir := "."
