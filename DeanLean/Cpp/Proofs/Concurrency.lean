import DeanLean.Cpp.Code.Concurrency

/-! # Proofs for C++ happens-before memory model (N4950 §33)

  Proves the key properties:
  - HappensBefore is a strict partial order (in well-formed executions)
  - SequencedBefore ⊆ HappensBefore
  - SynchronizesWith ⊆ HappensBefore
  - Single-threaded programs with total sequencing are race-free
-/

namespace Cpp.Concurrency

variable {exec : Execution}

/-! ## Layer 2 proofs: HappensBefore is a strict partial order -/

/-- HappensBefore is transitive. -/
theorem hb_transitivity_proof {e1 e2 e3 : Event}
    (h12 : HappensBefore exec e1 e2) (h23 : HappensBefore exec e2 e3) :
    HappensBefore exec e1 e3 :=
  HappensBefore.trans h12 h23

/-- SequencedBefore is contained in HappensBefore. -/
theorem sb_in_hb_proof {e1 e2 : Event}
    (h : exec.sequencedBefore e1 e2) : HappensBefore exec e1 e2 :=
  HappensBefore.sb h

/-- SynchronizesWith is contained in HappensBefore. -/
theorem sw_in_hb_proof {e1 e2 : Event}
    (h : exec.synchronizesWith e1 e2) : HappensBefore exec e1 e2 :=
  HappensBefore.sw h

/-- In a well-formed execution, HappensBefore is irreflexive. -/
theorem hb_is_irreflexive_proof
    (wf : exec.wellFormed) (e : Event) :
    ¬ HappensBefore exec e e :=
  wf e

