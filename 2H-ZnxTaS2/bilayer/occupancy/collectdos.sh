

for f in $(ls -d SCEL*/*/calc*); do
    cd $f;  
    sumo-dosplot --no-total --elements S.p,Ta.d,Zn --format svg --config /global/scratch/users/craigi/jobs/ZnSc-interc-TaS2/2H-ZnxTaS2/bilayer/occupancy/SCEL1_1_1_1_0_0_0/0/calctype.default/colors.conf;
    IFS='/' read -r -a linesplit <<< $f;
    p1=${linesplit[-2]};
    p2=${linesplit[-3]};
    echo "save to all_dos/${p1}_${p2}.svg"
    cp dos.svg "/global/scratch/users/craigi/jobs/ZnSc-interc-TaS2/2H-ZnxTaS2/bilayer/occupancy/all_dos/${p1}_${p2}.svg"
    cd /global/scratch/users/craigi/jobs/ZnSc-interc-TaS2/2H-ZnxTaS2/bilayer/occupancy; 
done


