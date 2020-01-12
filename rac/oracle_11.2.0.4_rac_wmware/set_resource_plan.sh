#!/bin/bash
# set_resource_plan.sh
# Auth: BoooBooWei 2020.01.09

set_resource_plan(){
ssh_port=22
grid_tmp=/home/grid/grid_tmp/ # grid 安装记录临时存放路径
grid_passwd=Zyadmin123 # grid 应答文件中SYSASMPassword 和 monitorPassword 的密码
database_name=rac # 数据库名称

node1_hostname=rac1 # 节点1 名称，主机名，实例名
node1_physic_ip=eth0:192.168.14.150 # 节点1 真实的物理网卡和地址
node1_public_ip=eth0:192.168.14.150 # 节点1 公共IP 网卡和地址
node1_public_vip=192.168.14.160 # 节点1 虚拟IP 网卡和地址
node1_private_ip=eth1:192.168.220.132 # 节点1 专用IP 网卡和地址
node1_domain_pub=(rac1 rac1.example.com) # 节点1 公共IP 域名
node1_domain_pub_v=(rac1-vip rac1-vip.example.com) # 节点1 虚拟IP 域名
node1_domain_pri=(rac1-priv rac1-priv.example.com) # 节点1 专用IP 域名


node2_hostname=rac2 # 节点2 名称，主机名，实例名
node2_physic_ip=eth1:192.168.14.151 # 节点2 真实的物理网卡和地址
node2_public_ip=eth1:192.168.14.151 # 节点2 公共IP 网卡和地址
node2_public_vip=192.168.14.161 # 节点2 虚拟IP 网卡和地址
node2_private_ip=eth2:192.168.220.133 # 节点2 专用IP 网卡和地址
node2_domain_pub=(rac2 rac2.example.com) # 节点2 公共IP 域名
node2_domain_pub_v=(rac2-vip rac2-vip.example.com) # 节点2 虚拟IP 域名
node2_domain_pri=(rac2-priv rac2-priv.example.com) # 节点2 专用IP 域名

scan_ip=192.168.14.180 # SCAN IP 地址
scan_name=rac-cluster-scan # SCAN名称

rac_dir=/alidata/ # rac和oracle安装最顶级目录
shared_storage=("/dev/sdb1" "/dev/sdb2") # 共享存储块设备


# 获取真实的物理网卡IP和网卡
node1_physic_ip_addr=${node1_physic_ip#*:}
node1_physic_ip_eth=${node1_physic_ip/:*}
node2_physic_ip_addr=${node2_physic_ip#*:}
node2_physic_ip_eth=${node2_physic_ip/:*}

# 获取专用IP和网卡
node1_private_ip_addr=${node1_private_ip#*:}
node1_private_ip_eth=${node1_private_ip/:*}
node2_private_ip_addr=${node2_private_ip#*:}
node2_private_ip_eth=${node2_private_ip/:*}

# 获取专用IP的网段（/24）
node1_private_ip_net=`echo ${node1_private_ip_addr} | awk -F '.' '{print $1"."$2"."$3".0"}'`
node2_private_ip_net=`echo ${node2_private_ip_addr} | awk -F '.' '{print $1"."$2"."$3".0"}'`

# 获取公共IP和网卡
node1_public_ip_addr=${node1_public_ip#*:}
node1_public_ip_eth=${node1_public_ip/:*}
node2_public_ip_addr=${node2_public_ip#*:}
node2_public_ip_eth=${node2_public_ip/:*}

# 获取公共IP的网段（/24）
node1_public_ip_net=`echo ${node1_public_ip_addr} | awk -F '.' '{print $1"."$2"."$3".0"}'`
node2_public_ip_net=`echo ${node2_public_ip_addr} | awk -F '.' '{print $1"."$2"."$3".0"}'`

}


set_resource_plan