run:
	sudo docker-compose up --build

start:
	sudo docker-compose up -d

compile-logger:
	go build logger.go

build:
	sudo docker-compose build

deploye: compile-logger build start

logs:
	sudo docker-compose logs -f
