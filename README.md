# autoAD
script to automatize some boring and repetitive process of copy and paste commands to exploit an active directory

## install
```
➜  ~ git clone https://github.com/b4sh0xf/autoAD.git
➜  ~ chmod +x ~/autoAD/main.sh
➜  ~ source ~/autoAD/main.sh 
➜  ~ echo "source ~/autoAD/main.sh" >> ~/.bashrc
➜  ~ source ~/.bashrc
```

## usage
```
➜  ~ krbo 10.0.0.1 example.com administrator mypassword
➜  ~ asrep 10.0.0.1 example.com
➜  ~ krbnum 10.0.0.1 example.com
➜  ~ smbc example.com user password 10.0.0.1
➜  ~ ldapdump user password example.com 10.0.0.1
➜  ~ map 10.0.0.1
➜  ~ gw administrator example.com password targetuser 10.0.0.1
```
