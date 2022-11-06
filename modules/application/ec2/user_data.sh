#!/bin/bash
# サーバーの設定変更
sed -i 's/^HOSTNAME=[a-zA-Z0-9\.\-]*$/HOSTNAME=udemy-bash/g' /etc/sysconfig/network
hostname 'udemy-bash'
cp /usr/share/zoneinfo/Japan /etc/localtime
sed -i 's|^ZONE=[a-zA-Z0-9\.\-\"]*$|ZONE="Asia/Tokyo"|g' /etc/sysconfig/clock
echo "LANG=ja_JP.UTF-8" > /etc/sysconfig/i18n
# アパッチのインストール
sudo yum update -y
sudo yum install httpd -y
sudo service httpd start
sudo chkconfig httpd on
# index.htmlの設置
aws s3 cp s3://tf-practice-test-html-bucket/index.html /var/www/html
# index.htmlの編集
iid=$(curl http://169.254.169.254/latest/meta-data/instance-id)
sed -i s/iid/$iid/ /var/www/html/index.html
azi=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone-id)
sed -i s/azi/$azi/ /var/www/html/index.html
lip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
sed -i s/lip/$lip/ /var/www/html/index.html
