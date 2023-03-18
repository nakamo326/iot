## 遊び方
1. PCにvagrantとvirtualboxをインストールする
2. このディレクトリで`vagrant up`を実行する
3. 待っていたらvirtualbox上で仮想マシンが2つ（今はserverとagentと命名している）できるはず
4. それぞれの仮想マシンに`vagrant ssh [machine]`でssh接続できる
5. serverで`sudo kubectl get nodes -o wide`でkubernetesクラスターのノードとして、2つのVMが動作していることが確認できる

現状ここまで、