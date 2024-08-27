#!/bin/bash

source ./jupyterlab-env/bin/activate
jupyter labextension list
jupyter lab --ip="0.0.0"
