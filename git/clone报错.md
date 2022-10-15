clone 仓库时报错：
```bash
kex_exchange_identification: Connection closed by remote host
```
原因不明，通过网上搜索发现可以用一下办法解决：
```bash
vim ~/.ssh/config 
// 修改.ssh/config 为并保存退出：
Host github.com
  HostName ssh.github.com
  User git
  Port 443
// 终端执行  ssh -T git@github.com 
```
