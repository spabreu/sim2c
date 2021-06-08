IMAGES=$(shell ls -1 */Dockerfile | sed -e s:/Dockerfile::)
COPY=sim2c_1.0-3_all.deb

DATA=data
WORKDIR=/root
HUBU=rodalvas

all: cplint

.PHONY: prolog logtalk cplint clean sim2c

prolog:
	docker build $@ --tag $@:latest
	docker tag $@:latest $(HUBU)/$@:latest

sim2c: 
	cp $(COPY) $@/sim2c.deb
	docker build $@ --tag $@:latest
	docker tag $@:latest $(HUBU)/$@:latest


run-%::
	docker run -ti \
		-v $(PWD)/$(DATA):$(WORKDIR)/$(DATA) \
		$(subst run-,,$@):latest

logtalk.deb::
	[ -e $(LGTDEB) ] || wget -q https://logtalk.org/files/$(LGTDEB)
	ln -sf $(LGTDEB) logtalk.deb

clean:
	rm -f $(DATA)/*
	docker container prune -f
	docker image prune -f
	docker image rm -f $(IMAGES)
