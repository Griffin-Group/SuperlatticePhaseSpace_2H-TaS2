
####################################################
# setup dos
####################################################
setup_dos () {
	mv calctype.default/ sp
	cd sp
	if [ ! -f job.out ]; then
	    cat slurm* > job.out
	fi
	rm slurm*
	rm XDATCAR REPORT PROCAR PCDAT OSZICAR EIGENVAL IBZKPT CHG CONTCAR sumo-dosplot.log
	rm *dos* DOSCAR
	cd ..
	mkdir dos
	cd dos
	cp ../sp/POSCAR ../sp/POTCAR ../sp/KPOINTS ../sp/CHGCAR ../sp/WAVECAR .
	cp ../../../INCAR_DOS INCAR
	cp ~/ExampleFiles/dirac1job.sh job.sh
	sbatch job.sh
	cd ..
}

####################################################
# cleanup dos, make and submit bader-lm-decomp
####################################################
setup_bader_lm () {
	cd dos
	rm CHG CONTCAR EIGENVAL IBZKPT OSZICAR PCDAT REPORT XDATCAR PROCAR
        if [ ! -f job.out ]; then
	    mv slurm* job.out
	fi
	mkdir ../bader-lm-decomp
	cp CHGCAR KPOINTS POSCAR POTCAR WAVECAR job.sh ../bader-lm-decomp
	cd ../bader-lm-decomp
	cp ../../../INCAR_BADER_RWIG_PROJECT INCAR
	sbatch job.sh 
	cd ..
}

####################################################
# cleanup bader-lm-decomp
####################################################
cleanup_bader_lm () {
        cd bader-lm-decomp
        if [ ! -f job.out ]; then
	    mv slurm* job.out
        fi
	rm CHG* CONT* DOS* EIGENVAL IBZKPT KPOINTS OSZICAR PCDAT REPORT WAVECAR XDATCAR
	rm job.sh POTCAR POSCAR
	cd ..
}

for i in $(ls -d */)
do 
        cd $i

	if [ ! -d dos ]; then
	    echo "would in run setup_dos ${i}"
	    #echo "running setup_dos in ${i}"
	    #setup_dos
	else
	    if [ ! -f dos/*.out ]; then
		echo "would in submit in ${i}"
	    fi
	fi

	if [ ! -d bader-lm-decomp ]; then
	    if [ -f dos/vasprun.xml ]; then
		echo "would in run setup_bader_lm ${i}"
#		echo "running setup_bader_lm in ${i}"
#		setup_bader_lm
	    fi
	fi

	if [ -f bader-lm-decomp/OUTCAR ]; then
	    if [ ! -f bader-lm-decomp/job.out ]; then
		echo "would in run cleanup_bader_lm ${i}"
#		echo "running cleanup_bader_lm in ${i}"                                                                         
#               cleanup_bader_lm
	    fi
	fi

	cd ..

done
