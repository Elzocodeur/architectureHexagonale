# Image Node
FROM node:18-alpine

# Dossier de travail
WORKDIR /app

# Copier package.json
COPY package*.json ./

# Installer dépendances
RUN npm install

# Copier le reste du code
COPY . .

# Build NestJS
RUN npm run build

# Exposer port
EXPOSE 3000

# Lancer l'application
CMD ["node", "dist/main.js"]
