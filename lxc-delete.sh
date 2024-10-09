#!/bin/bash

# Get the list of container names
containers=$(lxc ls | grep -v '+-' | grep -v '| NAME ' | awk 'NR>1 && NF && $2 != "|" {print $2}')

# Check if there are containers to delete
if [ -n "$containers" ]; then
    echo "Deleting containers:"
    echo "$containers"

    # Loop through each container and delete it
    while read -r container; do
        lxc delete -f "$container"
    done <<< "$containers"

    echo "All containers deleted."
else
    echo "No containers found to delete."
fi
