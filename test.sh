#!/bin/bash

test="Updating cd304f6..ea6fab8 Fast-forward README.md | 1 + 1 file changed, 1 insertion(+)"

if [ "$test" == *"file changed"* ]; then
    echo "Made it here" 
else
    echo "Did not make its"
fi

