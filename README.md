# Script della pratica aritmetica per bimbi
Questo script fornisce un semplice test aritmetico incentrato su moltiplicazione e divisione da riga di comando.

Sito dello script (en-EN): [Arithmetic Practice Script for Children](https://linuxconfig.org/children-multiplication-tables-practice-test-with-bash-script-on-linux)

## Uso
**multiplication.sh** - Di default, lo script inizierà il test sulla moltiplicazione con 20 domande. 
Usa l'opzione **-d -q <numero_domande>** per avviare il test con un numero di domande personalizzate.

### Esempi
Test sulla moltiplicazione con 20 domande:
```
$ ./multiplication.sh
```
Test sulla moltiplicazione con 100 domande:
```
$ ./multiplication.sh -q 100
```
Test su divisione con 5 domande:
```
$ ./multiplication.sh -d -q 5
```
