import sys
import json
import os

abbrevs = None
if len(sys.argv) < 2:
    sys.stderr.write("[WARN] lean4-abbrevs no input\n")
    exit(1)
input = sys.argv[1]

config_path = os.path.dirname(__file__)

with open(os.path.join(config_path, 'abbreviations.json')) as f:
    raw = f.read()
    abbrevs = json.loads(raw)

if abbrevs is None:
    sys.stderr.write("[ERROR] lean4.kak: Could not load abbreviations.json\n")
    exit(1)

abbrevs = \
    dict(sorted(abbrevs.items(), key=lambda item: len(item[0]), reverse=True))
abbrevs = {'\\' + k: v for (k, v) in abbrevs.items()}

for (k, v) in abbrevs.items():
    input = input.replace(k, v)
sys.stdout.write(input)
