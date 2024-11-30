# TODO

Things that need some attention if this is picked up again:
- Physics object attachments and boundaries are a bit wonky, because the full transforms withing the
  object Item hierarchy are not fully taken into account.
    - Also related, there is no comfortable way to spawn child objects that are separate from the originator (e.g. projectiles).
- A property editor pane for objects.
- Make sure layers and layer switching are still working good.
- There are no facilities to properly store the intermediate state of the world, in the case of checkpoints and whatnot.
- There is no system of progression or level end conditions, some of these basic systems are missing still.
- Sometimes, weird behavior and crashes have been observed on the latest attempts to run the game, eg. when coming out of drowning a second time.
- Make a proper test level with various mechanics
