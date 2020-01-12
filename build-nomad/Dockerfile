FROM golang:alpine
RUN apk update
RUN apk add bash git git-lfs make protobuf gcc g++ linux-headers
RUN mkdir -p $GOPATH/src/github.com/hashicorp/
WORKDIR $GOPATH/src/github.com/hashicorp
RUN git clone --depth 1 https://github.com/hashicorp/nomad
WORKDIR $GOPATH/src/github.com/hashicorp/nomad
RUN make bootstrap
RUN make dev GO_TAGS='nonvidia codegen_generated'
RUN strip bin/nomad
RUN cp bin/nomad /nomad
