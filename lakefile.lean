import Lake
open Lake DSL

package «lean_manifests» where
  leanOptions := #[
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib «LeanManifests» where
