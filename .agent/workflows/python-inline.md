---
description: Python inline scripts - avoid glob.glob on Cyrillic paths
---
# Python Inline Scripts Workflow

## Known Issue: `glob.glob()` hangs on Cyrillic paths

When the working directory contains Cyrillic characters (e.g., `~/Документы/`), `glob.glob()` may hang indefinitely when called from `python3 -c "..."`.

## Root Cause
`glob.glob()` internally uses `os.scandir()` + `fnmatch` pattern matching which can deadlock on filesystem paths with non-ASCII characters in certain locale configurations.

## Solution: Use `os.listdir()` + manual filtering

Instead of:
```python
# ❌ HANGS on Cyrillic paths
import glob
files = glob.glob('lib/l10n/app_*.arb')
```

Use:
```python
# ✅ Works reliably
import os
files = [os.path.join('lib/l10n', f) for f in os.listdir('lib/l10n') if f.startswith('app_') and f.endswith('.arb')]
```

## Alternative: Write script to file
If the inline script is complex, write it to a `.py` file and run:
```bash
python3 script.py
```

## General Rules for Inline Python
// turbo-all
1. Always use `os.listdir()` instead of `glob.glob()`
2. For complex scripts, write to a temp file and execute
3. Avoid heredoc (`<< 'EOF'`) with `python3` — use `python3 -c "..."` or `python3 script.py`
