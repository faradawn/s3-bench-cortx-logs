start=$(date +%s)

export IP=192.168.84.128
export PORT=31477

for nreqs in 1000; do
    for objsize in 1024; do
        for nclients in 1 5 10; do
            nsamples=$(( ($nclients * $nreqs) ))
            path="logs/k8cluster=4/npods=2/podsize=4g/nreqs=${nreqs}/objsize=${objsize}k/nclients=${nclients}"
            echo "${path}/se.log"
            mkdir -p $path
            ./s3bench -accessKey gregoryaccesskey -accessSecret gregorysecretkey -bucket loadgen -endpoint http://$IP:$PORT -objectNamePrefix=loadgen -region us-east-1 \
            -objectSize "${objsize}Kb" \
            -numClients $nclients \
            -numSamples $nsamples \
            -o "${path}/s3-bench-log.txt"
        done
    done
done

rm -f *2020-6*
end=$(date +%s)
runtime=$(( (end-start)/60 ))
echo "runtime is $runtime minutes"