/-- In a well-formed execution, HappensBefore is asymmetric. -/
theorem hb_is_asymmetric_proof
    (wf : exec.wellFormed) {e1 e2 : Event}
    (h : HappensBefore exec e1 e2) : ¬ HappensBefore exec e2 e1 := by
  intro h'
  exact wf e1 (HappensBefore.trans h h')

/-- sb;sb yields hb. -/
theorem sb_sb_yields_hb_proof {e1 e2 e3 : Event}
    (h12 : exec.sequencedBefore e1 e2) (h23 : exec.sequencedBefore e2 e3) :
    HappensBefore exec e1 e3 :=
  HappensBefore.trans (HappensBefore.sb h12) (HappensBefore.sb h23)

/-- sb;sw yields hb. -/
theorem sb_sw_yields_hb_proof {e1 e2 e3 : Event}
    (h12 : exec.sequencedBefore e1 e2) (h23 : exec.synchronizesWith e2 e3) :
    HappensBefore exec e1 e3 :=
  HappensBefore.trans (HappensBefore.sb h12) (HappensBefore.sw h23)

/-- sw;sb yields hb. -/
theorem sw_sb_yields_hb_proof {e1 e2 e3 : Event}
    (h12 : exec.synchronizesWith e1 e2) (h23 : exec.sequencedBefore e2 e3) :
    HappensBefore exec e1 e3 :=
  HappensBefore.trans (HappensBefore.sw h12) (HappensBefore.sb h23)

/-! ## Layer 3 proofs: Data race detection -/

/-- Conflict is symmetric. -/
theorem conflict_is_symmetric_proof {a1 a2 : MemoryAccess}
    (h : conflict a1 a2) : conflict a2 a1 := by
  obtain ⟨hloc, hwrite, hneq⟩ := h
  exact ⟨hloc.symm, hwrite.symm, hneq.symm⟩

/-- DataRace is symmetric. -/
theorem dataRace_is_symmetric_proof {a1 a2 : MemoryAccess}
    (h : DataRace exec a1 a2) : DataRace exec a2 a1 := by
  obtain ⟨hconf, hnhb12, hnhb21⟩ := h
  exact ⟨conflict_is_symmetric_proof hconf, hnhb21, hnhb12⟩

/-- Two reads never conflict (neither is a write). -/
theorem two_reads_no_conflict_proof {a1 a2 : MemoryAccess}
    (h1 : a1.kind = .read) (h2 : a2.kind = .read)
    : ¬ conflict a1 a2 := by
  intro ⟨_, hwrite, _⟩
  cases hwrite with
  | inl hw => rw [h1] at hw; exact absurd hw (by decide)
  | inr hw => rw [h2] at hw; exact absurd hw (by decide)

/-- Two reads never race. -/
theorem two_reads_no_race_proof {a1 a2 : MemoryAccess}
    (h1 : a1.kind = .read) (h2 : a2.kind = .read)
    : ¬ DataRace exec a1 a2 := by
  intro ⟨hconf, _, _⟩
  exact two_reads_no_conflict_proof h1 h2 hconf

/-- If one access happens-before another, they don't race. -/
theorem hb_prevents_dataRace_proof {a1 a2 : MemoryAccess}
    (h : HappensBefore exec a1.event a2.event) :
    ¬ DataRace exec a1 a2 := by
  intro ⟨_, hnhb, _⟩
  exact hnhb h

/-- The key theorem: single-threaded execution with total sequencing is race-free. -/
theorem singleThread_is_raceFree_proof {accesses : List MemoryAccess}
    (hst : SingleThreaded accesses)
    (htotal : exec.sbTotal)
    (_hmem : ∀ (a : MemoryAccess), a ∈ accesses → a.event ∈ exec.events)
    : RaceFree exec accesses := by
  intro a1 a2 h1 h2 ⟨⟨_, _, hneq⟩, hnhb12, hnhb21⟩
  have hsame : a1.event.threadId = a2.event.threadId := hst a1 a2 h1 h2
  have hord := htotal a1.event a2.event hsame hneq
  cases hord with
  | inl hsb => exact hnhb12 (HappensBefore.sb hsb)
  | inr hsb => exact hnhb21 (HappensBefore.sb hsb)

/-! ## Execution axiom consequences -/

/-- SequencedBefore is irreflexive. -/
theorem sb_is_irreflexive_proof (e : Event) :
    ¬ exec.sequencedBefore e e :=
  exec.sb_irrefl e

/-- SequencedBefore relates only same-thread events. -/
theorem sb_preserves_thread_proof {e1 e2 : Event}
    (h : exec.sequencedBefore e1 e2) : e1.threadId = e2.threadId :=
  exec.sb_same_thread e1 e2 h

/-- SynchronizesWith relates only different-thread events. -/
theorem sw_crosses_threads_proof {e1 e2 : Event}
    (h : exec.synchronizesWith e1 e2) : e1.threadId ≠ e2.threadId :=
  exec.sw_diff_thread e1 e2 h

/-! ## Layer 5 proofs: Concurrency patterns -/

/-- The fundamental theorem of acquire/release: if a release store
    synchronizes-with an acquire load, then everything sequenced-before
    the store happens-before everything sequenced-after the load.
    This is the key theorem that makes message passing work. -/
theorem acquire_release_guarantee_proof :
    ∀ {exec : Execution} {before_store store_event load_event after_load : Event},
    exec.sequencedBefore before_store store_event →
    exec.synchronizesWith store_event load_event →
    exec.sequencedBefore load_event after_load →
    HappensBefore exec before_store after_load :=
  fun hsb_before hsw hsb_after =>
    HappensBefore.trans
      (HappensBefore.trans (HappensBefore.sb hsb_before) (HappensBefore.sw hsw))
      (HappensBefore.sb hsb_after)

/-- In the message-passing pattern, the data write happens-before the data read.
    This is a direct consequence of the acquire/release guarantee. -/
theorem message_passing_data_ordered_proof {exec : Execution}
    (mp : MessagePassingPattern exec) :
    HappensBefore exec mp.dataWrite mp.dataRead :=
  acquire_release_guarantee_proof mp.sb_write_store mp.sw_store_load mp.sb_load_read

/-- The message-passing pattern is race-free: the data write and data read
    are not a data race, because the write happens-before the read. -/
theorem message_passing_is_race_free_proof {exec : Execution}
    (mp : MessagePassingPattern exec) :
    ¬ DataRace exec mp.dataWriteAccess mp.dataReadAccess := by
  simp only [MessagePassingPattern.dataWriteAccess, MessagePassingPattern.dataReadAccess]
  intro ⟨_, hnhb, _⟩
  exact hnhb (message_passing_data_ordered_proof mp)

/-- In a mutex execution, thread 1's work happens-before thread 2's work.
    The chain is: work₁ →sb unlock₁ →sw lock₂ →sb work₂ -/
theorem mutex_critical_sections_ordered_proof {exec : Execution}
    (mx : MutexExecution exec) :
    HappensBefore exec mx.work₁ mx.work₂ :=
  HappensBefore.trans
    (HappensBefore.trans (HappensBefore.sb mx.sb_work₁_unlock₁) (HappensBefore.sw mx.sw_unlock₁_lock₂))
    (HappensBefore.sb mx.sb_lock₂_work₂)

/-- In a mutex execution, everything from lock₁ to unlock₁ happens-before
    everything from lock₂ to unlock₂. Specifically, lock₁ hb lock₂. -/
theorem mutex_lock_order_proof {exec : Execution}
    (mx : MutexExecution exec) :
    HappensBefore exec mx.lock₁ mx.lock₂ :=
  HappensBefore.trans
    (HappensBefore.trans (HappensBefore.sb mx.sb_lock₁_work₁) (HappensBefore.sb mx.sb_work₁_unlock₁))
    (HappensBefore.sw mx.sw_unlock₁_lock₂)

end Cpp.Concurrency
