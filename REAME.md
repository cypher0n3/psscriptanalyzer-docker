# PSScriptAnalyzer-Docker

A basic docker image based off of [Microsoft's PowerShell image](https://hub.docker.com/r/microsoft/powershell/) which includes [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer)

## Usage

For advanced usage of PSScriptAnalyzer modules (`Invoke-ScriptAnalyzer`) see: <https://github.com/PowerShell/PSScriptAnalyzer>

### Analyze a script on your local system

```bash
docker run -it -v ./test:/test cypher0n3/psscriptanalyzer-docker:latest -Command "Invoke-ScriptAnalyzer -Path /test/MyScript.ps1"; echo
```

### In GitLab pipeline

```yaml
psscriptanalyzer:
  image: cypher0n3/psscriptanalyzer-docker:latest
  variables:
    PS1_TESTPATH: ./test
  allow_failure: true
  script:
    - Invoke-ScriptAnalyzer -Path $PS1_TESTPATH/*.ps1
```
