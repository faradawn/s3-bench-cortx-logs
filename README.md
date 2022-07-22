# Benchmarking CORTX on Kubernetes

## Cloning the repository
```
git config user.email "faradawny@gmail.com"
git config user.name "faradawn"
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


