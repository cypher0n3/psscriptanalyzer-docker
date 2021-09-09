FROM mcr.microsoft.com/powershell:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN pwsh -c "Install-Module PSScriptAnalyzer -Force"

# Removing symlink of /bin/sh to /bin/dash since dash breaks on pipefails
RUN rm -f /bin/sh && \
    ln -s /bin/bash /bin/sh

ENTRYPOINT [ "pwsh", "-command" ]
CMD [ "Write-Output 'See README: https://gitlab.com/cypher_zero/psscriptanalyzer-docker'" ]
