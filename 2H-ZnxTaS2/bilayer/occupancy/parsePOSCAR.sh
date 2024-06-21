
INT='Zn'
LOG='dftparse-occ.out'
rm $LOG
for file in $(ls SCEL*/*/calctype.default/POSCAR); do 
    PARSE=$(grep "    $INT" $file)
    echo $file >> $LOG
    IFS="$INT" read -r -a split <<< $PARSE
    for i in "${split[@]}"; do
        IFS=" " read -r -a split2 <<< $i
        arraylength=${#split2[@]}
        if [ $arraylength -ge 2 ]; then
	    echo "${split2[0]}" "${split2[1]}" >> $LOG
	fi
    done
done
