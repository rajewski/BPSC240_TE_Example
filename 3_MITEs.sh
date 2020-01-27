#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=6G
#SBATCH --time=3-00:00:00
#SBATCH --mail-user=araje002@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH -p batch

#download detectMite and unzip it
if [ ! -d detectMITE/ ];then
    echo Downloading detectMITE...
    wget https://sourceforge.net/projects/detectmite/files/detectMITE.20170425.tar.gz
    tar xvf detectMITE.20170425.tar.gz
    rm detectMITE.20170425.tar.gz
    echo Done.
    echo Moving into detectMITE folder.
    cd detectMITE
    echo Making results directory.
    mkdir -p result
    echo Done.
else
    echo detectMITE already installed, moving to that directory.
    cd detectMITE
    mkdir -p result
    pwd
fi

#Download CD-HIT, unzip, and make it
if [ ! -d cd-hit ]; then
    echo Downloading and unzipping CD-HIT...
    wget https://github.com/weizhongli/cdhit/releases/download/V4.8.1/cd-hit-v4.8.1-2019-0228.tar.gz
    tar xvf cd-hit-v4.8.1-2019-0228.tar.gz
    mv cd-hit-v4.8.1-2019-0228 cd-hit
    rm cd-hit-v4.8.1-2019-0228.tar.gz
    echo Done.
    cd cd-hit
    echo Installing CD-HIT...
    make
    cd ../
else
    echo CD-HIT already installed.
fi

echo Running detectMITE. This might take a while...
module load matlab
#this is for just a single scaffold
#matlab -nodisplay -nosplash -r "tic;do_MITE_detection('../scaffold584.fasta','-genome','scaffold584');runtime=toc;quit"

#Do the annotation on the whole genome. 
#I suspect that the program removes low-copy MITEs, and with only a few scaffolds it might throw out everything as low-copy
matlab -nodisplay -nosplash -r "tic;do_MITE_detection('../../Nobtusifolia/Genome_Files/NIOBT_r1.0.fasta','-genome','NIOBT_r1.0','-cpu',32);runtime=toc;quit"
echo Done.
