# Benchmarking CORTX on Kubernetes

## Benchmark log
- [Google Doc](https://docs.google.com/document/d/1ieDX__s8iYQXpIK7ei3SwIX79j4lxqLdPQyh6cg_7pg/edit)

## Deploy cortx
```
# first destroy
- 8 nodes: 1.5 min
- 4 nodes: 1 min
- 2 nodes: 1 min
- 1 node: 1 min

# second edit solution.example.yaml

# third deploy
- 8 nodes: 12 min
- 4 nodes: 7.5 min
- 2 nodes: 7.1 min
- 1 node: 6.5 min

# fourth edit run.sh

# IAM login
export IP=192.168.84.128 (ifconfig | grep 192)
export PORT=30773 (kubectl describe svc cortx-io-svc-0 | grep -Po 'NodePort.*rgw-http *[0-9]*')

export CSM_IP=`kubectl get svc cortx-control-loadbal-svc -ojsonpath='{.spec.clusterIP}'`

tok=$(curl -d '{"username": "cortxadmin", "password": "Cortx123!"}' https://$CSM_IP:8081/api/v2/login -k -i | grep -Po '(?<=Authorization: )\w* \w*') && echo $tok

curl -X POST -H "Authorization: $tok" -d '{ "uid": "12345678", "display_name": "gts3account", "access_key": "gregoryaccesskey", "secret_key": "gregorysecretkey" }' https://$CSM_IP:8081/api/v2/iam/users -k

curl -H "Authorization: $tok" https://$CSM_IP:8081/api/v2/iam/users/12345678 -k -i

./s3bench -accessKey gregoryaccesskey -accessSecret gregorysecretkey -bucket loadgen -endpoint http://$IP:$PORT -numClients 1 -numSamples 100 -objectNamePrefix=loadgen -objectSize 16Kb -region us-east-1 -o "delete_me"
```

## Bash alias
/etc/bashrc
```
export KUBECONFIG=/etc/kubernetes/admin.conf
alias kc=kubectl
alias all="kubectl get pods -A -o wide"
alias k8="cd /home/cc/cortx-k8s/k8_cortx_cloud"
alias bench="cd /home/cc/benchlogs"
alias gi="git push"
alias gc="git commit -m"
alias ga="git add"
```


