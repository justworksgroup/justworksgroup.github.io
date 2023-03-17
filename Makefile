NAME=$(shell sed 's/[\", ]//g' package.json | grep name | cut -d: -f2 | head -1)
DESC=$(shell sed 's/[\",]//g' package.json | grep description | cut -d: -f2 | sed -e 's/^[ \t]*//')
VERSION=$(shell sed 's/[\", ]//g' package.json | grep version | cut -d: -f2)
STDOUT=> /dev/null 2>&1

build: .clear
	@echo "Building frontend..."
	@rm -Rf build && mkdir build
	@[ -f src/css/main.css ] || npm run build ${STDOUT}
	@cp -Rf src/* build
	@[ -d dist ] || mkdir dist
	@cp -Rf Dockerfile build dist
	@rm -f dist/${NAME}-${VERSION}.zip
	@cd dist && zip -r ${NAME}-${VERSION}.zip Dockerfile build ${STDOUT}
	@cd dist && rm -Rf Dockerfile build
	@echo "Finished!"

install: .clear
	@npm install
	@[ -d src/css ] || mkdir src/css

server: .clear
	@npm run watch

clean:
	@rm -Rf build dist *.log src/css/main.css

reset: .clear clean
	@rm -Rf node_modules package-lock.json yarn.lock test.js .data .dockerdata

.clear:
	@clear

help: .clear
	@echo "${DESC} (${NAME} - ${VERSION})"
	@echo "Uso: make [options]"
	@echo ""
	@echo "  build (default)    Build para deploy"
	@echo "  install            Instala as dependências"
	@echo "  server             Roda o projeto"
	@echo ""
	@echo "  clean              Apaga arquivos de build e temporários"
	@echo "  reset              Apaga o build e retorna o projeto ao estado original"
	@echo ""
	@echo "  help               Exibe esta mensagem de HELP"
	@echo ""

.PHONY: build dist
