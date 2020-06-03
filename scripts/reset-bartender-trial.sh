#!/bin/bash
defaults write com.surteesstudios.Bartender trialStart3 -date "$(date -v -1d +"%Y-%m-%d %I:%M:%S %z")"
