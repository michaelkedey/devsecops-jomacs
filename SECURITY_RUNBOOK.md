# Incident Response: Unauthorized Access

**This runbook provides step-by-step guidance for responding to unauthorized access events identified through the ELK stack (Filebeat → Logstash → Elasticsearch → Kibana).**
---

## 1. Detection
- [ ] An alert is received from **Filebeat/Kibana** (e.g., GeoIP shows access from an unknown or untrusted country)
- [ ] Review logs and dashboards in **Kibana**
  - Look for:
    - Sudden spikes in access
    - Unknown IPs or geolocations
    - Unusual request patterns (e.g., brute-force, unknown user agents)
- [ ] Confirm anomaly using Kibana visualizations (e.g., pie charts for country, browser, city)
---

## 2. Containment
- [ ] Block suspicious IPs via:
  - UFW:  
    ```bash
    sudo ufw deny from <IP_ADDRESS>
    ```
  - Nginx (add to `deny` list or configure geo-blocking)
  - sudo vi /etc/mginx/conf.d/blocklist.conf
    ```
        deny <suspicious-ip>;
    ```
  - `sudo nginx -s reload`

- [ ] Rotate any potentially compromised secrets or tokens (e.g., API keys, SSH keys, .env values)
- [ ] Revoke access if the intrusion is linked to a specific user account
---

## 3. Eradication & Recovery

- [ ] Check server logs for signs of tampering:
  - `/home/ubuntu/my-app/logs/access.logs`
  - Application logs in `Filebeat`
- [ ] If evidence of compromise exists:
  - Isolate affected services
  - Restore from **most recent clean backup**
  - Rebuild compromised containers or servers if necessary
- [ ] Reinstall or patch vulnerable software
---

## 4. Lessons Learned

- [ ] Conduct a **postmortem** with the team
  - Timeline of the incident
  - Root cause analysis
  - Actions taken
- [ ] Update detection rules in **Filebeat** or **Logstash** (e.g., new GeoIP filters)
- [ ] Improve Kibana dashboards for better anomaly detection
- [ ] Document everything in your incident log or wiki
---