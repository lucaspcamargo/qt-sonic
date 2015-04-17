#!/bin/bash
find -iname \*.png assets | while read line; do pngcrush -ow -brute $line; done
