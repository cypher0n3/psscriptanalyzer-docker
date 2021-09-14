# PSScriptAnalyzer-Docker

[![pipeline status](https://gitlab.com/cypher_zero/psscriptanalyzer-docker/badges/master/pipeline.svg)](https://gitlab.com/cypher_zero/psscriptanalyzer-docker/-/commits/master)

A basic docker image based off of [Microsoft's PowerShell image](https://hub.docker.com/r/microsoft/powershell/) which includes [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer)

## Tags

### latest

The latest tag is always the latest, hopefully stable, build.
This tag is updated automatically every Monday based on the latest [PowerShell container](https://hub.docker.com/r/microsoft/powershell/) and stable [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer).

If the pipeline status above indicates a failure, then this image is unstable.

### stable-*

These tags are known stable builds as tested by the developer.
These correspond to the same tag name in the code repository.
Identifying numbers correspond to the date the tag was created.

### Numbered tags

Numbered tags correspond to GitLab CI pipeline IIDs and should be considered development builds.
Use at your own risk.

## Usage

For advanced usage of PSScriptAnalyzer modules (`Invoke-ScriptAnalyzer`) see: <https://github.com/PowerShell/PSScriptAnalyzer>.

This image is automatically updated weekly.

### Analyze a script on your local system

```bash
docker run -v ./test:/test cypher0n3/psscriptanalyzer-docker:latest "Invoke-ScriptAnalyzer -Path /test/*.ps1"
```

### In GitLab pipeline

When running in a GitLab pipeline, you need to override the default entry point and call `pwsh -c Invoke-ScriptAnalyzer` as part of the `script` block.
This is due to the way that GitLab sets up the container, etc.
See below for a working example:

```yaml
psscriptanalyzer:
  image:
    name: registry.gitlab.com/cypher_zero/psscriptanalyzer-docker:latest
    entrypoint: ["/bin/bash", "-c"]
  variables:
    PS1_TESTPATH: ./test/*.ps1
  script:
    - output=$(pwsh -c "Invoke-ScriptAnalyzer -Path $PS1_TESTPATH")
    - echo "${output}"
    - |
      if [[ -n ${output} ]]; then
        echo "Failures detected; see above."
        exit 1
      fi
```

## Contributing

Code and pipeline automation for this project is maintained in GitLab here: <https://gitlab.com/cypher_zero/psscriptanalyzer-docker>

Please submit all issues and merge requests via the above GitLab project.
Submissions and issues from other sources (e.g. GitHub) will *not* be addressed.
