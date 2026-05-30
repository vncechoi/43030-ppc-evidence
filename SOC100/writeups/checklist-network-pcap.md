# Network / PCAP Triage Checklist (Wireshark)

## 1) Scope first (always)
- What is the question? (malware download, beaconing, scanning, torrents, data exfil, suspicious domain)
- What is the timeframe?
- What host/IP is in scope?
- What is “normal” expected traffic for this host?

## 2) Quick triage views (Wireshark)
Start broad, then narrow.

### A) Protocol and volume overview
- Protocol Hierarchy (what protocols dominate?)
- Conversations / Endpoints (top talkers by bytes/packets)

### B) Identify key endpoints
Record:
- Source IPs, destination IPs
- Ports and protocols
- First seen / last seen timestamps

## 3) High-signal checks (common indicators)
### DNS
- Look for unusual domains, random-looking subdomains, or frequent repeated queries
- Note queried domain + resolved IP + timing pattern

### HTTP (if present)
- Check request methods and URLs (GET/POST)
- Review Host header (suspicious domains)
- Look for unusual file types or mismatched file extensions (e.g., `.tiff` carrying executable indicators)
- Use “Follow TCP Stream” to view full HTTP conversation

### TCP behaviour
- Repeated short connections at regular intervals (beaconing)
- Many SYNs / resets / failed handshakes (scanning or connectivity issues)
- Large transfers to unknown endpoints (possible exfil)

## 4) Practical filters to use (examples)
Use what fits your capture:
- `http.request`
- `dns`
- `tcp`
- `ip.addr == <IP>`
- `tcp.port == <PORT>`
- `ip contains "<string>"` (e.g., to locate suspicious payload strings)

## 5) What to document (minimum evidence notes)
- Key IPs/domains/ports
- Timeline (first seen / last seen)
- Why it’s suspicious (what evidence supports it)
- What is still unknown
- Screenshots (if available): endpoints, follow stream, key packets

## 6) Escalation guidance (when to raise)
Escalate if you observe:
- Confirmed malware indicators (e.g., executable bytes or known malicious hash)
- Connections to known malicious domains/IPs
- Evidence of credential abuse + suspicious outbound activity
- Large or unusual outbound transfers
- Persistent beacon-like traffic patterns

## 7) Recommended next steps (SOC-style)
- Identify affected host/user and open an incident/ticket
- Collect endpoint logs (Windows event logs/Sysmon if Windows)
- Pull file hashes if downloads occurred and check threat intel
- Block malicious domain/IP at DNS/proxy/firewall (if confirmed)
- Scope: search environment for same indicators on other hosts
