FROM ghcr.io/playdate-projects/playdate-docker:main

VOLUME /source

WORKDIR /home/playdate-sdk

RUN ls /source

ENTRYPOINT ["pdc", "/source", "ninelives.pdx"]
