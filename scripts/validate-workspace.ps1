param(
  [string]$Root = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'
$Root = (Resolve-Path -LiteralPath $Root).Path
$failures = New-Object System.Collections.Generic.List[string]

function Add-Failure([string]$Message) {
  $script:failures.Add($Message) | Out-Null
}

function Relative-Path([string]$Path) {
  $full = [System.IO.Path]::GetFullPath($Path)
  $separators = [char[]]@('\', '/')
  $rootFull = [System.IO.Path]::GetFullPath($Root).TrimEnd($separators) + [System.IO.Path]::DirectorySeparatorChar
  if ($full.StartsWith($rootFull, [System.StringComparison]::OrdinalIgnoreCase)) {
    return $full.Substring($rootFull.Length)
  }
  return $full
}

$rootReadme = Join-Path $Root 'README.md'
if (-not (Test-Path -LiteralPath $rootReadme -PathType Leaf)) {
  Add-Failure 'Missing root README.md.'
}

$rootContributing = Join-Path $Root 'CONTRIBUTING.md'
if (-not (Test-Path -LiteralPath $rootContributing -PathType Leaf)) {
  Add-Failure 'Missing root CONTRIBUTING.md.'
}

$rootReadmeContent = if (Test-Path -LiteralPath $rootReadme -PathType Leaf) {
  Get-Content -LiteralPath $rootReadme -Raw -Encoding utf8
} else {
  ''
}

if ($rootReadmeContent -notmatch [regex]::Escape('CONTRIBUTING.md')) {
  Add-Failure 'Root README does not link CONTRIBUTING.md.'
}

$projectSectionMatch = [regex]::Match(
  $rootReadmeContent,
  '(?s)<!-- project-index:start -->(?<body>.*?)<!-- project-index:end -->'
)
$projectIndexContent = if ($projectSectionMatch.Success) {
  $projectSectionMatch.Groups['body'].Value
} else {
  Add-Failure 'Root README is missing project index markers.'
  ''
}

$projectIndexTargets = @(
  [regex]::Matches($projectIndexContent, '\[[^\]]+\]\((?<target>[^)]+)\)') |
    ForEach-Object {
      $target = $_.Groups['target'].Value.Trim().Trim('<', '>')
      $pathPart = ($target -split '#', 2)[0]
      $pathPart = ($pathPart -split '\?', 2)[0]
      if (-not [string]::IsNullOrWhiteSpace($pathPart)) {
        ([System.Uri]::UnescapeDataString($pathPart) -replace '\\', '/') -replace '^\./', ''
      }
    }
)

$requiredShared = @(
  '_workspace-docs/README.md',
  '_workspace-docs/decisions.md',
  '_workspace-docs/topic-brainstorming.md',
  '_workspace-docs/prd-writing.md',
  '_workspace-docs/templates/docs.md',
  '_workspace-docs/templates/topic-brainstorm.md',
  '_workspace-docs/templates/prd.md',
  '_workspace-docs/templates/feature-spec.md',
  '_workspace-docs/templates/architecture.md',
  '_workspace-docs/templates/backend.md',
  '_workspace-docs/templates/data-model.md',
  '_workspace-docs/templates/api.md'
)

foreach ($path in $requiredShared) {
  $full = Join-Path $Root $path
  if (-not (Test-Path -LiteralPath $full -PathType Leaf)) {
    Add-Failure "Missing shared docs file: $path"
  }
}

$topLevelDirs = Get-ChildItem -LiteralPath $Root -Force -Directory |
  Where-Object { -not $_.Name.StartsWith('.') }

$projectDirs = $topLevelDirs | Where-Object {
  $projectReadmeLink = "$($_.Name)/README.md"
  $hasIndexEntry = $projectIndexTargets -contains $projectReadmeLink
  $hasPrd = Test-Path -LiteralPath (Join-Path $_.FullName 'docs/prd.md') -PathType Leaf
  $hasIndexEntry -or $hasPrd
}

foreach ($project in $projectDirs) {
  $projectReadme = Join-Path $project.FullName 'README.md'
  $docsReadme = Join-Path $project.FullName 'docs/README.md'
  $prdDoc = Join-Path $project.FullName 'docs/prd.md'

  if (-not (Test-Path -LiteralPath $projectReadme -PathType Leaf)) {
    Add-Failure "Project is missing README.md: $($project.Name)"
  }

  if (-not (Test-Path -LiteralPath $docsReadme -PathType Leaf)) {
    Add-Failure "Project is missing docs/README.md: $($project.Name)"
  }

  if (-not (Test-Path -LiteralPath $prdDoc -PathType Leaf)) {
    Add-Failure "Project is missing docs/prd.md: $($project.Name)"
  }

  if ($projectIndexTargets -notcontains "$($project.Name)/README.md") {
    Add-Failure "Root README does not link project README: $($project.Name)"
  }

  if (Test-Path -LiteralPath $projectReadme -PathType Leaf) {
    $projectReadmeContent = Get-Content -LiteralPath $projectReadme -Raw -Encoding utf8
    if ($projectReadmeContent -notmatch [regex]::Escape('docs/README.md')) {
      Add-Failure "Project README does not reference docs/README.md: $($project.Name)"
    }
    if ($projectReadmeContent -notmatch [regex]::Escape('docs/prd.md')) {
      Add-Failure "Project README does not reference docs/prd.md: $($project.Name)"
    }
  }

  $legacyProjectDirs = @(
    (Join-Path $project.FullName 'prd'),
    (Join-Path $project.FullName 'document'),
    (Join-Path $project.FullName 'documentation')
  )
  foreach ($legacy in $legacyProjectDirs) {
    if (Test-Path -LiteralPath $legacy -PathType Container) {
      Add-Failure "Legacy top-level project docs directory is not allowed: $(Relative-Path $legacy)"
    }
  }
}

$markdownPaths = @(& git -C $Root -c core.quotepath=false ls-files --cached --others --exclude-standard -- '*.md')
if ($LASTEXITCODE -ne 0) {
  Add-Failure 'Unable to enumerate repository Markdown files with Git.'
  $markdownPaths = @()
}

$markdownFiles = $markdownPaths |
  Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
  ForEach-Object { Join-Path $Root $_ } |
  Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } |
  ForEach-Object { Get-Item -LiteralPath $_ } |
  Where-Object { $_.Name -notin @('AGENTS.md', 'AGENTS.override.md') }

foreach ($file in $markdownFiles) {
  $content = Get-Content -LiteralPath $file.FullName -Raw -Encoding utf8

  if ($content -match '(?<![A-Za-z0-9])(?:[A-Za-z]:\\|/Users/|/home/)') {
    Add-Failure "Absolute user filesystem path is not portable: $(Relative-Path $file.FullName)"
  }

  $matches = [regex]::Matches($content, '\[[^\]]+\]\((?<target>[^)]+)\)')

  foreach ($match in $matches) {
    $target = $match.Groups['target'].Value.Trim().Trim('<', '>')
    if ($target -match '^(https?://|mailto:|app://|#)') {
      continue
    }

    $pathPart = ($target -split '#', 2)[0]
    $pathPart = ($pathPart -split '\?', 2)[0]
    if ([string]::IsNullOrWhiteSpace($pathPart)) {
      continue
    }

    $decodedPath = [System.Uri]::UnescapeDataString($pathPart)
    if ([System.IO.Path]::IsPathRooted($decodedPath)) {
      Add-Failure "Absolute Markdown link is not portable in $(Relative-Path $file.FullName): $target"
      continue
    }

    $resolvedTarget = Join-Path $file.DirectoryName $decodedPath

    if (-not (Test-Path -LiteralPath $resolvedTarget)) {
      Add-Failure "Broken relative Markdown link in $(Relative-Path $file.FullName): $target"
    }
  }
}

if ($failures.Count -gt 0) {
  Write-Host 'Workspace validation failed:' -ForegroundColor Red
  foreach ($failure in $failures) {
    Write-Host " - $failure" -ForegroundColor Red
  }
  exit 1
}

Write-Host 'Workspace validation passed.' -ForegroundColor Green
