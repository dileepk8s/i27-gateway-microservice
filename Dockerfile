FROM node:18-alpine

# Create non-root user
RUN addgroup -S app && adduser -S app -G app

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN if [ -f package-lock.json ]; then npm ci --omit=dev; else npm install --production; fi

# Copy source
COPY . .

# Set ownership
RUN chown -R app:app /app
USER app

EXPOSE 8080

# Use start script from package.json
CMD ["npm", "start"]