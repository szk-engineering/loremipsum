LoremIpsum
==========

> LastModified: 2014-08-10

[TOC]

# GitHub Lecture for szk-engineering
社内研修用．

## Make GitHub Account
何はともあれ，はじめにGitHubのアカウントを作ります．

### Register your SSH key
アカウントを作ったら，公開鍵を登録します．

ローカル環境の~/.ssh/configもこんな感じで変更しておくと良いかも．

```shell
Host github-private
  User git
  Port 22
  HostName github.com
  IdentityFile ~/.ssh/github-private_rsa
  TCPKeepAlive yes
  IdentitiesOnly yes
```

## Make own repository
自分のアカウントでレポジトリを作ってみる．

```shell
$ git init
```

## Watch someone's repository
誰かのレポジトリをwatchして，どんな風に使ってみるか見てみる．

## Clone someone's repository
誰かのレポジトリをローカルにcloneしてみる．

```shell
$ git clone <url>
```

URLは各レポジトリ画面の右下にある．
gitやhttps，sshなど様々なプロトコルを選べるけど，基本的にどれでもいい．
その下にある"Clone in Desktop"はGitHub謹製のGUIアプリ経由で使う場合．
"Download ZIP"はgit cloneでなく，単にファイルとして欲しい時(gitをインストールしてない環境で，とりあえず見てみたい時など)に使う．

## Push your modification
ローカルで加えた変更点をリモートのレポジトリに反映してみる．

(何らかの変更) → add(to working tree) → → commit(to index) → push(to remote repository) の順．

### Change something
なんでも良いから書き換えてみる．revert(元に戻す)できるのがGitの良いところなので，失敗を恐れずに．
とは言え，README.mdを書き換えるのが一番手ごろ．

#### Markdown environment
README.md(Markdown)ファイルをいじるのにおすすめの環境は…

* Sublime Text 3
  - OmniMarkupPreview
  - Theme: AfterGlow

SublimeTextはConvertToUTF8など，入れるべきプラグインが幾つかあるけど，ここでは割愛．

#### GitHub Flavored Markdown
GitHubで使えるMarkdown特殊記法も使いこなせるとかっこいい．
checkboxとか．この辺を参照．

https://help.github.com/articles/github-flavored-markdown

### "Add" your modification
Gitでは変更点を追跡するかどうか，add/rmしながら使う．
基本的に全部追跡しちゃえば良い．

```shell
$ git add .
```

追跡中のファイルたちを*working tree*って言ったりする．

#### gitignore
全部追跡とは言え，追跡してもしょうがないlogファイルとか不可視ファイルもあるので，ignore(無視)設定しておくと良い．

MacOSXだったら，下記はdefaultかな．
```shell
.DS_Store
.AppleDouble
.LSOverride

Icon

._*

.Spotlight-V100
.Trashes

.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk
```

ホームディレクトリ(~/)に.gitignoreってファイルを作れば，すべてのレポジトリで当該ファイルを無視してくれる．

#### gitconfig
gitignoreの話をしたので，ついでにgitconfigも．

CUIから追記するには…
```shell
$ git config --global user.name <username>
$ git config --global user.email <email>

```

~/.gitconfigに直接書いてもOK．

```shell
[user]
  name = Kouhei BABA
  email = kouhei@szk-engineering.com
[color]
  ui = true
[alias]
  co = checkout
  ci = commit
  st = status
  br = branch
  graph = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
  hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short
[core]
  excludesfile = ~/.gitignore
```

### Commit!
変更追跡するファイルを追加したら，実際に変更点をまとめて*index*に追加する．

```shell
$ git commit -m "<comment>"
```

*<comment>*のところで変更点を具体的に書いておく．
どんなタイミングでcommitするかは後述．

cf. http://qiita.com/ken_c_lo/items/4cb49f0fb74e8778804d

### Push your modification
ローカルの変更をリモートにも反映させる．

```shell
$ git push origin master
```

*origin*と*master*が何を意味するかは後述．

#### Add remote repository
cloneしてないレポジトリの場合，そもそもリモートレポジトリがどこにあるか教えてあげないといけない．

```shell
$ git remote add <name> <url>
```

*<name>*が前述の*origin*に相当します．
GitHubなら*github*にするとか，自分にしか見えないところなのでわかりやすく自由に．

## Pull our modification
他の人が加えた変更点を自分のローカルに反映するとき．

```shell
$ git pull origin master
```

*master*が何を意味するかは後述．

## Make(& change) branches
gitの機能として，本流とわけて試したいときなどはbranchを切って，独自の開発路線を作っていくことができます．
最初は*master*というbranch上で開発をしているので，本流=*master*という理解でOK．

