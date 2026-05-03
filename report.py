#!/usr/bin/env python3

import subprocess
import sys
import json

meeting_key = sys.argv[1] if len(sys.argv) > 1 else "latest"

subprocess.run([
    "curl", "-s",
    f"https://api.openf1.org/v1/meetings?meeting_key={meeting_key}",
    "-o", "meetings.json"
])

with open("meetings.json") as f:
    meetings = json.load(f)
    flag_url = meetings[0]["country_flag"]
    circuit_url = meetings[0]["circuit_image"]
    circuit_info_url = meetings[0]["circuit_info_url"]    
    meeting_name = meetings[0]["meeting_name"]
    subprocess.run([
    "curl", "-s",
    flag_url,
    "-o", "flag.png"
    ])
    subprocess.run([
    "curl", "-s",
    circuit_url,
    "-o", "circuit.png"
    ])
    subprocess.run([
    "curl", "-s",
    circuit_info_url,
    "-o", "circuit_info.json"
    ])

subprocess.run([
    "curl", "-s",
    f"https://api.openf1.org/v1/drivers?meeting_key={meeting_key}",
    "-o", "drivers.json"
])
subprocess.run([
    "curl", "-s",
    f"https://api.openf1.org/v1/sessions?meeting_key={meeting_key}",
    "-o", "sessions.json"
])
subprocess.run([
    "curl", "-s",
    f"https://api.openf1.org/v1/session_result?meeting_key={meeting_key}",
    "-o", "session_result.json"
])

subprocess.run(["typst", "c", "report.typ", "-o", meeting_name])
