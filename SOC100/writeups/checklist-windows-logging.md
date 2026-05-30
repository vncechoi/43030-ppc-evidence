# Windows Logging Triage Checklist (Event Viewer + Sysmon)

## 1) Scope first (always)
- Hostname / IP:
- User account(s) involved:
- Time window:
- What are we investigating? (login anomaly / suspicious process / policy change / malware suspicion)

## 2) Windows Event Viewer (baseline triage)
### Start here: Windows Logs
- Security (auth + access)
- System (services/drivers)
- Application (app errors/crashes)

### Security log quick filters
- **4624** = logon success :contentReference[oaicite:17]{index=17}
- **4625** = logon failure :contentReference[oaicite:18]{index=18}
- **4688** = process creation :contentReference[oaicite:19]{index=19}

Record for key events:
- Timestamp
- Event ID
- Account name + domain
- Source/workstation details (if present)
- Logon type (if present)
- Process name / PID / parent process (for 4688)

## 3) Sysmon (enhanced logging)
Where:
- Applications and Services Logs > Microsoft > Windows > Sysmon/Operational :contentReference[oaicite:20]{index=20}

High-value Sysmon IDs:
- **1** = Process creation :contentReference[oaicite:21]{index=21}
- **11** = File create :contentReference[oaicite:22]{index=22}
- **3** = Network connection :contentReference[oaicite:23]{index=23}

Record:
- Process name + command line
- Parent process
- File path
- Network destination (IP/domain/port) if event ID 3

## 4) Fast CLI queries (optional)
- `Get-EventLog -LogName Security -InstanceId 4625` (target failures) :contentReference[oaicite:24]{index=24}
- `Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 10` (recent Sysmon) :contentReference[oaicite:25]{index=25}

## 5) Escalation triggers (when to raise)
Escalate if you see:
- Repeated 4625 failures against a single account or across many accounts (possible brute force)
- 4624 followed by unusual 4688 process creation (suspicious execution chain)
- Sysmon shows unexpected process + file creation + outbound connections from that process

## 6) What to attach to the incident/ticket
- Key event screenshots or exported logs
- Timeline summary (first seen / last seen)
- Accounts/hosts involved
- Any extracted file/process/network indicators
