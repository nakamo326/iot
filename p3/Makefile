CLUSTER_NAME = iot

all:
	make init
	make k3d
	make helm

# install requerements.
init:
	./scripts/init.sh

# make cluster. if there's already, delete current cluster
k3d: k3d_del
	k3d cluster create $(CLUSTER_NAME) -p "80:80@loadbalancer"

# delete cluster.
k3d_del:
	k3d cluster delete $(CLUSTER_NAME)

# install helm chart.
helm: wait_metrics
	helm dependency build ./app
	helm install app ./app --timeout 15m
	kubectl get secret --namespace default app-grafana -o jsonpath="{.data.admin-password}" | base64 --decode > grafana_password

# upgrade helm chart.
helm_up:
	helm upgrade app ./app
	kubectl get secret --namespace default app-grafana -o jsonpath="{.data.admin-password}" | base64 --decode > grafana_password

helm_del:
	helm delete app

# wait metrics-server.
wait_metrics:
	./scripts/wait.sh

.PHONY: all init k3d k3d_del helm helm_up helm_del wait_metrics