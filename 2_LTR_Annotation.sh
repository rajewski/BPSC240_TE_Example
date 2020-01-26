#Load genometools to get the LTR Harvest and LTR Digest programs
module load genometools
#Load HMMer to be able to use the hmm profiles with LTRdigest
module load hmmer/3.1b2

#create an index of the fasta file you are going to search
#only run this command if it hasnt been run before, to save time
if [ ! -e NobtScaffolds.md5 ]; then
    gt suffixerator -db NobtScaffolds.fa  -indexname NobtScaffolds -tis -suf -lcp -des -ssp -sds -dna -memlimit 1GB
fi

#Run LTR Harvest to find putative LTR transposons
#only run this command if it hasn't been run before, to save time
if [ ! -e NobtScaffolds.ltrharvest.sorted.gff3 ]; then
    mkdir -p outinner
    gt ltrharvest \
	-index NobtScaffolds \
	-gff3 NobtScaffolds.ltrharvest.gff3 \
	-outinner outinner/NobtScaffolds.ltrharvest.outinner.fa \
	--seqids \
	--maxdistltr 17000 \
	-out NobtScaffolds.ltrharvest.fa > NobtScaffolds.ltrharvest.out
    #Sort the outputted GFF3 file
    gt gff3 -sort NobtScaffolds.ltrharvest.gff3 > NobtScaffolds.ltrharvest.sorted.gff3
fi

#Run LTR Digest to annotate protein/ORFS inside the LTR transposons
mkdir -p ltrdigest
gt ltrdigest \
    -outfileprefix ltrdigest/NobtScaffolds.ltrdigest \
    -trnas eukaryotic-tRNAs/eukaryotic-tRNAs.fa \
    -hmms gydb_hmms/GyDB_collection/profiles/*.hmm \
    --matchdesc \
    --seqfile NobtScaffolds.fa \
    -- NobtScaffolds.ltrharvest.sorted.gff3 NobtScaffolds > NobtScaffolds.ltrdigest.gff3
