#!/bin/bash

# Install tmux for long-running commands
sudo yum install -y tmux

# Increase /dev/shm size for VEP cache
sudo mount -o remount,size=30G /dev/shm

# Download Ensembl VEP cache (expands to 22G)
mkdir -p /dev/shm/vep/
rsync -avr --progress rsync://ftp.ensembl.org/ensembl/pub/release-107/variation/indexed_vep_cache/homo_sapiens_vep_107_GRCh38.tar.gz $HOME/.vep/
tar -zvxf $HOME/.vep/homo_sapiens_vep_107_GRCh38.tar.gz -C /dev/shm/vep/

# Download reference genome FASTA file
mkdir -p /dev/shm/fasta/
aws --no-sign-request s3 sync s3://sage-igenomes/igenomes/Homo_sapiens/GATK/GRCh38/Sequence/WholeGenomeFasta/ /dev/shm/fasta/

# Get example VCF file for testing purposes
mkdir -p $HOME/data
echo "Log into AWS using credentials from JumpCloud"
aws s3 cp s3://ntap-add5-project-tower-bucket/outputs/sarek_syn29793238/VariantCalling/2-001_Plexiform_Neurofibroma/DeepVariant/2-001_Plexiform_Neurofibroma.vcf.gz ~/data/test.vcf.gz
gunzip ~/data/test.vcf.gz
