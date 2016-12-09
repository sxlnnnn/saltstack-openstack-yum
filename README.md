# saltstack-openstack-yum
      SaltStack自动化部署OpenStack-Liberty

前言

     因为有很多朋友问我如何部署openstack，他们部署总是不成功，所以将部署过程用saltstack写出来，
     需要的朋友只要将这个项目放到salt里面执行，就可以自动部署openstack环境了。
    
openstack 部署环境
   
你需要最少有2台服务器，一台作为控制节点主机名node1,一台作为计算节点主机名为node2,并做好本地主机名解析。
  
  
  修改/etc/hosts文件，添加下面两行
   
     192.168.1.231 node1
     192.168.1.232 node2
    
服务器部署好salt环境



将项目放到salt目录下执行状态，就会自动部署好openstack环境。
