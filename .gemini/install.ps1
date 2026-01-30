$ErrorActionPreference = "Stop"

# Paths
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot ..)
$sourceSkillsDir = Join-Path $repoRoot "skills"
$geminiGlobalDir = "$HOME\.gemini"
$destSkillsDir = Join-Path $geminiGlobalDir "skills"
$jsScript = Join-Path $repoRoot ".gemini\superpowers-gemini.js"

Write-Host "Starting Gemini CLI Superpowers Installation..."

# 1. Install Skills
if (-not (Test-Path $destSkillsDir)) {
    New-Item -ItemType Directory -Force -Path $destSkillsDir | Out-Null
    Write-Host "Created skills directory: $destSkillsDir"
}

# Copy skills
$skills = Get-ChildItem -Path $sourceSkillsDir -Directory
foreach ($skill in $skills) {
    $destPath = Join-Path $destSkillsDir $skill.Name
    if (Test-Path $destPath) {
        Remove-Item -Path $destPath -Recurse -Force
    }
    Copy-Item -Path $skill.FullName -Destination $destSkillsDir -Recurse -Force
    Write-Host "Installed skill: $($skill.Name)"
}

# 2. Run Bootstrap Logic (via Node.js script)
Write-Host "Running bootstrap injection..."
try {
    node $jsScript bootstrap
} catch {
    Write-Error "Failed to run bootstrap script. Ensure Node.js is installed."
}

Write-Host "Installation Complete!"