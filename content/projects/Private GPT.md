---
aliases: 
draft: false
tags:
  - computerscience
  - AI
  - python
title: Private GPT
date: 2024-09-03
updated: 2024-09-03T18:49
---

-------------------------------------------------------------------------------

[Link](https://docs.privategpt.dev/installation/getting-started/installation) to the project. 

This really tested my time and patience. What should have taken me an hour took me closer to a day, but it was extremely worth the time investment. No mind blowing innovation going on, and certainly nothing I haven't seen before, nevertheless gratifying to bring together.

The most frustrating issue was that the configuration for running setting up the llama model in Poetry was either wrong on the tutorial or my machine is weird. Essentially I had to use `poetry install --extras "llms-llama-cpp ui vector-stores-qdrant embeddings-huggingface"` instead of there version (not much different, save embeddings and different llama model). 

I also made a big oopsie and didn't update Pyenv with the latest versions of Python, so I had major roadblocks with packages and unsupported nonsense. I dug myself into a hole so bad I had to reinstall PowerShell. Not sure how I did it, but I ended up screwing around with my execution policies, and had to start over from scratch.

The project of creating a chat-bot based off of my Obsidian Vault is pretty much complete, granted I can fit as many files as I have on there. I haven't tested it yet, but that will come soon. With school starting so soon, I have to shift gears a little bit, but the change is welcome.

