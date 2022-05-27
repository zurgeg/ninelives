@echo off
del /S /Q ninelives
mkdir ninelives
pdc . ninelives/ninelives.pdx -k
PlaydateSimulator ninelives/ninelives.pdx