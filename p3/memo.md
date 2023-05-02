### 試したこと
1. ./scripts/init.shを実行k3dをインストール、クラスターを作成
2. `kubectl config get-contexts`でk3dのクラスターがあること、current-contextになっていることを確認
3. `kubectl get all -n kube-system`で、システムリソースを確認（k3sと多分一緒
4. /etc/hostsに`127.0.0.1 app1.com`を追加
5. app1.comでPrometheusのWeb UIが表示されることを確認

### memo
cAdvisorポートフォワード
```
kubectl port-forward pod/`kubectl get pod -l app=cadvisor -o jsonpath="{.items[0].metadata.name}"` 8080:8080
```

grafana password
```
kubectl get secret app-grafana -o jsonpath="{.data.admin-password}" | base64 --decode; echo
```

- [prometheusのvalues.yaml](https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus/values.yaml)
- [grafanaのvalues.yaml](https://github.com/grafana/helm-charts/blob/main/charts/grafana/values.yaml)

### Github Apps
1. https://github.com/settings/apps からNew Github App
2. Repository PermissionsのContentsにRead-Onlyを設定
3. Create Github App
4. App IDを控える
5. Generate a private key
6. 左のメニューからInstall App
7. Argo CDからアクセスしたいリポジトリを選択してインストール
8. URLのInstallation IDを控える
9. Argo CDのSettingsからCONNECT REPO、VIA GITHUB APPを選択して控えてID,keyを入力する