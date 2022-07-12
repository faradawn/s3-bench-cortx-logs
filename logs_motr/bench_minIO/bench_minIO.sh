# script to bench MinIO
# data are collected manully

# download MinIo
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
mkdir -P /mnt/data
./minio server /mnt/data

# download minio-cli
wget https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
./mc --help

# create file
gcc -o create_file create_file.c
./create_file 16 1 -h

# upload and download a file
./mc cp 16KB myminio/bucket1/
./mc cp myminio/bucket1/16KB .