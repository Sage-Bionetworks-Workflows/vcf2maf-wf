#!/bin/bash

# This script assumes that `setup.sh` has already been run
# and that `vcf2maf.sh` is available in the same folder

# Get current repository folder
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Run vcf2maf on example VCF file
docker run \
    -v $HOME/data:/work/:rw -v /dev/shm/:/ref/:ro -v $SCRIPT_DIR/:/src/:ro \
    nfosi/vcf2maf:latest \
    bash /src/vcf2maf.sh --input-vcf /work/test.vcf --output-maf /work/test.maf \
    --ref-fasta /ref/fasta/Homo_sapiens_assembly38.fasta --vep-data /ref/vep \
    --vep-path /root/miniconda3/envs/vcf2maf/bin --ncbi-build GRCh38 \
    --max-subpop-af 0.0005 --maf-center "Sage Bionetworks"
