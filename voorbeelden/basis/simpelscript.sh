echo "Hallo `whoami`!"
echo "Dit is een simpel script, en vandaag is het de 16e!" # fixme: vervang de 16e met `date +%d`

if [ ! -f "laatstekeer.txt" ]; then
	echo "Dit is de eerste keer dat je dit script draait!"
else
	echo "Dit script is voor het laatst gedraaid op `cat laatstekeer.txt`!"
fi

date -R > laatstekeer.txt
