### /etc/hosts
Windowsマシンのhostsファイルは"C:\Windows\System32\drivers\etc"にある。
ブラウザから、app1,app2を確認したい場合、このファイルを編集するのが楽。
メモ帳を管理者権限で実行、
```
192.168.56.110 app1.com
192.168.56.110 app2.com
```
を追記

### app2のレプリカ
`kubectl get pods`でもpodが3つ作られていることは確認できる。
ブラウザ、curlなどでリクエストするとラウンドロビンでロードバランシングされているのが分かる。

PowerShellはgrepない。。。（みたいなやつはある
curl -H 'Host:app2.com' http://192.168.56.110  | Select-String -Pattern "app2"