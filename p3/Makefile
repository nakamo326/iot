CLUSTER_NAME = iot

# make cluster. if there's already, delete current cluster
all: del
	k3d cluster create $(CLUSTER_NAME)

# delete cluster.
del:
	k3d cluster delete $(CLUSTER_NAME)

# install helm chart.
# install:


# upgrade helm chart.
# up:

.PHONY: all del install up