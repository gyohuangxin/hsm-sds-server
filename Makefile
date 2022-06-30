BINARY=sds-server
GOBIN=$(GOPATH)/bin
OUT=${GOBIN}/${BINARY}
TAG=latest
HUB=sds-server

all: build test

build:
	go build -o ${OUT} main.go 
test:
	go test -v main.go
run:
	go build -o ${OUT} main.go
	./${OUT}
clean:
	go clean
	rm ${OUT}
# Please make sure that user has enough privilege to execute docker command
docker: 
	go build -o ${BINARY} main.go
	docker build -t ${HUB}/${BINARY}:${TAG} .
	rm ${BINARY}

docker-client:
	docker build -f deployment/Dockerfile .

checkENV:
ifndef HUB
  $(error Environment Variable HUB is not set)
endif
ifndef TAG
  $(error Environment Variable TAG is not set)
endif
ifndef GOPATH
  $(error Environment Variable GOPATH is not set)
endif
