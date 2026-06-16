#!/bin/bash
# Uso de disco en /
df -h / | awk 'NR==2 {print $5}' | sed 's/%//'
