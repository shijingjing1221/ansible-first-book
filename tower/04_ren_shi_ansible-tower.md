## 认识ansible tower

我们先来点点鼠标看看tower中都有什么，不过在点鼠标之前心中应该有数，所有的功能都不会脱离三大类

1. 用户权限管理
2. 执行ansible playbook（ansible管理员节点）需要配置的
3. 统计信息

当然，ansible管理节点需要配置的东西较多，也是tower的主体功能，所以涉及的页面也会多一样。

回顾下安装后的第一个页面（如下图）。

![](/tower/main_dashboard.png)

## 主要版面

页面的主要版面是DASHBOARD面板，展示了统计信息。我们以后再详细介绍，我们目前的主要目标还是集中在理解tower各个菜单的功能。所以我们继续看页面。

## 菜单栏

页面的菜单栏，主要有四个选项。

* PROJECT
  * 每个PROJECT解决的是playbook脚本放置在哪的问题。PROJECT里面的playbook可以是tower上的本地文件夹，还可以是远程的git/svn repo。tower在合适的时间会下载到本地。
* INVENTORIES
  * tower的INVENTORIES和ansible命令行工具的inventory一样，配置需要管理的远程主机。
* JOB TEMPLATES
  * 对应完成的执行一次ansible playbook所需要完整的信息。在一个JOB TEMPLATE中需要选择以下几个信息
    * 选择需要inventory
    * 选择需要project
    * 选择project中需要执行的哪个playbook文件
* JOBS
  * 查看JOB的实时执行结果
  * 记录JOB的执行历史和状态

![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-1.png?t=1482430738929&width=604&height=113&name=tower-setup-guide-1.png)

## Admin菜单栏

右侧的菜单栏主要是一些和管理员相关的功能。从左向右我用不同颜色标注了。

* 红色
  * 管理员页面，在这个页面上可以添加创建网站普通用户，管理员，团队和组织（Organization），并赋予相应的权限。【注】免费使用license不支持创建除了默认的组织之外的组织。
* 蓝色
  * 网站设置页面
  * 管理员界面的功能，也可以在setting里面设置
  * 查看LICENSE和tower版本信息
  * 还可以设置下面几个常用的选项：
    * CREDENTIALS：SSH的登陆key，或者登陆密码
    * NOTIFICATION TEMPLATES： 通过Email和Xchat（Linux下的开源聊天软件）发消息时的配置。

![](/tower/admin_menu.png)
