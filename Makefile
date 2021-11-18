.PHONY: image
image:
	docker build --progress=plain -t go2one:debian .
