# Makefile
DOCKER_COMPOSE_VERSION_CHECKER := $(shell docker compose > /dev/null 2>&1 ; echo $$?)
ifeq ($(DOCKER_COMPOSE_VERSION_CHECKER), 0)
DOCKER_COMPOSE_IMPL=docker compose
else
DOCKER_COMPOSE_IMPL=docker-compose
endif

.PHONY: init
init:
	${MAKE} build
	${MAKE} up
	${MAKE} open

.PHONY: build
build:
	${DOCKER_COMPOSE_IMPL} build

.PHONY: up
up:
	${DOCKER_COMPOSE_IMPL} up -d

.PHONY: start
start:
	${DOCKER_COMPOSE_IMPL} start

.PHONY: stop
stop:
	@echo "このコマンドは登録されていません。"
	@echo "あなたが本当に使いたいのはもしかして make stop/d ですか？"
	@echo "安全性の観点から /d を付けて実行してください。"

.PHONY: stop/d
stop/d:
	${DOCKER_COMPOSE_IMPL} stop

.PHONY: restart
restart:
	${MAKE} stop/d
	${MAKE} start

.PHONY: down
down:
	@echo "このコマンドは登録されていません。"
	@echo "あなたが本当に使いたいのはもしかして make down/d ですか？"
	@echo "安全性の観点から /d を付けて実行してください。"

.PHONY: down/d
down/d:
	${DOCKER_COMPOSE_IMPL} down

.PHONY: down/d/all
down/d/all:
	${DOCKER_COMPOSE_IMPL} down --rmi all --volumes --remove-orphans

.PHONY: login
login:
	${DOCKER_COMPOSE_IMPL} exec app /bin/sh

.PHONY: logs
logs:
	${DOCKER_COMPOSE_IMPL} logs app

.PHONY: rebuild
rebuild:
	${MAKE} rebuild/app

.PHONY: open
open:
	open http://localhost:9000

.PHONY: bun-add
bun-add:
	docker compose exec app bun add $(filter-out $@,$(MAKECMDGOALS))

.PHONY: bun-install
bun-install:
	docker compose exec app bun install

.PHONY: test
test:
	docker compose exec app bun test