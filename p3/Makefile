CLUSTER_NAME = iot

all:
	make init
	make k3d
	make argocd

# install requerements.
init:
	./scripts/init.sh

# make cluster. if there's already, delete current cluster
k3d: k3d_del
	k3d cluster create $(CLUSTER_NAME) -p "80:80@loadbalancer"

# delete cluster.
k3d_del:
	k3d cluster delete $(CLUSTER_NAME)

# install argocd and application.
argocd: wait_metrics
	helm install -n argocd --create-namespace argocd argo/argo-cd -f ./k8s/argocd.yaml
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > argocd_pass
	kubectl apply -n argocd -f k8s/app.yaml

# wait metrics-server.
wait_metrics:
	./scripts/wait.sh

.PHONY: all init k3d k3d_del argocd wait_metrics