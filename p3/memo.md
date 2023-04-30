### 試したこと
1. ./scripts/init.shを実行k3dをインストール、クラスターを作成
2. `kubectl config get-contexts`でk3dのクラスターがあること、current-contextになっていることを確認
3. `kubectl get all -n kube-system`で、システムリソースを確認（k3sと多分一緒