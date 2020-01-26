#downlaod detectMite and unzip it
if [ ! -d detectMITE/ ];then
    echo Downloading detectMITE...
    wget https://sourceforge.net/projects/detectmite/files/detectMITE.20170425.tar.gz
    tar xvf detectMITE.20170425.tar.gz
    echo Done.
    echo Moving into detectMITE folder.
    cd detectMITE
    echo Making results director.
    mkdir -p result
    echo Done.
else
    echo detectMITE already installed, moving to that directory.
    cd detectMITE
    mkdir -p result
fi

#Download CD-HIT, unzip, and make it
if [ ! -d cd-hit ]; then
    echo Downloading and unzipping CD-HIT...
    wget https://github.com/weizhongli/cdhit/releases/download/V4.8.1/cd-hit-v4.8.1-2019-0228.tar.gz
    tar xvf cd-hit-v4.8.1-2019-0228.tar.gz
    mv cd-hit-v4.8.1-2019-0228.tar.gz cd-hit
    rm cd-hit-v4.8.1-2019-0228.tar.gz
    echo Done.
    cd cd-hit
    echo Installing CD-HIT...
    make
    cd ../
else
    echo CD-HIT already installed.
fi

module load matlab
matlab -nodisplay -nosplash -r "tic;do_MITE_detection('../scaffold584.fasta','-genome','scaffold584');runtime=toc;quit"

