from = $1
while read region ip; do
  ping -c 1000 -i 0 "$ip" > "$1-to-$region.log"
done
