# Investigation 02 — Windows Logs (Event Viewer + Sysmon)

## Summary (what happened?)
I reviewed Windows event logs and enhanced Sysmon telemetry to demonstrate a repeatable log triage workflow. The objective was to identify authentication activity, potential suspicious failures, and process/file activity that could indicate compromise or policy misuse. This investigation uses core Windows Security log event IDs (4624/4625/4688) and Sysmon events (1/11/3) to show how I would assess whether escalation is required.

## Evidence checked
### Windows Event Viewer (Windows Logs)
- **Security log**
  - Filtered for **4624 (logon success)** and **4625 (logon failure)** to determine authentication activity and potential brute force/unauthorised attempts. :contentReference[oaicite:2]{index=2}
  - Reviewed logon fields such as account name, domain, source/workstation information, and logon type where available. :contentReference[oaicite:3]{index=3}
- **Process creation**
  - Filtered for **4688 (process creation)** to establish process activity following authentication and to support timeline building. :contentReference[oaicite:4]{index=4}
- **PowerShell verification**
  - Used `Get-EventLog -LogName Security` and a targeted query (`-InstanceId 4625`) as a faster way to retrieve relevant events. :contentReference[oaicite:5]{index=5}

### Sysmon (Enhanced Logging)
- Verified Sysmon logs in:
  - **Applications and Services Logs > Microsoft > Windows > Sysmon/Operational** :contentReference[oaicite:6]{index=6}
- Focused on:
  - **Event ID 1 (Process creation)** — e.g., starting Notepad. :contentReference[oaicite:7]{index=7}
  - **Event ID 11 (File create)** — verifying a created test file was captured. :contentReference[oaicite:8]{index=8}
  - **Event ID 3 (Network connection)** — outbound connections generated during browsing. :contentReference[oaicite:9]{index=9}
- Collected recent Sysmon events remotely using PowerShell (`Invoke-Command` + `Get-WinEvent`) to show enterprise-style log retrieval and review. :contentReference[oaicite:10]{index=10}

## Findings (what I found and why it matters)
- **Authentication visibility is strongest in Security logs (4624/4625):**
  - Successful and failed logons allow quick identification of suspicious patterns (e.g., repeated failures) and attribution (account + potential source details). :contentReference[oaicite:11]{index=11}
- **4688 provides high-value context after logons:**
  - Process creation events help determine what executed after a logon and are useful for validating suspicious behaviour, especially when combined with a timeline and user context. :contentReference[oaicite:12]{index=12}
- **Sysmon adds deeper telemetry and improves investigation quality:**
  - Sysmon’s **process (ID 1)**, **file create (ID 11)**, and **network connection (ID 3)** events provide richer detail than standard logs, enabling more confident conclusions and better auditing. :contentReference[oaicite:13]{index=13}
- **Operational takeaway:**
  - A log investigation should start with scope (host/user/time window), then pivot from authentication → process creation → file/network activity, and finally decide whether to resolve locally or escalate.

## Recommended escalation / next steps
1. **If repeated 4625 failures are observed:** treat as potential brute force/credential misuse; escalate with evidence (event IDs, times, account targeted, suspected source/workstation). :contentReference[oaicite:14]{index=14}
2. **If suspicious 4688 process creation appears (unexpected binaries/paths/command-lines):**
   - correlate with logon events and validate whether the process is legitimate; escalate if execution is inconsistent with user role. :contentReference[oaicite:15]{index=15}
3. **Use Sysmon to confirm behaviour and collect stronger evidence:**
   - attach Sysmon event extracts (IDs 1/3/11) to incident ticket; preserve timeline and artifacts. :contentReference[oaicite:16]{index=16}
4. **Operational controls:**
   - ensure enhanced logging is deployed consistently across endpoints and that log export/collection procedures exist for incident response.
