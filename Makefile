build:
	docker build --no-cache -t gb .

run:
	mkdir -p work
	docker run --rm -it -p 8080:8080 -v "${PWD}/work:/root" gb

publish:
	docker tag gb konsumer/gb:latest
	docker push konsumer/gb:latest