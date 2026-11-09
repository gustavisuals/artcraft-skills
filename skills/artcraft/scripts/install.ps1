<#
.SYNOPSIS
  Installs or updates the ArtCraft suite apps (storytold/*) from the portable GitHub zips.
.EXAMPLE
  ./install.ps1                                # all apps + launcher
  ./install.ps1 -Apps photocraft,effectcraft   # only these
  ./install.ps1 -Dest D:\Apps\ArtCraft -Arch arm64
.NOTES
  Does not use the GitHub API (no 60 req/h limit): reads the version from the /releases/latest redirect,
  verifies each zip against the release SHA256SUMS.txt and skips apps already on the latest version.
#>
param(
  [string[]]$Apps = @('craft-launcher','photocraft','vectorcraft','filmcraft','lightcraft','pdfcraft','effectcraft',
                      'designcraft','figcraft','texturecraft','materialcraft','wordcraft','soundcraft','deckcraft',
                      'cadcraft','gridcraft','craft-anything'),
  [string]$Dest = $(if ($env:ARTCRAFT_HOME) { $env:ARTCRAFT_HOME } else { Join-Path $HOME 'Apps\ArtCraft' }),
  [ValidateSet('x64','arm64')][string]$Arch = 'x64',
  [switch]$KeepZips
)
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$Apps = $Apps -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ }
$ua = @{ 'User-Agent' = 'artcraft-skills-installer' }
$dl = Join-Path $Dest '_downloads'
New-Item -ItemType Directory -Force $dl | Out-Null

function Get-LatestTag([string]$repo) {
  $req = [Net.HttpWebRequest]::Create("https://github.com/storytold/$repo/releases/latest")
  $req.AllowAutoRedirect = $false; $req.UserAgent = $ua['User-Agent']; $req.Method = 'HEAD'
  $res = $req.GetResponse(); $loc = $res.Headers['Location']; $res.Close()
  if (-not $loc) { throw "no published release" }
  return ($loc -split '/tag/')[-1]
}

foreach ($r in $Apps) {
  try {
    $tag = Get-LatestTag $r; $v = $tag.TrimStart('v')
    $prefix = if ($r -eq 'craft-launcher') { 'artcraft-launcher' } else { $r }
    $name = "$prefix-$v-windows-$Arch-portable.zip"
    $folder = Join-Path $Dest $r
    $vf = Join-Path $folder '.version'
    if ((Test-Path $vf) -and ((Get-Content $vf -Raw).Trim() -eq $tag)) { "= $r $tag already installed"; continue }
    $rel = "https://github.com/storytold/$r/releases/download/$tag"
    $zip = Join-Path $dl $name
    Invoke-WebRequest -UseBasicParsing -Headers $ua "$rel/$name" -OutFile $zip
    $sums = (Invoke-WebRequest -UseBasicParsing -Headers $ua "$rel/SHA256SUMS.txt").Content
    if ($sums -is [byte[]]) { $sums = [Text.Encoding]::UTF8.GetString($sums) }
    $exp = ($sums -split "`n" | Where-Object { $_ -match [regex]::Escape($name) } | Select-Object -First 1) -split '\s+' | Select-Object -First 1
    $got = (Get-FileHash $zip -Algorithm SHA256).Hash.ToLower()
    if (-not $exp -or $exp.ToLower() -ne $got) { Remove-Item $zip; throw "SHA256 mismatch" }
    if (Test-Path $folder) { Remove-Item -Recurse -Force $folder }
    Expand-Archive $zip $folder -Force
    Set-Content -Path $vf -Value $tag -Encoding ascii
    if (-not $KeepZips) { Remove-Item $zip }
    "+ $r $tag installed"
  } catch { "! $r failed: $($_.Exception.Message)" }
}
"Folder: $Dest"
