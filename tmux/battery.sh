#!/bin/bash
pmset -g batt 2>/dev/null | grep -oE '[0-9]+%' | head -1
