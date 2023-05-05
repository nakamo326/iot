CLUSTER_NAME = iot

all:
	make init
	make k3d
	make gitlab

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

gitlab: wait_metrics
	helm upgrade --install \
	-n gitlab --create-namespace \
	gitlab gitlab/gitlab \
	--timeout 600s \
	-f ./k8s/gitlab.yaml
	kubectl get secret -n gitlab \
	gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

add_hosts:
	echo "127.0.0.1 iot.com\n127.0.0.1 gitlab.iot.com\n127.0.0.1 registry.iot.com\n127.0.0.1 minio.iot.com\n127.0.0.1 pages.iot.com" >> /etc/hosts

delete_hosts:
	sed -i '/iot.com/d' /etc/hosts

# wait metrics-server.
wait_metrics:
	./scripts/wait.sh

.PHONY: all init k3d k3d_del argocd gitlab add_hosts wait_metrics