#!/bin/bash
# Usando vmstat que es mas confiable para promedios rapidos
usage=$(vmstat 1 2 | tail -n1 | awk '{print 100 - $15}')
echo "$usage"
