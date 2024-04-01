# jpip

APNIC が管理を行っている IPv4 アドレスのうち、日本に割り当てられているアドレスの一覧です。  
Linux の firewalld の ipset などに利用することができます。

IP アドレスリストの最終更新日時: **2024-04-01**

## 使い方

`jpips`をダウンロードして利用してください。

以下は firewalld に新たなゾーンを作成し、日本に割り当てられたアドレス群を ipset として設定する例です。

```bash
# 新規ゾーンを作成
firewall-cmd --permanent --new-zone=jp
# 新規ipsetを作成
firewall-cmd --permanent --new-ipset=jp --type=hash:net
# ipsetに日本のIPアドレスを追加
firewall-cmd --permanent --ipset=jp --add-entries-from-file=./jpips
# 新規作成したipsetをゾーンに追加
firewall-cmd --permanent --zone=jp --add-source=ipset:jp
firewall-cmd --reload
```

### アドレス一覧の更新

`setup.sh`を利用することで、自分で`jpips`ファイルを生成することができます。  
カレントディレクトリに`jpips`ファイルが生成されます。

```bash
chmod +x ./setup.sh
./setup.sh
```

## 引用元

スクリプトなど、以下の記事より拝借しています。

- [firewalldで国内IPのみ許可](https://systemexpress.co.jp/centos/firewalld.html)
