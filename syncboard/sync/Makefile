init:
	sudo apt update && sudo apt upgrade
	sudo apt install -y docker.io docker-compose

build:
	docker build --no-cache
	
it:
	docker-compose pull

so:
	docker-compose up -d

not:
	docker-compose down