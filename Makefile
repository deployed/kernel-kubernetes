PHONY: build push

build:
	docker build --target django -t <your-docker-image>:latest .
	docker build --target webserver -t <your-docker-image>:latest .

push:
	docker push <your-docker-image>:latest
	docker push <your-docker-image>:latest
