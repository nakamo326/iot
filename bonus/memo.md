### 動作確認
1. make
2. デプロイ後、Jobが完了するのを待つ。
3. `gitlab.iot.com`にブラウザからアクセス。root/出力されたパスワードでログイン
4. 右上New projectからリポジトリ追加画面へ
5. Create blank projectを選択
6. publicでリポジトリを作成
7. 作成したリポジトリをhttpsでクローン（`ex) git clone http://gitlab.iot.com/gitlab-instance-fd210447/iot.git`）
8. p3で使ったリポジトリ（https://github.com/nakamo326/ynakamot-iot-app）の中身をコピーしてプッシュ
9. k8s/app.yamlのrepoURLをgitlabで作成したリポジトリのURLに変更して`kubectl apply -n argocd -f k8s/app.yaml`
10. リポジトリの中のチャートのバージョンやイメージを変更して同期を確認

リポジトリ読めてないのでsshの設定必要そう


### 参考
https://docs.gitlab.com/charts/
https://blog.b1-systems.de/forwarding-ssh-traffic-inside-kubernetes-using-traefik