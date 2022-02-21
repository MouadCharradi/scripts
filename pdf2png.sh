pdf=$1
png=$2

convert -trim -density 300 -depth 8 -quality 98 $1 $2
