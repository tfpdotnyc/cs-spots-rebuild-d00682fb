# SPOTS — Open Questions

Version: 0.1.0
Last Updated: 2026-06-10
Instructions: answer inline under each question. Once a section is fully answered, mark the section header with `[answered]` and I'll fold it into `READ_MODEL.md` + the next migration.

---

## A — Customer Information panel

### A.1 Web PW generation
The screenshot shows `Web PW: SP4JDGMEWGW26`. What generates this string? Is it (a) random per-customer at insert, (b) derived from customer #/school/class, or (c) manually typed? Where is it used (proof site login? gallery share?)?

> _answer:_

### A.2 Misc1 / Misc2 / Misc3 — semantics
User confirmed these fields are actively used. Screenshot shows `Misc1: 2`. Defer the deep quiz, but please give a one-liner for each so the schema can label them in the UI:

- Misc1 — what does it represent? (free text? code? lookup?)
- Misc2 — same
- Misc3 — same

> _answer:_

### A.3 Overlay Text
What does Overlay Text drive? Is it (a) text burned onto exported images, (b) caption on the proof book, (c) something else? Per-pose or per-customer?

> _answer:_

### A.4 `# IDs Printed` lifecycle
Is this incremented automatically by "Print ID Card" or manually edited by staff? If automatic, does it reset per school year / per session?

> _answer:_

### A.5 Print Proofs vs Proof Book vs Print ID Card
What does each one physically produce and where does it go? (Local printer? PDF? Lab hot folder? Email to parent?)

> _answer:_

## B — Session Overview grid

### B.1 Session remove behavior
When a session is removed, what happens to (a) its `imageproperties`, (b) its `sessionpayments`, (c) any related `orders`? Soft-delete (hidden) or hard-delete (gone)?

> _answer:_

### B.2 Appointment Deposit
The "Appointment Deposit" button on the Session row — does this (a) record a deposit paid at the time the appointment was scheduled, (b) consume an existing deposit from `deposit_payments`, or (c) something else? How does it offset against the first order's balance?

> _answer:_

### B.3 Session Type / Session By
"Session Type" column shows "2 Photo Session and Proof" — is this a free text dropdown from `lists`, or a fixed enum? "Session By" shows a person's name — is that the photographer, the photo assistant, or the salesperson who booked?

> _answer:_

## C — Order Overview grid

### C.1 Order Status state machine
What are the valid status values and the allowed transitions? Screenshot shows "Order Shipped". Need the full list (e.g. New → Submitted → In Production → Shipped → Closed?) and which roles can move which transitions.

> _answer:_

### C.2 Reorders
Does "Reorders" (a) create a new `orders` row that references the original, (b) append line items to the existing order, or (c) duplicate the order line-by-line into a new one?

> _answer:_

### C.3 Print ID Card
What's on the card (name + pose + school + grade + Student ID 1?) and where is it printed (local card printer, PDF to lab, neither)?

> _answer:_

### C.4 Customer Folder
What does this button do? Open a network share path? Build a zip of the customer's full-res images? Trigger a sync to the lab hot folder?

> _answer:_

## D — Pose strip

### D.1 YB Pose vs Aux Pose
"YB Pose" = yearbook pose, I assume. What's "Aux Pose" used for? Is it a second yearbook pose for a different publication, or the photo used on the ID card, or something else?

> _answer:_

### D.2 Pose count
The strip always shows 1..10. Is 10 a hard cap, the typical max, or does it scroll when there are more?

> _answer:_

## E — Cross-cutting

### E.1 External touches
Which of these actually fire today? (yes/no each)
- Email out (order confirmations, proof-ready notifications)
- Print to local printer
- Write to a lab hot folder (path?)
- Sync to a network share
- QuickBooks / accounting export
- SMS

> _answer:_

### E.2 Multi-user / multi-workstation
Is SPOTS run on (a) one workstation only, (b) several office workstations on a LAN against the shared MDB, (c) office + offline laptops for on-site shoots? If (c), how do laptops sync back today?

> _answer:_

### E.3 Studio-specific query variants
`QUERY_MAP.md` flags ~20 queries suffixed `JKB` or `CONTINENTAL` as `deprecate`. Confirm those are dead — any of them still run today?

> _answer:_

### E.4 Workflows that can be killed
Anything on the main screen you've stopped using? (e.g. "we never click Proof Book anymore", "Appointment Deposit is legacy"). Marking dead saves migration work.

> _answer:_
