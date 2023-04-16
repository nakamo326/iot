## 遊び方
1. PCにvagrantとvirtualboxをインストールする
2. このディレクトリで`vagrant up`を実行する
3. 待っていたらvirtualbox上で仮想マシンが2つできるはず
4. それぞれの仮想マシンに`vagrant ssh [machine]`でssh接続できる(machine名は`config.vm.define "machine_name"`で指定してある)
5. serverで`sudo kubectl get nodes -o wide`でkubernetesクラスターのノードとして、2つのVMが動作していることが確認できる
6. `vagrant halt`でVMをシャットダウン、`Vagrant destroy`でVM削除

現状ここまで、