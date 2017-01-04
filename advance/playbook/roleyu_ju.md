# Role语句


比include更强大的代码重用机制。一个role可以包含vars, tasks, and handlers等等. 通常一个role定义了如何完成一个特定的功能,比如安装Webservers可以写成一个role, 安装Database可以写成一个role。

Ansible提供了一个分享role的平台, https://galaxy.ansible.com/, 在galaxy上可以找到别人写好的role。


## 定义role完整的目录结构


在编程语言中，通过遵循特点的语法定义函数。**在ansible中,通过遵循特定的目录结构,就可以实现对role的定义.**。具体遵循的目录结构是什么呢？看下面的例子：

下面的目录结构定义了一个role：名字为myrole。在site.yml，调用了这个role。


<table>
    <tr>
        <td>
            role的目录结构
        </td>
        <td>
            site.yml中的调用role
        </td>
    </tr>
    <tr>
        <td>
            <pre>
<code class='lang-yml'>
site.yml
roles/
├── myrole
    ├── tasks
    │   └── main.yml
    ├── handlers
    │   └── main.yml
    ├── defaults
    │   └── main.yml
    ├── vars
    │   └── main.yml
    ├── files
    ├── templates
    ├── README.md
    ├── meta
    │   └── main.yml
    └── tests
        ├── inventory
        └── test.yml


</code>
</pre>
        </td>
        <td>
            <pre>
<code>
---
- hosts: webservers
  roles:
     - myrole
</code>
</pre>

        </td>
    </tr>
</table>

ansible并不要求role包含上述所有的目录及文件，根据role的功能需要加入对应的目录和文件。下面是每个目录和文件的功能。

* 如果 roles/x/tasks/main.yml 存在, 其中列出的 tasks 将被添加到 play 中
* 如果 roles/x/handlers/main.yml 存在, 其中列出的 handlers 将被添加到 play 中
* 如果 roles/x/vars/main.yml 存在, 其中列出的 variables 将被添加到 play 中
* 如果 roles/x/meta/main.yml 存在, 其中列出的 “角色依赖” 将被添加到 roles 列表中
* roles/x/tasks/main.yml中所有tasks 可以引用 roles/x/{files,templates,tasks}中的文件，不需要指明文件的路径。

你自己在写role的时候，一般都要包含入口文件roles/x/tasks/main.yml，其它的文件和目录，可以根据需求选择加入。

## 带参数的Role

### 定义带参数的role

 定义一个带参数的role,名字是role_with_var,那么目录结构为

 ```
 main.yml
 roles
   role_with_var
     tasks
       main.yml
 ```

 在roles/rolw_with_var/tasks/main.yml中,使用```{{ }}```定义的变量就可以了

 ```
 ---
 - name: use param
   debug: msg="{{ param }}"

```
### 使用带参数的role

那么在main.yml就可以用如下的方法使用role_with_var

```
---

- hosts: webservers
  roles:
    - { role: role_with_var, param: 'Call some_role for the 1st time' }
    - { role: role_with_var, param: 'Call some_role for the 2nd time' }
```

### role指定默认的参数

指定默认参数后,如果在调用时传参数了,那么就使用传入的参数值.如果调用的时候没有传参数,那么就使用默认的参数值.

指定默认参数很简单,以上面的role_with_var为例

```
main.yml
roles:
  role_with_var
    tasks
      main.yml
    defaults
      main.yml
```
在roles/role_with_var/defaults/main.yml中,使用yml的字典定义语法定义param的值,如下:
```
param: "I am the default value"
```

这样在main.yml中,下面两种调用方法都可以

```
---

- hosts: webservers
  roles:
    - role_with_var
    - { role: role_with_var, param: 'I am the value from external' }

```
更多的例子在https://github.com/shijingjing1221/ansible-first-book-examples/blob/master/role_vars.yml 中


## role与条件语句when一起执行


下面的例子中,some_role只有在RedHat系列的server上才执行.
```
---

- hosts: webservers
  roles:
    - { role: some_role, when: "ansible_os_family == 'RedHat'" }

```


## roles和tasks的执行顺序

pre_tasks > role > tasks > post_tasks

```
---

- hosts: lb
  user: root

  pre_tasks:
    - name: pre
      shell: echo 'hello'

  roles:
    - { role: some_role }

  tasks:
    - name: task
      shell: echo 'still busy'

  post_tasks:
    - name: post
      shell: echo 'goodbye'
```
