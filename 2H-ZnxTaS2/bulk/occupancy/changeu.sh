for i in $(ls -d */calc*) 
do
    # echo $i; 
    cd $i;
    # pwd; 
    mv INCAR INCAR_old
    sed 's/LDAUU = 0.0 0.0 3.0/LDAU = 0.0 0.0 2.0/' INCAR_old > INCAR
    # rm INCAR_old
    cd ../..;
done
