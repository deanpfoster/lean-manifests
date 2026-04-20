import Lake
open Lake DSL

package «dean_lean» where
  leanOptions := #[
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib «DeanLean» where
