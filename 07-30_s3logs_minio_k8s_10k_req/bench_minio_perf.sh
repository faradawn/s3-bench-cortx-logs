# ./minio server /mnt/data
# 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384

shopt -s expand_aliases
source /etc/bashrc

for i in 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384; do
    TOTAL_SIZE=10000*$i
    mc support perf object myminio/ --size ${i}KiB --blocksize ${i}KiB --concurrent 1 --filesize $TOTAL_SIZE
done
