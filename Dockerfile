# backend/Dockerfile
FROM node:18-alpine

WORKDIR /app

# copy package files first to leverage caching
COPY package*.json ./
RUN npm ci --only=production

# copy source
COPY . .

# if you use build step (TypeScript etc) uncomment:
# RUN npm run build

ENV PORT=4040
EXPOSE 4040

CMD ["node", "index.js"]

