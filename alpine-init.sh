#! /bin/sh
vid=$(grep VERSION_ID /etc/os-release  | cut -f2 -d= | cut -f1,2 -d.)
cat <<EOF > /etc/apk/repositories
http://ftp.tsukuba.wide.ad.jp/Linux/alpine/v${vid}/main
http://ftp.tsukuba.wide.ad.jp/Linux/alpine/v${vid}/community
EOF

apk update
apk add python3
