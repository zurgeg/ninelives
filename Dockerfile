FROM ghcr.io/playdate-projects/playdate-docker:main

VOLUME ["/source"]

WORKDIR /home/playdate-sdk

ENTRYPOINT ["pdc", "/source", "ninelives.pdx"]
