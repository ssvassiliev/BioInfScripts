awk  'BEGIN { FS = "\t" } ; { OFS = ";" } ; { print $1, $2, $3, $4, $5, $6, $7, $10, $11, $12, $13, $14, $15, $16, $17, $18 }' test.out > test_cut.out
