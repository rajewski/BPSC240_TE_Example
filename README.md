# BPSC240_TE_Example
Scripts for a quick demonstration of LTR identification

This repository is part of Alex Rajewski and Ryan Traband's presentation for BPSC240 at the university of California Riverside. The goal is to provide a quick example of a tool to identify LTR retrotransposons in a genomic fragment and to do some quick and simple analyses of them.

These scripts are intended to be run interactively on the [UCR HPCC](http://hpcc.ucr.edu) and certain commands will not be applicable if you do not have the correct software installed. Computationally, it does not require much in terms of resources. Before you run these scripts on the HPCC request space on an interactive node with the command `srun --pty bash -l`. When you are done with these scripts make sure to type `exit` to cancel this request. You will also need to type `exit` again to actually log out of the HPCC though.

I have added an optional third script, which I am still testing. It is designed to detect MITEs, non-autonomous DNA transposons. As is, it does not find any in the scaffold584.fasta file I provided, but I think that is a technical flaw based on a limited sequence length and not biological truth. I have set up that script (3_MITE.sh) to scan the entire *Nicotiana obtusifolia* genome and see if the results are different. I have not provided that genome file in this Git because it's huge, and ultimately using the entire genome might not solve the problem. If you want to try this script on your own, uncomment the second-to-last matlab command in that script so that it just runs on the scaffold584.fasta file. Note: you can also ignore the comment lines at the top of that script which are only applicable if you submit the script to run non-interactively for the entire genome annotation of MITEs.

