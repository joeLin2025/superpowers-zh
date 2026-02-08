$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

function Select-AgentTarget {
  Write-Host "Select agent model to install:"
  Write-Host "  1) codex"
  Write-Host "  2) gemini"
  while ($true) {
    $rawChoice = Read-Host "Enter 1 or 2"
    $choice = if ($null -eq $rawChoice) { "" } else { $rawChoice.Trim() }

    switch ($choice) {
      "1" {
        $agentName = "Codex"
        $codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $env:USERPROFILE ".codex" }
        $contextDir = $codexHome
        $contextFile = Join-Path $contextDir "AGENTS.md"
        $skillsDir = Join-Path (Join-Path $env:USERPROFILE ".agents") "skills"
        break
      }
      "2" {
        $agentName = "Gemini CLI"
        $geminiDir = Join-Path $env:USERPROFILE ".gemini"
        $contextDir = $geminiDir
        $contextFile = Join-Path $contextDir "GEMINI.md"
        $skillsDir = Join-Path $geminiDir "skills"
        break
      }
      default {
        Write-Host "Invalid selection. Please enter 1 or 2."
      }
    }

    if ($agentName -and $skillsDir -and $contextFile) {
      break
    }
  }

  return @{
    AgentName = $agentName
    SkillsDir = $skillsDir
    ContextFile = $contextFile
  }
}

$target = Select-AgentTarget

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
  throw "python not found. Please install Python 3 and ensure 'python' is available in PATH."
}

Write-Host ("Installing Superpowers for {0}..." -f $target.AgentName)

New-Item -ItemType Directory -Force $target.SkillsDir | Out-Null
New-Item -ItemType Directory -Force (Split-Path -Parent $target.ContextFile) | Out-Null

Write-Host ("Copying skills to {0}" -f $target.SkillsDir)
Copy-Item -Recurse -Force (Join-Path $projectRoot "skills\*") $target.SkillsDir

Write-Host ("Generating {0}" -f $target.ContextFile)
if (Test-Path $target.ContextFile) {
  Copy-Item -Force $target.ContextFile "$($target.ContextFile).old"
}

$env:PYTHONIOENCODING = "utf-8"
python -c "import sys, subprocess, pathlib; pr=sys.argv[1]; out=sys.argv[2]; agent=sys.argv[3]; content=subprocess.check_output([sys.executable, str(pathlib.Path(pr) / 'scripts' / 'generate_registry.py'), '--template', str(pathlib.Path(pr) / 'bootstrap' / 'BOOTSTRAP.md'), '--agent-name', agent], text=True, encoding='utf-8'); pathlib.Path(out).write_text(content, encoding='utf-8')" $projectRoot $target.ContextFile $target.AgentName

Write-Host "Done. Please restart your agent CLI."
