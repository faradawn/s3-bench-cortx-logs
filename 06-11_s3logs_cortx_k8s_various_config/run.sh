# kubectl describe svc cortx-io-svc-0 | grep -Po 'NodePort.*rgw-http *[0-9]*'
# export PORT=30773 (NodePort - cortx-rgw-http - 30056/TCP (PORT=30056))
# export IP=192.168.84.128 (ifconfig, tunl0, IPIP tunnel)

export IP=192.168.84.128
export PORT=30113

for nreqs in 100; do
    for objsize in 1024; do
        for nclients in 80; do
            start=$(date +%s)
            nsamples=$(( ($nclients * $nreqs) ))
            path="logs/k8cluster=8/npods=12/podsize=64g/nreqs=${nreqs}/objsize=${objsize}k/nclients=${nclients}"
            mkdir -p $path
            echo "performing ${path}"
            ./s3bench -accessKey gregoryaccesskey -accessSecret gregorysecretkey -endpoint http://$IP:$PORT -objectNamePrefix=loadgen -region us-east-1 \
            -bucket "bucket-${nreqs}-${objsize}-${nclients}" \
            -objectSize "${objsize}Kb" \
            -numClients $nclients \
            -numSamples $nsamples \
            -o "${path}/s3-bench-log.txt" \
            -skipCleanup

            end=$(date +%s)
            runtime=$(( (end-start)/60 ))
            echo "runtime is $runtime minutes"
        done
    done
done

rm -f *2022-6*
