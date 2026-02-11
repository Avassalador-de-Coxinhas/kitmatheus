#alvo: dependencia1 dependencia2
#	comando que gera o alvo a partir das dependencias

data/temperature-data.zip: code/baixar.py
	python code/baixar.py

results/npaises.txt: data/temperature-data.zip code/contapai.sh
	mkdir -p results
	bash code/contapai.sh > results/npaises.txt

clean: 
	rm -r data results
