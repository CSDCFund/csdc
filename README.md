# csdc

云链是完全去中心化的，可以实现端到端流量计费的内容存储和分发网络。

云链是一个完全开放的系统，云链的开放包括以下的部分:

> 接入端开放：任何厂商都可以接入到云链，通过云链降低流量成本，提高资金使用效率
> 节点端开放：任何企业或个人都可以下载、编译我们的软件，进行挖矿，系统会按照实现发生的流量给予相应的奖励；甚至自己可以编写与接口协议一致的挖矿软件实现挖矿
> 应用端开放：开放的SDK，任何企业或个人都可以开发自己的客户端应用

详细的内容请查看[wiki](https://github.com/CSDCFund/csdc/wiki)


## 安装
可以使用两种方法来安装云链矿机

### 方法一. git 的安装方法
方法一需要使用git 软件包：

安装脚本源码位于installer目录下

git clone https://github.com/CSDCFund/csdc.git

cd csdc/installer

./install.sh



### 方法二. 通过打包文件安装的方法
方法二完全使用linux自带的命令

wget -o cdscinstaller.tar.gz https://github.com/CSDCFund/csdc/blob/master/cdsc-linux-amd64.tar.gz?raw=true

tar zvxf cdscinstaller.tar.gz

cd installer

./install.sh 

## 使用
1. 安装完成后，系统会自动产生一个eswarmXXXXXX(其中XXXXXX是6位数的0－9A－Z的数字)无线网络，密码是默认的Abcd#1234
2. 安装手机云链客户端
3. 加入到1所描述的网络矿机对应的无线网络
4. 通过添加矿机添加此矿机





