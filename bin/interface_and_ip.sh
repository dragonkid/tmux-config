ip a | grep global | awk '{print $2"("$7")"}' | tr '\n' ' '
