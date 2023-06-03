#!/bin/bash

echo "waiting for metrics-server to be ready"
while :; do
kubectl wait -n kube-system --timeout=90s --for=condition=Ready pod -l k8s-app=metrics-server
if [ $? = 0 ];then
  break
fi
sleep 1
done
echo "done waiting"
