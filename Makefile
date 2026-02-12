#alvo: dependencia1 dependencia2
#	comando que gera o alvo a partir das dependencias

.PHONY: clean all show

all: paper/paper.pdf

show: paper/paper.pdf
	start paper/paper.pdf

data/temperature-data.zip: code/baixar.py
	python code/baixar.py

paper/variaveis/npaises.tex: data/temperature-data.zip code/contapai.sh
	mkdir -p paper/variaveis
	echo "\newcommand{\NPaises}{'bash code/contapai.sh'}" > paper/variaveis/npaises.tex

results/variacao_temperature.csv: data/temperature-data.zip code/variacao_temperatura.py 
	mkdir -p results
	python code/variacao_temperatura.py > results/variacao_temperature.csv

figuras/taxas_variacao.png: code/plota_dados.py results/variacao_temperature.csv
	mkdir -p figuras
	python code/plota_dados.py > figuras/taxas_variacao.png

paper/paper.pdf: paper/paper.tex figuras/taxas_variacao.png 
	tectonic -X compile paper/paper.tex

clean:
	rm -r data results figuras paper/paper.pdf paper/variaveis
