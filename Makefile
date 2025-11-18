.PHONY: prereqs requirements build migrations start stop

SHELL := /bin/bash
include .env

prereqs:
	sudo apt install nodejs npm default-mysql-server
	sudo mariadb-secure-installation
	sudo systemctl enable mariadb.service
	sudo npm install -g pm2

requirements:
	npm install

build:
	npm run build

migrations:
	mkdir -p migrations && npm run migrate

start:
	pm2 start out/src/index.js --name wallet-infra

stop:
	pm2 stop wallet-infra