```shell
$ git checkout -b <branchename>
```

*-b*オプションを付けることで，*branchname*というbranchを作成しながら，*branchname*での作業を開始できます．
既に作成してあるbranchに移る場合は*-b*は不要．

### Change branches
branchを分けるとややこしくなると言えばややこしくなるので，ここでちょっと整理．

```shell
$ git checkout
```
とすると，今，自分がいるbranchが表示されるので適宜確認．

基本的に，branchが違えば何をしてもOKなので，うまくいくかわかんない時や試してみたい時には積極的にbranchを切る．
その後，うまく行った場合には後述するmarge作業をして，本流に反映する．

## Marge modifications
branchを切った後や，または他の人の変更点と範囲が重なる変更をした場合，marge(統合)してあげなければいけない．

// TODO: あとでゆっくり書く

特に後者「他の人の変更点と範囲が重なる変更」はpushする前にこまめにpullしたりするだけで省けたりするので習慣化推奨．

## その他のよく使うGitコマンド

### mv /rm
Gitを使っていてちょっと面倒なのが，ファイル名の変更や削除．
OSのファイラからいじるとworking treeに残ったままになったりするので，Gitのコマンドから変更(移動)/削除するのがbetter．

```shell
$ git mv <src_filename> <dst_filename>
$ git mv <filename>
```

うっかりworking treeに残ったファイルをどうにかしたいときはcleanする．

```shell
$ git clean -f
```
"-f"で強制的にcleanしてしまうので，それが怖い場合には"-n"でcleanされるファイルを確認してから行うと良い．

### diff
差分を表示するときに使う．

たとえば，ファイルの差分を表示するときは…

```shell
$ git diff <filename>
```

よく使うのは，commitしてないworking treeとの差分．
```shell
$ git diff --cached
```

### status
working treeの状態を表示する．

```shell
$ git status
```

### log
commitのログを表示する．

```shell
$ git log
```

### shortlog
logより要約度の高いlog．

```shell
$ git shortlog
```

#### log --graph
logのオプションで，ちょっと綺麗な履歴表示が可能．

```shell
$ git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
```

もちろん，いちいちこんなに長く打ってられないので，gitconfigにaliasを書いておくと吉．

## Learn flow
ここまででGitの基本的なコマンドは習得したので，これらを実践的に組み合わせてみる．

### Git Flow as reference
git-flowという「こうやるとうまくいくよ」という手法がある．
そのまま適応させるかは別にして，知っておくと吉．

#### Git Flow: ポリシー

* *master*に直接変更を加えない
  - すべての変更は事前にbranchを切ってから，それをmargeする形で*master*に反映していく
* *master*は完動する状態以外許さない
  - *master*はいつでも本番環境にdeployして良いようにしておく
* 各branchへのcommitもテストを通ったものしか許さない
  - ただ変更しましたーって言うcommitはしない

#### Git Flow: branchの分け方

* feature
* hotfix
* // TODO: あとでゆっくり書く

#### Git Flow: 利点

commitログがすっきりして変更履歴を追いやすい．
branchごとに担当者が分けやすくて管理しやすい．
branchごとに何をしなければいけないか明確化されてて作業しやすい．
masterはいつでも動くという安心感．

#### Git Flow: 注意点

変更履歴は追いやすくなるけど，進行中の作業は追いにくい．
branch切ったりmargeしたりする回数が増えて，正直めんどい．
テストを自動化しておかないと回せない．
小規模な開発や実験的な開発で適応するといちいちcommitしにくくて困る．
「マスター，…返事がない，ただの屍のようだ」

### GitHub Flow and szk-engineering's Flow
GitHubを使ってGit Flowっぽいことをやろう，っていうか，更にそれを改良して，szk-engineering流はこんな感じだよ．

### szk-engineering's Flow: ポリシー
* // TODO: あとでゆっくり書く

### szk-engineering's Flow: branchの分け方
* // TODO: あとでゆっくり書く

### szk-engineering's Flow: 注意点
* // TODO: あとでゆっくり書く

## Make Pull-Request
GitHubの肝．
// TODO: あとでゆっくり書く

## Try surrounding services
GitHubが使えるようになったら，GitHubの周辺にも手を出してみよう．

### Travis CI
// TODO: あとでゆっくり書く

### Heroku
// TODO: あとでゆっくり書く

### Gitter
https://gitter.im/szk-engineering
// TODO: あとでゆっくり書く

### Hubot
// TODO: あとでゆっくり書く