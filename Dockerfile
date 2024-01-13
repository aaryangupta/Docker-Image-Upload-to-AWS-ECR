FROM golang:1.17-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod tidy

COPY *.go ./

RUN go build -o /DockerImageUploadtoAWSECR

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /DockerImageUploadtoAWSECR /DockerImageUploadtoAWS-ECR

USER nonroot:nonroot

ENTRYPOINT ["/DockerImageUploadtoAWSECR"]
