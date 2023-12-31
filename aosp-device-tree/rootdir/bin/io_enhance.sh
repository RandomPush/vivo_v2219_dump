#!/vendor/bin/sh

MemTotalStr=`cat /proc/meminfo | grep MemTotal`
MemTotal=${MemTotalStr:16:8}
SIZE_8G=$((8*1024*1024))
SIZE_6G=$((6*1024*1024))
SIZE_4G=$((4*1024*1024))
SIZE_3G=$((3*1024*1024))

function configure_dm_retain_bytes() {
	if [ $MemTotal -gt $SIZE_8G ]; then
		retain=$((12*1024*1024))	# >8G
		prefetch=$((8*1024))
	elif [ $MemTotal -gt $SIZE_6G ]; then
		retain=$((8*1024*1024))		# >6G
		prefetch=0
	elif [ $MemTotal -gt $SIZE_4G ]; then
		retain=$((4*1024*1024))		# >4G
		prefetch=0
	else
		retain=$((1*1024*1024))		# <4G
		prefetch=0
	fi

	echo $retain > /sys/module/dm_bufio/parameters/retain_bytes
	echo $prefetch > /sys/module/dm_verity/parameters/prefetch_cluster
}

function configure_read_ahead_kb_values() {
	dmpts=$(ls /sys/block/*/queue/read_ahead_kb | grep -e dm -e sd)

	if [ $MemTotal -gt $SIZE_8G ]; then
		ra_kb=256	# >8G
	elif [ $MemTotal -gt $SIZE_6G ]; then
		ra_kb=128	# >6G
	elif [ $MemTotal -gt $SIZE_4G ]; then
		ra_kb=128	# >4G
	elif [ $MemTotal -gt $SIZE_3G ]; then
		ra_kb=128	# >3G
	else
		ra_kb=64	# <3G
	fi

	for dm in $dmpts; do
		echo $ra_kb > $dm
	done
}

configure_dm_retain_bytes
configure_read_ahead_kb_values
