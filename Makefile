.PHONY: image
image:
	docker build --progress=plain -t go2one:local .

.PHONY: push
push: image
	docker tag go2one:local leoluz/go2one:latest
	docker push leoluz/go2one:latest
