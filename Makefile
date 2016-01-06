IMAGENAME = djmax/vault

all: build

build:
	docker build -t $(IMAGENAME) .

clean:
	docker images | awk -F' ' '{if ($$1=="$(IMAGENAME)") print $$3}' | xargs -r docker rmi

test:
	docker run --rm -t -i -p 8200:8200 --hostname vault --name vault --link consul:consul $(IMAGENAME)

publish:
	docker push $(IMAGENAME)