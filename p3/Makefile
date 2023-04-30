CLUSTER_NAME = iot

# make cluster. if there's already, delete current cluster
all: del
	k3d cluster create $(CLUSTER_NAME) -p "80:80@loadbalancer"

# delete cluster.
del:
	k3d cluster delete $(CLUSTER_NAME)

# install requerements.
init:
	./scripts/init.sh

# install helm chart.
helm: wait_metrics
	helm dependency build ./app
	helm install app ./app
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

.PHONY: all del init helm wait_metrics