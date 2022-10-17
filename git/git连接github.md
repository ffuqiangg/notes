## 本地配置

1. 配置本地 git 用户信息  
```bash
git config --global user.name "yourname"
git config --glabal user.email "your@email.com"
// --global 参数表示本地所有仓库均采用此配置
```
2. 生成 ssh 公钥
```bash
ssh-keygen -t rsa -C "your@email.com"
// 三次回车即可生成 sshkey，这里的邮箱最好保持与之前一致
cat ~/.ssh/id_rsa.pub
// 输出内容即为 sshkey，全部复制
```

## github 设置

登录 github 进入账户`setting`页面，左侧导航进入`SSH and GPG keys`，点击右侧`New SSH keys`按钮添加 sshkey    
`Title`任意命名 `Key`粘贴入前一步复制的内容 `Key type`保持默认，然后点击`Add SSH key`按钮完成设置。
