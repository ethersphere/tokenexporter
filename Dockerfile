FROM golang:1.15 AS build

WORKDIR /src
# enable modules caching in separate layer
COPY go.mod go.sum ./
RUN go mod download

COPY . ./

RUN go build -trimpath -ldflags "-s -w" -o dist/tokenexporter ./tokenexporter

FROM debian:10.2-slim AS runtime

ENV PORT 9891
ENV DATA /app

RUN mkdir -p /app && chown nobody:nogroup /app

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
        ca-certificates; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*;

COPY --from=build /src/dist/tokenexporter /usr/local/bin/tokenexporter
COPY data/addresses.txt /app/addresses.txt
COPY data/tokens.json /app/tokens.json

USER nobody
VOLUME /app
WORKDIR /app

ENTRYPOINT ["tokenexporter"]
