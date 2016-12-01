ip a | grep global | awk '{print $7": "$2}' | tr '\n' ' '
