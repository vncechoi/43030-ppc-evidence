# Ethics Framework Summary + Scenario Responses (Goal 1)

## Why this matters to my pathway
As an aspiring entry-level SOC / Assistant Cyber Security Analyst, ethical practice is part of professional credibility. Cyber work often involves access to sensitive systems, personal data, and security tooling that can cause harm if used without clear boundaries. Ethical thinking is not only “following rules”; it is making decisions that protect people, the organisation, and public trust.

---

## Core ethical principles (IT professional context)
1. **Public interest and harm minimisation**  
   Prioritise safety and wellbeing. Security work must not create new harm (e.g., unnecessary access, excessive data collection, vigilante actions).

2. **Privacy and data protection**  
   Access only what is necessary; treat logs and records as sensitive; follow least privilege; document purpose and retention.

3. **Honesty and transparency**  
   Communicate clearly about what happened, what is known/unknown, and what evidence supports conclusions. Avoid overstating certainty.

4. **Competence and due care**  
   Act within my capability; escalate when needed; follow process; avoid making changes without authorisation.

5. **Intellectual property and copyright**  
   Respect ownership and licensing, including content used in tools, documentation, training datasets, and any materials produced.

6. **Ethical hacking boundaries**  
   Authorisation and scope are everything. “Good intentions” do not justify actions outside permission/scope.

7. **Power, influence, and whistleblowing**  
   Recognise power imbalance in organisations. Raise concerns professionally, document objectively, and follow safe escalation pathways.

8. **Emerging challenges and social implications (AI, surveillance, automation)**  
   Consider bias, provenance, consent, and downstream misuse. Avoid deploying technology that is “effective” but socially harmful.

---

## The Ethical Thinking Framework I use (repeatable steps)
**Step 1 — Define the situation clearly**
- What is the decision/action?
- Who requested it and why?
- What is the scope and what are the constraints?

**Step 2 — Identify stakeholders**
- Who is directly affected? Indirectly affected?
- Who holds authority/rights (data owners, communities, regulators)?

**Step 3 — Identify obligations**
- Legal/policy obligations (privacy, confidentiality, acceptable use)
- Professional codes / organisational standards
- Any cultural obligations (especially if Indigenous stakeholders involved)

**Step 4 — Evaluate harms and benefits**
- Short-term vs long-term
- Likelihood and severity of harms
- Who bears the risk vs who gains the benefit?

**Step 5 — Consider alternatives**
- Is there a lower-risk way to achieve the same goal?
- Can I reduce the scope or increase consent/transparency?

**Step 6 — Decide, document, and escalate appropriately**
- Record the reasoning
- Seek approval if required
- Escalate if ethical risk remains or scope is unclear

**Step 7 — Review**
- What did we learn?
- What process controls should improve next time?

---

## Scenario Response 1 (300–400 words): Privacy + logging access
**Scenario:** I am asked to “check the logs” for a suspicious user, but the request is vague and suggests broad access to personal records unrelated to the incident.

**Response:**  
Using the ethical framework, I would first define the scope: what time window, which system, and what indicators triggered concern. Stakeholders include the user involved, other users whose data may appear in logs, and the organisation (duty of care and compliance). My obligations include privacy requirements, confidentiality, and least privilege—access should be proportionate and justified.

I would request clarification and a narrow scope before proceeding. If approval is required (e.g., manager authorisation for deeper access), I would obtain it and document the purpose. I would only collect evidence that is relevant (timestamps, event IDs, source IPs, affected accounts) and avoid exporting excessive data. If I identify irrelevant personal information, I would not record it in my notes unless it directly relates to the incident. My documentation would focus on facts, not assumptions: what was observed, what evidence supports it, and what remains unknown.

If the request remains ethically concerning (e.g., “look for anything you can find on this person”), I would escalate to a supervisor and recommend a formal process (incident ticket, access approval record). This approach protects the organisation from privacy breaches and protects the community from misuse of sensitive data, while still supporting legitimate security investigation.

---

## Scenario Response 2 (300–400 words): Ethical hacking boundaries
**Scenario:** A colleague suggests testing a suspected vulnerable system by “just trying a few exploits” on a live environment to confirm risk.

**Response:**  
Even if the intent is security improvement, this action can cause harm if it is not authorised, not scoped, or impacts availability. Using the ethical framework, the first step is to clarify scope and permission. Stakeholders include system owners, users who depend on uptime, and the organisation’s legal/compliance standing. My obligations include competence, due care, and adherence to organisational policy.

I would not perform exploitation without explicit authorisation and defined rules of engagement. Instead, I would propose a safer alternative: verify the vulnerability using non-destructive methods first (version identification, configuration review, approved scanning tools, or a test environment). If exploitation is needed, it should be performed in a controlled and authorised manner, ideally in a staging environment or through a sanctioned penetration testing process with documented approvals.

If the colleague insists on proceeding informally, I would raise the risk: potential outage, data corruption, and breach of policy. I would escalate to the appropriate manager/security lead and recommend formalising the work as a ticket/task with scope, timing, and rollback plan.

This approach aligns with professional practice: security work must improve outcomes without introducing new harm. Good intentions do not replace consent, process, and accountability.
