#!/usr/bin/env bash

#xkb-switch
echo $(xkb-switch) | tr 'a-z' 'A-Z'
