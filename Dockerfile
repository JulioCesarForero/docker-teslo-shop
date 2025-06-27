FROM node:20-alpine AS dev
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --network-timeout 300000
CMD [ "yarn","start:dev" ]



FROM node:20-alpine AS dev-deps
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --network-timeout 300000


FROM node:20-alpine AS builder
WORKDIR /app
COPY --from=dev-deps /app/node_modules ./node_modules
COPY . .
# RUN yarn test
RUN yarn build

FROM node:20-alpine AS prod-deps
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --prod --frozen-lockfile --network-timeout 300000


FROM node:20-alpine AS prod
EXPOSE 3000
WORKDIR /app
# ENV APP_VERSION=${APP_VERSION}
COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

CMD [ "node","dist/main.js"]









