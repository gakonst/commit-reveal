#!/bin/bash

node_modules/.bin/ganache-cli \
    -i 15 -b 15 --gasLimit 50000000 \
	> /dev/null &
