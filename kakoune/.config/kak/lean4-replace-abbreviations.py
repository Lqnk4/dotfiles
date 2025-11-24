import sys
import json
import os

abbrevs = None
input = sys.stdin.read().splitlines(False)

config_path = os.path.dirname(__file__)

with open(os.path.join(config_path, 'abbreviations.json')) as f:
    raw = f.read()
    abbrevs = json.loads(raw)

if abbrevs is None:
    sys.stderr.write("[ERROR] lean4.kak: Could not load abbreviations.json")
    exit(1)

abbrevs = \
    dict(sorted(abbrevs.items(), key=lambda item: len(item[0]), reverse=True))
abbrevs = {'\\' + k: v.replace("$CURSOR", "")
           for (k, v) in abbrevs.items() if k != "\\\\"}

for line in input:
    for (k, v) in abbrevs.items():
        line = line.replace(k, v)
    print(line)
