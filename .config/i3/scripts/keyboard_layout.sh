#!/usr/bin/env bash
# Depends on xkb-switch

echo $(xkb-switch) | tr 'a-z' 'A-Z'
