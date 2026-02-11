#alvo: dependencia1 dependencia2
#	comando que gera o alvo a partir das dependencias

.PHONY: clean all

all: figuras/taxas_variacao.png

data/temperature-data.zip: code/baixar.py
	python code/baixar.py

results/npaises.txt: data/temperature-data.zip code/contapai.sh
	mkdir -p results
	bash code/contapai.sh > results/npaises.txt

results/variacao_temperature.csv: data/temperature-data.zip code/variacao_temperatura.py 
	mkdir -p results
	python code/variacao_temperatura.py > results/variacao_temperature.csv

figuras/taxas_variacao.png: code/plota_dados.py results/variacao_temperature.csv
	mkdir -p figuras
	python code/plota_dados.py > figuras/taxas_variacao.png

clean: 
	rm -r data results figuras
