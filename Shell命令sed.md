## 语法
```
sed [-hnV][-e<script>][-f<script文件>][文本文件]
```
#### 参数说明
| 选项                               | 作用                                       |
| ---------------------------------- | ----------------------------------------- |
| -e<script>或--expression=<script>  | 以选项中指定的script来处理输入的文本文件。    |
| -f<script文件>或--file=<script文件> | 以选项中指定的script文件来处理输入的文本文件。|
| -h或--help                         | 显示帮助。                                  |
| -n或--quiet或--silent              | 仅显示script处理后的结果。                   |
| -V或--version                      | 显示版本信息                               |

#### 动作说明
| 代码 | 说明                                                                                       |
| ---- | ----------------------------------------------------------------------------------------- |
| a    | 新增，a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～                            |
| c    | 取代，c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！                                    |
| d    | 删除，因为是删除啊，所以 d 后面通常不接任何东东                                               |
| i    | 插入，i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；                            |
| p    | 打印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～                               |
| s    | 取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正则表达式！例如 1,20s/old/new/g 就是啦 |

## 实例
#### 添加插入行
在 testfile 文件的第四行后添加一行，并将结果输出到标准输出，命令如下：
```bash
sed -e '4a\newLine' testfile 
        ||   | \ 之后为要添加的内容
        || a表示之后添加一行
        | 4表示以第四行为坐标
```
如果要在第四行之前添加行，修改代码 `a` 为 `i` 即可：
```bash
sed -e '4i\newline' testfile
```
如果是要增加两行以上，在第二行后面加入两行字，例如 Drink tea or ..... 与 drink beer?
```bash
sed -e '2a Drink tea or ......\
drink beer ?' testfile        | 行末的 \ 表示换行
```
另一种换行标记也可以使用 `\n` 换行符，代码如下：
```bash
sed -e '2a Drink tea or ......\ndrink beer ?'
                               | \n 作为换行标记下一行内容无需换行书写
```
在上面的例子中，坐标行不一定为行号，也可以使用字符串定位
```bash
sed -e '/target/a\newline' testfile
           | 表示文件中含 target 的行作为坐标
```
#### 删除行
实际书写时 `-e` 是可以省略的，另外，如需在 `''` 范围内使用变量，必须将单引号 `''` 替换为双引号 `""`：
```bash
sed '2,5d' testfile
     |  | d 表示删除
     | 2,5 表示从第二行开始至第五行结束

sed '2d' testfile
     | 2d 表示单独删除第二行

sed '3,$d' testfile
     | 3,$ 表示从第三行开始至最后一行，$ 表示最后  
```
#### 以行为单位的替换与显示
将第 2-5 行的内容取代成为 No 2-5 number：
```bash
sed '2,5c No 2-5 number' testfile
      | |   | No 2-5 number 为替换内容
      | | c 表示替换
      | 2,5 表示替换目标为第二至第五行
```
仅列出 testfile 文件内的第 5-7 行：
```bash
sed -n '5,7p' testfile
```
#### 数据的搜寻并显示
搜索 testfile 有 `oo` 关键字的行：
```bash
sed -n '/oo/p' testfile
```
#### 数据的搜寻并删除
删除 testfile 所有包含 `oo` 的行，其他行输出
```bash
sed '/oo/d' testfile
```
#### 数据的搜寻并执行命令
搜索 testfile，找到 `oo` 对应的行，执行后面花括号中的一组命令，每个命令之间用分号分隔，这里把 `oo`` 替换为 `kk`，再输出这行：
```bash
cat testfile | sed -n '/oo/{s/oo/kk/;p;q}'
```
最后的 `q` 是退出。
#### 数据的查找与替换
sed 的查找与替换的与 vi 命令类似，语法格式如下，其中命令 `g` 表示全局替换，如果没有该命令则仅替换第一个出现的字串：
```bash
sed 's/要被取代的字串/新的字串/g'
```
选项 `i` 使 sed 修改文件，没有参数 `i` 则仅打印处理后的结果而不修改源文件，文件名使用通配符可以同时对多个文件进行处理：
```bash
sed -i 's/oo/kk/g' testfile
```
将命令中新字串部分留空即可实现删除源字串的效果：
```bash
sed -i 's/oo//g' testfile
```
接下来我们使用 /sbin/ifconfig 查询 IP：
```bash
$ /sbin/ifconfig eth0
eth0 Link encap:Ethernet HWaddr 00:90:CC:A6:34:84
inet addr:192.168.1.100 Bcast:192.168.1.255 Mask:255.255.255.0
inet6 addr: fe80::290:ccff:fea6:3484/64 Scope:Link
UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
.....(以下省略).....
```
本机的 ip 是 192.168.1.100。

将 IP 前面的部分予以删除：
```bash
$ /sbin/ifconfig eth0 | grep 'inet addr' | sed 's/^.*addr://g'
                             |                    | 删除从行首至 addr: ，^ 表示行首，同通配符 * sed 中替换为 .*
                             | grep 命令提取出包含 inet addr 的行
192.168.1.100 Bcast:192.168.1.255 Mask:255.255.255.0
```
接下来则是删除后续的部分，即：192.168.1.100 Bcast:192.168.1.255 Mask:255.255.255.0。

将 IP 后面的部分予以删除:
```bash
$ /sbin/ifconfig eth0 | grep 'inet addr' | sed 's/^.*addr://g' | sed 's/Bcast.*$//g'
                                                                           | $ 表示行尾
192.168.1.100
```
#### 多点编辑
一条 sed 命令，删除 testfile 第三行到末尾的数据，并把 HELLO 替换为 RUNOOB :
```bash
sed -e '3,$d' -e 's/HELLO/RUNOOB/' testfile
```
-e 表示多点编辑，此时 -e 不能省略
#### 直接修改文件内容(危险动作)
sed 可以直接修改文件的内容，不必使用管道命令或数据流重导向！ 不过，由于这个动作会直接修改到原始的文件，所以请你千万不要随便拿系统配置来测试！ 我们还是使用文件 regular_express.txt 文件来测试看看吧！

regular_express.txt 文件内容如下：
```bash
$ cat regular_express.txt 
runoob.
google.
taobao.
facebook.
zhihu-
weibo-
```
利用 sed 将 regular_express.txt 内每一行结尾若为 . 则换成 !
```bash
$ sed -i 's/\.$/\!/g' regular_express.txt
$ cat regular_express.txt 
runoob!
google!
taobao!
facebook!
zhihu-
weibo-
```
利用 sed 直接在 regular_express.txt 最后一行加入 # This is a test:
```bash
$ sed -i '$a # This is a test' regular_express.txt
$ cat regular_express.txt 
runoob!
google!
taobao!
facebook!
zhihu-
weibo-
# This is a test
```
由於 $ 代表的是最后一行，而 a 的动作是新增，因此该文件最后新增 # This is a test！