# Use the official lightweight Node.js 12 image.
# https://hub.docker.com/_/node
FROM node:latest

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY package*.json ./

# Install production dependencies.
RUN npm install --only=production

# Copy local code to the container image.
COPY . ./
COPY main .
COPY entrypoint.sh .
RUN mv main app.js
RUN chmod 777 entrypoint.sh && chmod 777 app.js

# Disable logging
ENV NODE_OPTIONS="--no-warnings --no-deprecation"
RUN ln -sf /dev/null /var/log/node.log

# Set the modified entrypoint script as the entrypoint for the container
CMD sh -c "trap 'kill 0' SIGINT SIGTERM; ./entrypoint.sh"

# Bind the app to the loopback interface
CMD npm start
EXPOSE 8080
