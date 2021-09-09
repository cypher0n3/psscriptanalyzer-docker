FROM mcr.microsoft.com/powershell:latest


RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN pwsh -c "Install-Module PSScriptAnalyzer -Force"

ENTRYPOINT ["pwsh", "-command"]
