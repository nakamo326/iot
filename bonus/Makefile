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
	kubectl -n argocd wait \
		--for condition=available --timeout=600s deployment/argocd-server
	kubectl -n argocd get secret \
		argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > argocd_pass
	sed -i 's/password: .*$$/password: $(shell cat gitlab_pass)/g' k8s/argocd-secret.yaml
	kubectl apply -n argocd -f k8s/argocd-secret.yaml
	kubectl apply -n argocd -f k8s/app.yaml

reargocd:
	kubectl delete namespace argocd
	make argocd

gitlab: wait_metrics
	helm upgrade --install \
		-n gitlab --create-namespace \
		gitlab gitlab/gitlab \
		--timeout 600s \
		-f ./k8s/gitlab.yaml
	kubectl -n gitlab get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode \
		> gitlab_pass

add_hosts:
	echo "127.0.0.1 iot.com\n127.0.0.1 gitlab.iot.com\n127.0.0.1 registry.iot.com\n127.0.0.1 minio.iot.com\n127.0.0.1 pages.iot.com\n127.0.0.1 iot-argocd.com" >> /etc/hosts

delete_hosts:
	sed -i '/iot.com/d' /etc/hosts

# wait metrics-server.
wait_metrics:
	./scripts/wait.sh

.PHONY: all init k3d k3d_del argocd gitlab add_hosts wait_metrics