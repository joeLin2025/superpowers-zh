$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$geminiDir = Join-Path $env:USERPROFILE ".gemini"
$skillsDir = Join-Path $geminiDir "skills"
$globalContext = Join-Path $geminiDir "GEMINI.md"

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
  throw "python not found. Please install Python 3 and ensure 'python' is available in PATH."
}

Write-Host "Installing Gemini Superpowers..."

New-Item -ItemType Directory -Force $skillsDir | Out-Null

Write-Host "Copying skills to $skillsDir"
Copy-Item -Recurse -Force (Join-Path $projectRoot "skills\*") $skillsDir

Write-Host "Generating $globalContext"
if (Test-Path $globalContext) {
  Copy-Item -Force $globalContext "$globalContext.old"
}

$env:PYTHONIOENCODING = "utf-8"
python -c "import sys, subprocess, pathlib; pr=sys.argv[1]; out=sys.argv[2]; content=subprocess.check_output([sys.executable, str(pathlib.Path(pr) / 'scripts' / 'generate_registry.py')], text=True, encoding='utf-8'); pathlib.Path(out).write_text(content, encoding='utf-8')" $projectRoot $globalContext

Write-Host "Done. Please restart Gemini CLI."
