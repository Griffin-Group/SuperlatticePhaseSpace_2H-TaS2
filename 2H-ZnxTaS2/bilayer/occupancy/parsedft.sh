LOGFILE="dftparse-verbose.out"
LOGSMALL="dftparse-min.out"
rm $LOGFILE
rm $LOGSMALL
echo 'file    nTa    nInt    x   energy   |<m>|   <|m|>' >> $LOGFILE
for i in $(ls -d SC*/*/calctype*); do
    FILE=$i/OUTCAR
    if test -f "$FILE"; then
	IFS=' ' read -r -a linesplit <<< $(head $i/POSCAR -n 7 | tail -n 1)
	nInt=${linesplit[2]}
	nS=${linesplit[1]}
	nTa=${linesplit[0]}
	x=$(awk "BEGIN {print $nInt/$nTa; exit}")
	echo '***********************************************************'
	echo 'on file:'$i
	echo 'number of interc:'$nInt
	echo 'number of Ta:'$nTa
	echo 'number of S:'$nS
	echo 'interc density (#int/#Ta):'$x
	IFS=' ' read -r -a esplit <<< $(grep "free  energy   TOTEN" $i/OUTCAR)
	echo "energy: ${esplit[4]}"
	ENERGY=${esplit[4]}
	echo "${FILE}  ${nTa}  ${nInt}  ${x}   ${ENERGY}  " >> $LOGFILE
	echo "${nTa} ${x} ${ENERGY}" >> $LOGSMALL
    fi
done

