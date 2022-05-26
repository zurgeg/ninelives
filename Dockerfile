FROM ghcr.io/playdate-projects/playdate-docker:main

WORKDIR /home/playdate-sdk

ENTRYPOINT ["ls", "&&", "pdc", "/source", "ninelives.pdx"]
