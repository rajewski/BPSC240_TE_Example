#Load genometools to get the LTR Harvest and LTR Digest programs
module load genometools
#Load HMMer to be able to use the hmm profiles with LTRdigest
module load hmmer/3.1b2

#create an index of the fasta file you are going to search
#only run this command if it hasnt been run before, to save time
if [ ! -e index/scaffold584.md5 ]; then
    echo Generating index for the scaffold...
    mkdir -p index
    gt suffixerator -db scaffold584.fasta  -indexname index/scaffold584 -tis -suf -lcp -des -ssp -sds -dna -memlimit 1GB
    echo Done.
fi

#Run LTR Harvest to find putative LTR transposons
#only run this command if it hasn't been run before, to save time
if [ ! -e scaffold584.ltrharvest.sorted.gff3 ]; then
    echo Running LTRharvest to find putative LTR retrotransposons...
    mkdir -p outinner
    gt ltrharvest \
	-index index/scaffold584 \
	-gff3 scaffold584.ltrharvest.gff3 \
	-outinner outinner/scaffold584.ltrharvest.outinner.fa \
	--seqids \
	-out scaffold584.ltrharvest.fa > scaffold584.ltrharvest.out
    #Sort the outputted GFF3 file
    gt gff3 -sort scaffold584.ltrharvest.gff3 > scaffold584.ltrharvest.sorted.gff3
    echo Done.
fi

#Run LTR Digest to annotate protein/ORFS inside the LTR transposons
echo Running LTRdigest to annotate features of the TEs...
mkdir -p ltrdigest
gt ltrdigest \
    -outfileprefix ltrdigest/scaffold584.ltrdigest \
    -trnas eukaryotic-tRNAs/eukaryotic-tRNAs.fa \
    -hmms gydb_hmms/GyDB_collection/profiles/*.hmm \
    --matchdesc \
    --seqfile scaffold584.fasta \
    -- scaffold584.ltrharvest.sorted.gff3 index/scaffold584 > scaffold584.ltrdigest.gff3
echo Done.
