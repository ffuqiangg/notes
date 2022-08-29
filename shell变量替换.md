## 获取变量字符串长度
想要知道```"www.baidu.com"```的变量```net```的长度十分简单，通过```${#net}```即可获取。
```bash
[Neptuneyt]$ net="www.baidu.com"
[Neptuneyt]$ echo ${#net}
13
```
当然，在Shell中获取字符串变量的长度的方法有许多种，但是```${#variable}```作为一种系统内建的方法是最快的。
```bash
[Neptuneyt]$ echo ${#net}
13
[Neptuneyt]$ echo ${net}|wc -L
13
[Neptuneyt]$ expr length ${net}
13
[Neptuneyt]$ echo ${net}|awk '{print length($0)}'
13
```

## 变量的截取
字符串的截取有多种方式，常见的包括：
### 指定位置截取字符串
```bash
[Neptuneyt]$ net="www.baidu.com"
[Neptuneyt]$ # 从第4个字符截取到baidu
[Neptuneyt]$ echo ${net:4:5} #从第4个字符.开始截取5个字符
baidu
[Neptuneyt]$ # 截取baidu.com
[Neptuneyt]$ echo ${net:4}   #起始位置后不接截取字符长度则默认截取之后所有的
baidu.com
[Neptuneyt]$ # 用倒数截取com
[Neptuneyt]$ echo ${net:0-3} #从倒数第三个字符截取到末尾
com
[Neptuneyt]$ echo ${net: -3} #另外的写法，一定要注意冒号和-3之间有空格
com
[Neptuneyt]$ echo ${net:-3}  #不加空格，截取失败
www.baidu.com
```
### 匹配字符串截取
```bash
[Neptuneyt]$ echo $net
www.baidu.com

# 删除匹配字符串的左边，留下剩余部分
[Neptuneyt]$ echo ${net#*.} #这里用*.表示匹配到www.，用一个#表示删除匹配到的字符串，留下剩余的部分
baidu.com

# 用2个#号表示尽可能多的删除匹配到的字符串
[Neptuneyt]$ echo ${net##*.}
com

# 同理也可以匹配字符串的右边，留下剩余部分
[Neptuneyt]$ echo ${net%.*} #用.*匹配到.com,用%删除
www.baidu

# 用2个%号表示尽可能多的删除匹配到的字符串
[Neptuneyt]$ echo ${net%%.*}    #因为2个%，这里.*表示匹配到最长的.baidu.com
www
```

总的来说:
```#*chr```表示删除从左到右第一个遇到的字符chr及其左侧的字符
```##*chr```表示删除从左到右最后一个遇到的字符chr及其左侧的字符（贪婪模式）
```%chr*```表示删除从右向左第一个遇到的字符chr及其右侧的字符
```%%chr*```表示删除从右到左最后一个遇到的字符chr及其右侧的字符（贪婪模式）
在键盘上，#在$符的左边，%号在$符的右边，为了便于记忆，大家因此可以记住#删除左边字符，%删除右边字符
## 变量的字符串替换
想要将```net```的 ```baidu```替换成```google```怎么写呢？只需```${net/baidu/google}```即可，需要注意的是原变量并未修改
```bash
[Neptuneyt]$ echo ${net/baidu/google} #/匹配字符/替换字符
www.google.com
[Neptuneyt]$ echo $net  #原变量并未修改
www.baidu.com
```
如果是替换所有匹配到的字符，应该通过```${variable//pattern/sub}```
例如将```net```的```.```替换为```-```或```/```：
```bash
[Neptuneyt]$ echo ${net//./-}
www-baidu-com
[Neptuneyt]$ echo ${net//.//}
www/baidu/com
```
除此之外，还有两种专门针对字符串开头和结尾的替换方式
只替换开头匹配的字符串```${variable/#pattern/sub}```
只替换结尾匹配的字符串```${variable/%pattern/sub}```
例如对于```add=www.xiaomi.com.www```的开头或者结尾的```www```替换为```-```：
```bash
[Neptuneyt]$ add=www.xiaomi.com.www
[Neptuneyt]$ echo ${add/#www/-}
-.xiaomi.com.www
[Neptuneyt]$ echo ${add/%www/-}
www.xiaomi.com.-
```

## 删除字符串
其实学会了替换字符串删除字符串就更简单了，只需将替换部分写成空即可，即```${variable/pattern/null}```，例如将```net```的第一个```.```删除，只需
```bash
[Neptuneyt]$ echo ${net/./}
wwwbaidu.com
[Neptuneyt]$ echo ${net/.}  #最后一个/可以不用写
wwwbaidu.com
```
若要删除所有匹配到的只需即```${variable//pattern}```，例如将```net```的```.```都删除，只需
```
[Neptuneyt]$ echo ${net//.}
wwwbaiducom
```
同理，只删除开头或者结尾匹配到的字符也是类似操作，这里就不赘述了。

## 变量为空时赋默认值
当我们在写脚本时往往需要给脚本传递一些参数，在Shell中传递参数十分简单，只需利用特殊的位置参数变量诸如```$1,$2,$3...${10}...```即可，例如，以下脚本传递2个参数：
```bash
# PassArgument.sh
#!/bin/env bash
# pass 2 arguments
arg1=$1
arg2=$2
echo $arg1 $arg2

[Neptuneyt]$ bash PassArgument.sh Hello word #参数以空格隔开
Hello word
```
有时候，我们想省掉最后一个参数，让它使用默认值，这个时候只需通过```${variable:='default value'}```即可，即当变量有值的时候则使用原值，若没有值则使用括号中默认定义好的值。例如，如下脚本表示当第二个参数为空时默认使用定义好的值“word”,否则是用户自己传递的参数：
```bash
# PassArgument.sh
#!/bin/env bash
arg1=$1
arg2=$2
echo $arg1 ${arg2:='word'}  #第二个参数设置默认值

[Neptuneyt]$ bash PassArgument.sh Hello #第二个参数为空时使用默认值
Hello word
[Neptuneyt]$ bash PassArgument.sh Hello Shell   #第二个参数不为空时使用参数传递的值
Hello Shell
```

除了```${variable:='default value'}```外，还有```${variable:-'default value'}```,```${variable:+'default value'}```和```${variable:？'default value'}```，它们有什么区别呢？
对于```${variable:='default value'}```，表示变量为空时把默认值赋值给该变量，例如：
```bash
[Neptuneyt]$ net=
[Neptuneyt]$ echo ${net:='www.baidu.com'}
www.baidu.com
[Neptuneyt]$ echo $net
www.baidu.com
```
对于```${variable:-'default value'}```,表示变量为空时返回默认值**但是并不把默认值赋值给该变量，** 例如：
```bash
[Neptuneyt]$ net=
[Neptuneyt]$ echo ${net:-'www.baidu.com'}
www.baidu.com
[Neptuneyt]$ echo $net  #此时，变量依旧为空
```
对于```${variable:+'default value'}```,则表示变量不为空时，返回默认值，并且也不重新赋值，例如：
```bash
[Neptuneyt]$ net=www.baidu.com
[Neptuneyt]$ echo ${net:+'www.google.com'}
www.google.com
[Neptuneyt]$ echo $net  #不改变变量原值
www.baidu.com
```
最后，对于```${variable:？'default value'}```,则表示当变量为空时，使用bash风格的报错，例如：
```bash
[Neptuneyt]$ net=
[Neptuneyt]$ echo ${net:?'error:null value'}
-bash: net: error:null value
```