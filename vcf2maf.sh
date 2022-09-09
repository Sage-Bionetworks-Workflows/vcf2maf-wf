#!/bin/bash

cat nf-osi-vcf2maf-*/vcf2maf.pl \
    | sed 's/gnomAD_/gnomADg_/g' \
    | sed 's/--af_gnomad/--af_gnomadg/g' \
    > /usr/local/bin/vcf2maf.pl

perl /usr/local/bin/vcf2maf.pl $@
