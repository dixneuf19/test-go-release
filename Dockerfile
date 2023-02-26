FROM golang:1.19 AS build

ARG VERSION
ARG COMMIT_HASH
ARG BUILD_TIMESTAMP

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -ldflags="\
          -X main.Version=${VERSION} \
          -X main.CommitHash=${COMMIT_HASH} \
          -X main.BuildTimestamp=${BUILD_TIMESTAMP}" \
        -o /test-ga

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /test-ga /test-ga

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/test-ga"]
