FROM golang:1.19 AS build-stage
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /simple-api-go

FROM build-stage AS run-test-stage
RUN go test -v ./...

FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage /simple-api-go /simple-api-go

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/simple-api-go"]