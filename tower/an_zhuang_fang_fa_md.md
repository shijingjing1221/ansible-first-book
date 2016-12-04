# 安装方法

如果你只是想体验下ansible tower，那么它的安装方法极其简单，只需要遵循以下步骤就可以了：


下面的方法把所有的ansible tower的组件，服务器，数据库都安装在一台机器上。准备一台RHEL7的裸机器，注册redhat。


1. 下载安装包 https://releases.ansible.com/ansible-tower/setup-bundle/
2. 编辑 inventory
3. 运行 ./setup.sh

  请注意tower对硬件的要求：
  http://docs.ansible.com/ansible-tower/3.0.3/html/installandreference/requirements_refguide.html#ir-requirements
 
4. 修改admin的密码
  
  ```
  tower-manage changepassword admin
  ```
  
5. 安装成功，访问你的ansible tower吧