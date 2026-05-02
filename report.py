#!/usr/bin/env python3

import subprocess
import sys
import json

session_key = sys.argv[1] if len(sys.argv) > 1 else "latest"

# Fetch and save meetings data
subprocess.run([
    "curl", "-s",
    f"https://api.openf1.org/v1/meetings?meeting_key={session_key}",
    "-o", "meetings.json"
])

# Extract from the file
with open("meetings.json") as f:
    meetings = json.load(f)
    flag_url = meetings[0]["country_flag"]
    circuit_url = meetings[0]["circuit_image"]
    circuit_info_url = meetings[0]["circuit_info_url"]
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

# Continue with other fetches
subprocess.run([
    "curl", "-s",
    f"https://api.openf1.org/v1/drivers?session_key={session_key}",
    "-o", "drivers.json"
])
subprocess.run([
    "curl", "-s",
    f"https://api.openf1.org/v1/sessions?session_key={session_key}",
    "-o", "sessions.json"
])
subprocess.run([
    "curl", "-s",
    f"https://api.openf1.org/v1/session_result?session_key={session_key}",
    "-o", "session_result.json"
])

subprocess.run(["typst", "c", "report.typ"])