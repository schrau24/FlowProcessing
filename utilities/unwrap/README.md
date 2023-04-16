# 4D Laplacian unwrapping for 4D Flow MRI Demo

## About

This Matlab code accompanies the manuscript: "Phase Unwrapping in 4D MR Flow with a 4 Dimensional Single Step Laplacian Algorithm"

The code presented here allows the user to reproduce the results from the digital phantom experiment.

## Installation

This software is written entirely in Matlab, so no installation is necessary

## How to Use
The two main scripts are 'test_single.m' and 'test_full.m'

test_full.m: This is the script used in the manuscript, which runs multiple trials of multiple venc and SNR settings, so it can take a VERY long time.  If you just want to see a quick demo, use:

test_single.m:  Runs unwrapping and displays results for a single venc-SNR combo
