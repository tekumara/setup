## ffgrep usage

When using `ffgrep`:

- For whole-repo searches, omit `path`.
  - Use: `ffgrep(pattern="needle")`
  - Do not use: `ffgrep(pattern="needle", path=".")`
  - Do not use: `ffgrep(pattern="needle", path="./")`

- For directory constraints, include the trailing slash.
  - Use: `ffgrep(pattern="needle", path="app/")`
  - Do not use: `ffgrep(pattern="needle", path="app")`

- For file/glob constraints, use explicit files or globs.
  - Use: `ffgrep(pattern="needle", path="app/file.py")`
  - Use: `ffgrep(pattern="needle", path="*.py")`

Reason: `path="."` and directory constraints without trailing slash can return false negatives.
