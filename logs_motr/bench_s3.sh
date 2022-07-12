# kubectl describe svc cortx-io-svc-0 | grep -Po 'NodePort.*rgw-http *[0-9]*'
# ifconfig

export IP=192.168.139.64
export PORT=31886

for i in 1 2 3; do
    for nreqs in 1; do
        for objsize in 16 64 1024 4096; do
            for nclients in 1; do
                start=$(date +%s)
                nsamples=$(( ($nclients * $nreqs) ))
                path="logs/write/objsize=${objsize}k"
                mkdir -p $path
                echo "performing ${path}"
                ./s3bench -accessKey gregoryaccesskey -accessSecret gregorysecretkey -endpoint http://$IP:$PORT -objectNamePrefix=loadgen -region us-east-1 \
                -bucket "bucket-${nreqs}-${objsize}-${nclients}" \
                -objectSize "${objsize}Kb" \
                -numClients $nclients \
                -numSamples $nsamples \
                -skipRead \
                -o "${path}/s3-bench-log_${i}.txt"

                end=$(date +%s)
                runtime=$(( (end-start)/60 ))
                echo "runtime is $runtime minutes"
            done
        done
    done
done

rm -f *2022-7*
