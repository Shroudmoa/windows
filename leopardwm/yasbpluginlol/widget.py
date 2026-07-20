import subprocess
import sys

try:
    result = subprocess.run(
        ["lwm", "query", "workspace"],
        capture_output=True,
        text=True,
        timeout=5,
        check=True,
    )

    lines = result.stdout.strip().splitlines()


    Win = lines[1].split(":", 1)[1].strip() if len(lines) > 1 else "?"
    Co = lines[2].split(":", 1)[1].strip() if len(lines) > 2 else "?"

    # Kurze ASCII-Ausgabe
    print(f"{Win} | {Co}")

except Exception as e:
    print(f"ERR: {e}")

sys.stdout.flush()
