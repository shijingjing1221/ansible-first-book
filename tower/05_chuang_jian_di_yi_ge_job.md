# 创建第一个Job

在前面介绍过Tower的Job是ansible中playbook的一次执行，也是Tower中Job template的一次的执行。

## 思路

我们先来屡屡思路，然后再上图来说明创建第一个Job的具体过程。

在ansible中，第一次执行playbook，我们需要做什么准备工作呢。

1. 首先确定要管理的远程主机
   * 即编辑inventory
2. 配置连接远程主机的SSH连接
   * ssh-genkey && ssh-copy-id
3. 编写或者下载playbook的脚本
4. 执行命令 `ansible-playbook helloword.yml`

在tower中创建第一次Job也是类似的：  
1. 确定要管理的远程主机

* 对应tower菜单栏的inventory页面创建一个新的inventory
  1. 配置连接远程主机的SSH连接
* 在tower的setting页面创建一个CREDENTIAL
  1. 编写或者下载playbook的脚本
* tower中project对应playbook的文件或者git/svn repo
* 创建一个新的project，包含执行playbook的文件或者git/svn repo地址
  1. 把需要执行一次playbook的信息组合起来
* 创建JOB TEMPLATE，指定inventory, inventory, project，以及选择project下哪个playbook
* 点击创建JOB TEMPLATE的执行按钮，就会自动跳转到JOB页面的下面看到实时的值ixng结果

## 示例

我们配合截图来说明创建第一个JOB的过程，为了尽量简化配置，我们把需要管理的远程主机就设定为tower当前所在的机器。

第一步：创建inventory

在这里只需要为inventory添加一个主机记录，就是当前tower所在的主机，即localhost。

1. 点击菜单栏里的INVENTORIES

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-1.png?t=1482430738929&width=604&height=113&name=tower-setup-guide-1.png)

2. 在inventories页面，点加按钮加号“+ADD”来添加一个新的inventory

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-2.png?t=1482430738929&width=426&height=201&name=tower-setup-guide-2.png)

3. 给新的inventory起名字后，点击保存按钮“SAVE”

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-3.png?t=1482430738929&width=354&height=206&name=tower-setup-guide-3.png)

4. 保存后会跳转到下一页，如下图，点击添加主机按钮“+ADD HOST”来添加新的主机

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-4.png?t=1482430738929&width=426&height=201&name=tower-setup-guide-4.png)

5. 给主机命名，然后添加连接的变量。  
   ansible默认的连接方式是ssh，如果用ssh不需要添加参数。连接本机是不走ssh协议的，所以需要添加一个ansible\_connection变量来告诉ansible不要用ssh，而是用local的方式直接控制本地。

   更多的非ssh的连接方式可以参考官方文档中的 [ansible\_connection参数说明](http://docs.ansible.com/ansible/intro_inventory.html#non-ssh-connection-types)

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-5.png?t=1482430738929&width=495&height=300&name=tower-setup-guide-5.png)

   到这里需要管理本机inventory已经创建好了。

第二步：创建CREDENTIAL

CREDENTIAL是用来登陆告诉Tower怎么来登陆或者连接远程的目标主机的，因为使用的是本地，不存在登陆授权的问题，所以只需要创建一个空的CREDENTIAL就可以了。

1. CREDENTIAL在SETTING页面的，点击右上角齿轮按钮，再选择CREDENTIAL

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-9.png?t=1482430738929&width=403&height=296&name=tower-setup-guide-9.png)

2. 在CREDENTIAL页面，点击添加按钮“+ADD”来添加一个Credential

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-2.png?t=1482430738929&width=426&height=201&name=tower-setup-guide-2.png)

3. 给Credential起名字，选择类型后点击保存按钮“SAVE”  
   需要SSH连接的，在Credential的类型中都选MACHINE，本机连接不需要也选择MACHINE，不填写任何的SSH连接参数就可以了。更多的Credential的类型请参考[官网的Credential Type定义](http://docs.ansible.com/ansible-tower/latest/html/userguide/credentials.html#credential-types)

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-10.png?t=1482430738929&width=534&height=179&name=tower-setup-guide-10.png)

第三步： 创建PROJECT

Playbook保存在git或者svn这样的SCM的Repo上，这样无论是历史记录的保存，还是更新都很方便，所以一般也都是放在SCM的Repo中。

如果要是将Playbook放在私有的SCM中，还需要为SCM配置Credential，为了简化Demo中PROJECT步骤，我们将Playbook放置在Github上，无需特别的权限就可以访问Playbok代码。这样在PROJECT中只需要配置GIT的地址就可以了。

1. 点击左上角的菜单栏中的“PROJECT”

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-7.png?t=1482430738929&width=604&height=113&name=tower-setup-guide-7.png)

2. 在Projects网页中，点击添加按钮“+ADD”来添加一个Project  
   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-2.png?t=1482430738929&width=426&height=201&name=tower-setup-guide-2.png)

3. 命名Project，选择SCM Type和SOURCE DETAILS，然后点击保存按钮“SAVE”  
   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-6.png?t=1482430738929&width=538&height=389&name=tower-setup-guide-6.png)

第四步：创建JOB TEMPLATE

现在我们把所有的信息整合起来，创建一个Job Template来告诉Tower如何运行Playbook

1. 点击左上角的菜单栏中的“JOB PROJECT”

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-12.png?t=1482430738929&width=604&height=113&name=tower-setup-guide-12.png)

2. 在Job Templates页面上，点加添加按钮“+ADD”来添加一个Job Template

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-2.png?t=1482430738929&width=426&height=201&name=tower-setup-guide-2.png)

3. 命名Job Templates

   INVENTORY和PROJECT会立即添加进来，因为目前为止你的Tower中只有唯一的INVENTORY和PROJECT。

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-15.png?t=1482430738929&width=548&name=tower-setup-guide-15.png)

4. 选择JOB TYPE，选择运行的PLAYBOOK文件，然后点击保存按钮“SAVE”

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-14.png?t=1482430738929&width=525&name=tower-setup-guide-14.png)

   到这里为止JOB Template已经创建好了。

5. 保存JOB TEMPLATE后，向下滚动，找到你刚创建的JOB TEMPLATE，点击小飞机按钮来执行。

   ![](https://www.ansible.com/hs-fs/hubfs/2016_Images/Resources/tower-setup-guide-13.png?t=1482430738929&width=338&height=110&name=tower-setup-guide-13.png)

   蹦蹦蹦蹦，就自动跳转到JOBS页面下面实时看到结果啦。

   ![](/tower/first-demo-job-result.png)



