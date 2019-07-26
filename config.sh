#!/bin/bash

export SRC_DIR=/usr/local/src/a2billing
export DB_NAME=cia2b
export DB_USER=billing
export DB_PASS=$(./passgen.py)

SED=/bin/sed
MYSQL=/usr/bin/mysql



