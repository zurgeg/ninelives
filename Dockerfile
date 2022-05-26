FROM ghcr.io/playdate-projects/playdate-docker:main

WORKDIR /home/playdate-sdk

ENTRYPOINT ["pdc", "/src", "ninelives.pdx"]
