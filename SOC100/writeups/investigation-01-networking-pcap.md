# Investigation 01 — Networking / PCAP (HTTP download of disguised executable)

## Summary (what happened?)
During analysis of a provided network capture, I identified a suspicious HTTP download that appeared to be an image file (`.tiff`) but contained Windows executable indicators. This suggests an executable was likely disguised as a benign file type to bypass basic filtering and user suspicion. The download originated from an unusual external host and was associated with a specific internal user account, indicating a potential malware delivery event that should be escalated.

## Evidence checked
- Wireshark display filter used to locate executable indicators inside network payload:
  - `ip contains "This program"`
- Followed the TCP stream for the relevant packet:
  - Packet **11419** → **Follow TCP Stream**
- Reviewed HTTP request/response content within the stream:
  - Observed HTTP headers and GET request
  - Noted requested object: `/40group.tiff`
  - Noted Host header: `acjabogados.com`
- Validated executable characteristics in payload:
  - Observed the string **“This program cannot be run in DOS mode.”**
  - Observed **“MZ”** magic bytes indicating a PE executable header (not expected for a real TIFF)
- Exported the object from Wireshark:
  - File → Export Objects → HTTP → selected the object from `acjabogados.com` (packet **11979**) and saved it locally
- Identified the likely user account responsible:
  - Filter: `kerberos.CNameString and ip.addr==10.11.11.203`
  - Observed CNameString showing the user **candice.tucker**
- (Post-export validation steps in the lab)
  - `Get-FileHash .\40group.tiff` (PowerShell)
  - VirusTotal search for hash to obtain detection rate

## Findings (what I found and why it matters)
- **Suspicious object name:** `40group.tiff` was downloaded over HTTP, but the payload includes Windows executable indicators (MZ header + DOS mode string).  
  → This strongly suggests a **Windows executable disguised as a TIFF image**.
- **Unusual external host:** `acjabogados.com` appears as the Host in the HTTP stream.  
  → This is an indicator of suspicious infrastructure (potential malware hosting).
- **Internal attribution:** Kerberos CNameString linked the activity to **candice.tucker** (associated with the destination host involved in the download).  
  → Provides a direct link between the suspicious download and a user account for incident scoping.
- **Security implication:** If executed, the file could lead to endpoint compromise, credential theft, lateral movement, or data loss depending on payload behaviour and privileges.

### Artifact validation (hash + VT)
- Exported object: `40group.tiff` (contained PE indicators: `MZ` + “This program cannot be run in DOS mode”)
- SHA-256: `8d5d36c8fbb0a9c81b145aa40c1f3475702fb0b5f9e08e0577bdc405087e635`
- VirusTotal detection: **61/71** vendors flagged as malicious
- VT file label/name: `Santo Maris Oia.exe` (380 KB)

## Recommended escalation / next steps
1. **Escalate as a suspected malware download** (high priority) with attached indicators:
   - Filename: `40group.tiff`
   - Host: `acjabogados.com`
   - Key evidence: “MZ” header + DOS-mode string in TCP stream
   - User: `candice.tucker`
2. **Containment actions (endpoint):**
   - Isolate the impacted workstation/host if possible
   - Quarantine the downloaded file
   - Run endpoint AV/EDR scan and capture triage artifacts (running processes, persistence checks)
3. **Threat intel / detection actions:**
   - Submit the hash to VirusTotal and document detection rate
   - Block `acjabogados.com` at DNS/web proxy (if confirmed malicious)
   - Search environment logs for other connections to the domain/IPs
4. **Documentation:**
   - Record timeline (packet numbers + timestamps), user, host, and exported object details
   - Open incident ticket with evidence attached (pcap references, stream notes, and hash results)
