#!/bin/bash
# Script para obtener el uso de CPU (segunda iteración de top para precisión)
LC_NUMERIC=C top -bn2 | grep "Cpu(s)" | tail -n 1 | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'
