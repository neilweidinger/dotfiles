#!/bin/bash

# this sets the trial date to be one day before the current date
defaults write com.surteesstudios.Bartender trialStart3 -date "$(date -v -1d +"%Y-%m-%d %I:%M:%S %z")"
