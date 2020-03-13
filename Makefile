build:
	docker build --no-cache -t gb .

run:
	mkdir -p work
	docker run --name='gb' --rm -it -p 8080:8080 -v "${PWD}/work:/home/gbdev" gb

publish:
	docker tag gb konsumer/gb:latest
	docker push konsumer/gb:latest