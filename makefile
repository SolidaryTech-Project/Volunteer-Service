# Instala as dependências locais de desenvolvimento (Python service)
pre-commit:
# Instala o pre-commit
	sudo apt update
	sudo apt install -y pre-commit
# Ativa os hooks no repositório
	pre-commit install
# Obs: o Ruff e os hooks básicos sao baixados automaticamente
# pelo pre-commit no primeiro run (ambiente isolado, nao precisa instalar).
