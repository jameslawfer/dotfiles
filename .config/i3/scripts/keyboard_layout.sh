#!/usr/bin/env bash
# Depends on xkb-switch

echo $(xkb-switch -p) | tr 'a-z' 'A-Z'
