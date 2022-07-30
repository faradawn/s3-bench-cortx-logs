## New method: using s3 speedtest (perf)

shopt -s expand_aliases
source /etc/bashrc

for i in 4 8 16 32 64 128 256 512 1024 2048; do
    TOTAL_SIZE=10000*$i
    mc support perf object myminio/ --size ${i}KiB --blocksize ${i}KiB --concurrent 1 --filesize $TOTAL_SIZE
done



## Old method: create files and upload 

# for i in 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384; do
#     ./create_file $i 1 -o
# done

# source /etc/bashrc
#/home/cc/minio-bench/mc mb myminio/bucket1
# upload and download a file
# ./mc cp 16KB myminio/bucket1/
# ./mc cp myminio/bucket1/16KB .
