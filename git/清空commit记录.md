把项目提交到 GitHub 上，有时候可能不小心提交了一些隐私信息，如密码和邮箱。 又或者仓库曾经上传后来有删除了一些二进制文件，这些都保存在历史记录中，造成 clone 体积巨大。  
如何删除这些记录，形成一个全新的仓库，并且保持代码不变呢？

- 新建一个空白分支
```bash
git checkout --orphan latest_branch
```
- 添加所有文件
```bash
git add -A
```
- 提交
```bash
git commit -am "init"
```
- 强制删除旧的分支，如果是 `master`，删除分支前可能需要先切换到新分支 `git checkout latest_branch`
```bash
git branch -D master
```
- 将当前分支重命名为 `master`
```bash
git branch -m master
```
- 强制推送到远程仓库
```bash
git push -f origin master
```
