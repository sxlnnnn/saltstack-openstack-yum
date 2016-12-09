# saltstack-openstack-yum
      SaltStack自动化部署OpenStack-Liberty

前言

     因为有很多朋友问我如何部署openstack，他们部署总是不成功，所以将部署过程用saltstack写出来，
     需要的朋友只要将这个项目放到salt里面执行，就可以自动部署openstack环境了。
    
openstack 部署基础环境
   
你需要最少有2台服务器，一台作为控制节点主机名node1,一台作为计算节点主机名为node2,并做好本地主机名解析。
  
  
  修改/etc/hosts文件，添加下面两行
   
     192.168.1.231 node1
     192.168.1.232 node2
    
服务器部署salt环境

    node1
    wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
    yum install -y salt-minion salt-master
    sed -i s/"#master: salt"/"master: 192.168.1.231"/ /etc/salt/minion
    systemctl start salt-master.service salt-minion.service
    
       
    node2
    wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
    yum install -y salt-minion
    sed -i s/"#master: salt"/"master: 192.168.1.231"/ /etc/salt/minion
    systemctl start salt-minion.service
    
    
  
把项目放到salt的目录执行状态就会自动安装好openstack环境。


  
