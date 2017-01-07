# 安装方法

如果你只是想体验下ansible tower，那么它的安装方法极其简单，只需要运行一个bash脚本就可以。当然在这个bash中，是调用ansible来ansible tower才能做到这么简单的。

all-in-one版就是所有的ansible tower的组件，服务器，数据库都安装在一台机器上，只需要遵循以下步骤就可以了：

准备一台RHEL7的裸机器，注册redhat，或者CentOS7。

## 下载并安装

1. 下载安装包
   1. 下载网站 [https://releases.ansible.com/ansible-tower/setup-bundle/](https://releases.ansible.com/ansible-tower/setup-bundle/)，我下载的版本是ansible-tower-setup-bundle-3.0.3-1.el7.tar.gz
   2. 拷贝到准备安装tower的机器中
   3. 解压
      `tar xvf ansible-tower-setup-bundle-3.0.3-1.el7.tar.gz`
2. 编辑 inventory  
    解压后ansible-tower-setup-bundle-3.0.3-1的文件夹中默认的inventory是下面这样的，你需要至少修改下admin_password， redis_password， pg_password的值为你想设置的密码。

   ```
   [primary]
   localhost ansible_connection=local

   [secondary]

   [database]

   [all:vars]
   admin_password='password'
   redis_password='password'

   pg_host=''
   pg_port=''

   pg_database='awx'
   pg_username='awx'
   pg_password='password'
   ```

3. 运行 ./setup.sh  
   请注意tower对硬件的要求，如果没有达到下面的要求，执行安装脚本的过程会中断并提示硬件没有满足要求：

   * 2G+内存

   * 20G专用硬盘

   * 64位操作系统

   * 更详细的，请看[这里](http://docs.ansible.com/ansible-tower/3.0.3/html/installandreference/requirements_refguide.html#ir-requirements)

## 初始化网站

1. 修改admin的密码

   ```
   tower-manage changepassword admin
   ```

2. 安装成功，访问你的ansible tower吧

   1. 如果你安装ansible tower的hostname是ansibletower.example.com, 那么访问 [https://ansibletower.example.com/](https://ansibletower.example.com/)

   2. 用用户名admin和你修改后的密码登陆

   3. 第一次登陆后，会提供你提供licences文件。  
      ![](http://docs.ansible.com/ansible-tower/latest/html/userguide/_images/no-license.png)

3. 申请Licences

Ansible Tower提供了免费使用的Licences，永不过期，不过限制在管理10个一下主机。只是不能用一些LDAP等高级特性。不过这不影响我们体验和学习。去[这里](https://www.ansible.com/license)申请一个把。

## 访问你的页面吧

1. 你的第一个页面

![](/tower/main_dashboard.png)
