#!/bin/sh

pdflatex --interaction=nonstopmode $1 > /dev/null 2>&1
rubber --clean $1 
