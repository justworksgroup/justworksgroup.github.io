NAME=$(shell sed 's/[\", ]//g' package.json | grep name | cut -d: -f2 | head -1)
DESC=$(shell sed 's/[\",]//g' package.json | grep description | cut -d: -f2 | sed -e 's/^[ \t]*//')
VERSION=$(shell sed 's/[\", ]//g' package.json | grep version | cut -d: -f2)
STDOUT=> /dev/null 2>&1
JEKYLL=bundle exec jekyll

build: .clear .install
	@$(JEKYLL) build
	@npm run build

install: .clear
	@npm install

server: .clear .install
	@npx concurrently "$(JEKYLL) serve --livereload --drafts" "npm run watch"

clean:
	@rm -Rf build dist _site assets/css .jekyll-cache *.log

reset: .clear clean
	@rm -Rf node_modules package-lock.json yarn.lock Gemfile.lock .data .dockerdata

.clear:
	@clear

.install:
	@[ -d node_modules ] || make install

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

.PHONY: build dist _site
