FROM ghcr.io/playdate-projects/playdate-docker:main

VOLUME /source

WORKDIR /home/playdate-sdk

ENTRYPOINT ["ls /source", "&&", "pdc", "/source", "ninelives.pdx"]
