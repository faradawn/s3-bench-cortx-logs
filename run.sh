export IP=192.168.84.128
export PORT=31047

for nreqs in 100; do
    for objsize in 16384; do
        for nclients in 80; do
            start=$(date +%s)
            nsamples=$(( ($nclients * $nreqs) ))
            path="logs/k8cluster=8/npods=2/podsize=64g/nreqs=${nreqs}/objsize=${objsize}k/nclients=${nclients}"
            mkdir -p $path
            echo "performing ${path}"
            ./s3bench -accessKey gregoryaccesskey -accessSecret gregorysecretkey -endpoint http://$IP:$PORT -objectNamePrefix=loadgen -region us-east-1 \
            -bucket "bucket-${nreqs}-${objsize}-${nclients}" \
            -objectSize "${objsize}Kb" \
            -numClients $nclients \
            -numSamples $nsamples \
            -o "${path}/s3-bench-log.txt"

            end=$(date +%s)
            runtime=$(( (end-start)/60 ))
            echo "runtime is $runtime minutes"
        done
    done
done

rm -f *2022-6*