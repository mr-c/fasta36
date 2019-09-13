#!/bin/sh

################
##
## test python scripts
##

echo 'get_genome_seq.py'
get_genome_seq.py chr1:109687874-109687909

echo 'get_protein.py'
get_protein.py 'sp|P09488|GSTM1_HUMAN'
get_protein.py 'P09488'
get_protein.py 'NP_000552'

echo '################################################################'
echo 'requires mysql database'
echo 'get_protein_sql.py'
get_protein_sql.py 'sp|P09488|GSTM1_HUMAN'
get_protein_sql.py 'P09488'
get_protein_sql.py 'NP_000552'

echo 'get_protein_sql_www.py'
get_protein_sql_www.py 'sp|P09488|GSTM1_HUMAN'
get_protein_sql_www.py 'P09488'
get_protein_sql_www.py 'NP_000552'


echo 'get_refseq.py'
get_refseq.py NP_000552
get_refseq.py NP_0000552

echo 'get_uniprot.py'
get_uniprot.py P09488
get_uniprot.py 'sp|P09488|GSTM1_HUMAN'

echo '################################################################'
echo 'requires mysql database'
echo 'get_up_prot_iso_sql.py'
get_up_prot_iso_sql.py 'sp|P09488|GSTM1_HUMAN'
get_up_prot_iso_sql.py P09488

echo '################################################################'
echo 'map_exon_coords.py -- look for chrA:start-stop::chrB:start-stop in output'
# (a) produce an appropriate alignment file
fasta36 -q -m 8CBL -V \!ann_exons_up_sql.pl+--gen_coord+--exon_label -V q\!ann_exons_up_sql.pl+--gen_coord+--exon_label \!get_protein.py+P30711 \!get_protein.py+P20135 > hum_chk_map_test.m8CBL
# (b) expand chromosome locations on subject and query exons to both genomes
map_exon_coords.py  hum_chk_map_test.m8CBL

echo 'rename_exons.py -- look for exon_X in output'
rename_exons.py hum_chk_map_test.m8CBL   # produces a renamed exon_x

## echo 'relabel_domains.py
## relabel_domains.py

