FROM golang:1.17-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
COPY *.go ./

#RUN go mod tidy


RUN go build -o /Docker-Image-Upload-to-AWS-ECR

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /Docker-Image-Upload-to-AWS-ECR /Docker-Image-Upload-to-AWS-ECR

USER nonroot:nonroot

ENTRYPOINT ["/Docker-Image-Upload-to-AWS-ECR"]
