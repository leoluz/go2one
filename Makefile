.PHONY: image
image:
	docker build --progress=plain -t go2one:local .

.PHONY: run
run:
	docker run --rm -it -v$(CURDIR):/home/nvim/work go2one:local
