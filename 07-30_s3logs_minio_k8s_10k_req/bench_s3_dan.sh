# kubectl describe svc cortx-io-svc-0 | grep -Po 'NodePort.*rgw-http *[0-9]*'
# ifconfig

export IP=127.0.0.1
export PORT=9000
# mkdir -p logs/
# "4Kb" "8Kb" "16Kb" "32Kb" "64Kb" "128Kb" "256Kb" "512Kb" "1Mb" "2Mb" "4Mb" "8Mb" "16Mb"
blockSizeArr=("4Kb" "8Kb" "16Kb" "32Kb" "64Kb" "128Kb" "256Kb" "512Kb" "1Mb" "2Mb" "4Mb" "8Mb" "16Mb")

for size in "${blockSizeArr[@]}"
do
    echo "$size"
    ./s3bench -accessKey minioadmin -accessSecret minioadmin -bucket loadgen -endpoint http://$IP:$PORT -numClients 1 -numSamples 10000 -objectNamePrefix=loadgen -objectSize $size -region us-east-1 -o logs_minio/s3bench-$size.log
done

# blockSizeArr=("4Mb" "8Mb" "16Mb")
# for size in "${blockSizeArr[@]}"
# do
#     echo "$size"
#     ./s3bench -accessKey minioadmin -accessSecret minioadmin -bucket loadgen -endpoint http://$IP:$PORT -numClients 1 -numSamples 2000 -objectNamePrefix=loadgen -objectSize $size -region us-east-1 -o logs_minio/s3bench-$size.log
# done

