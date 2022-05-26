FROM ghcr.io/playdate-projects/playdate-docker:main

WORKDIR /home/playdate-sdk

ENTRYPOINT ["ls /source", "&&", "pdc", "/source", "ninelives.pdx"]
