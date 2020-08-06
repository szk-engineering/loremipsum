# LoremIpsum (GitHub Lecture for sforzando LLC.(ex szk-engineering))

社内研修用。

GitとGitHubのさわりだけ。

> LastModified: 2017-11-16

- [Make GitHub Account](#make-github-account)
  - [Register your SSH key](#register-your-ssh-key)
- [Make own repository](#make-own-repository)
- [Watch someone's repository](#watch-someones-repository)
- [Clone someone's repository](#clone-someones-repository)
- [Push your modification](#push-your-modification)
  - [Change something](#change-something)
    - [Markdown environment](#markdown-environment)
    - [GitHub Flavored Markdown](#github-flavored-markdown)
  - ["Add" your modification](#add-your-modification)
    - [.gitignore](#gitignore)
    - [.gitconfig](#gitconfig)
  - [Commit!](#commit)
  - [Push your modification](#push-your-modification-1)
    - [Add remote repository](#add-remote-repository)
- [Pull our modification](#pull-our-modification)
- [Make(& change) branches](#make-change-branches)
  - [Change branches](#change-branches)
- [Marge modifications](#marge-modifications)
- [その他のよく使うGitコマンド](#その他のよく使うgitコマンド)
  - [mv / rm](#mv--rm)
  - [diff](#diff)
  - [status](#status)
  - [log](#log)
  - [shortlog](#shortlog)
    - [log --graph](#log---graph)
    - [git now](#git-now)
- [Learn flow](#learn-flow)
  - [Git Flow as reference](#git-flow-as-reference)
    - [Git Flow: ポリシー](#git-flow-ポリシー)
    - [Git Flow: branchの分け方](#git-flow-branchの分け方)
    - [Git Flow: 利点](#git-flow-利点)
    - [Git Flow: 注意点](#git-flow-注意点)
  - [GitHub Flow and szk-engineering's Flow](#github-flow-and-szk-engineerings-flow)
  - [szk-engineering's Flow: ポリシー](#szk-engineerings-flow-ポリシー)
  - [szk-engineering's Flow: branchの分け方](#szk-engineerings-flow-branchの分け方)
  - [szk-engineering's Flow: 実際の流れ](#szk-engineerings-flow-実際の流れ)
- [Make Pull Request](#make-pull-request)
- [Try surrounding services](#try-surrounding-services)
  - [Travis CI](#travis-ci)
  - [Heroku](#heroku)
  - [Hubot](#hubot)

## Make GitHub Account

何はともあれ、はじめにGitHubのアカウントを作ります。

### Register your SSH key

アカウントを作ったら、公開鍵を登録します。

ローカル環境の`~/.ssh/config`もこんな感じで変更しておくと良いかも。

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

自分のアカウントでレポジトリを作ってみる。

```shell
$ git init
```

## Watch someone's repository

誰かのレポジトリをwatchして、どんな風に使ってみるか見てみる。

素敵なレポジトリを見つけたらstarしてあげると開発者は喜ぶ、きっと。

## Clone someone's repository

誰かのレポジトリをローカルにcloneしてみる。

```shell
$ git clone <url>
```

`<url>`は各レポジトリ画面の右下にある。
gitやhttps、sshなど様々なプロトコルを選べるけど、基本的にどれでもいい。
その下にある"Clone in Desktop"はGitHub謹製のGUIアプリ経由で使う場合。
"Download ZIP"はgit cloneでなく、単にファイルとして欲しい時(gitをインストールしてない環境で、とりあえず見てみたい時など)に使う。

## Push your modification

ローカルで加えた変更点をリモートのレポジトリに反映してみる。

```
{{(何らかの変更) → add(to working tree)}を何回か繰り返してから → commit(to index)}を何回か繰り返してから → push(to remote repository)。
```

### Change something

なんでも良いから書き換えてみる。revert/reset(元に戻す)できるのがGitの良いところなので、失敗を恐れずに。
とは言え、README.mdを書き換えるのが一番手ごろ。

#### Markdown environment

README.md(Markdown)ファイルをいじるのにおすすめの環境は…

* Sublime Text 3
* Atom
* Visual Studio Code

#### GitHub Flavored Markdown
GitHubで使えるMarkdown特殊記法も使いこなせるとかっこいい。
checkboxとか。この辺を参照。

https://help.github.com/articles/github-flavored-markdown

### "Add" your modification
Gitでは変更点を追跡するかどうか、add/rmしながら使う。
基本的に全部追跡しちゃえば良い。

```shell
$ git add .
```

追跡中のファイルたちを*working tree*って言ったり、追跡状態にあることを*staging*って言ったりする。

#### .gitignore
基本的に全部追跡とは言え、追跡してもしょうがないlogファイルとか不可視ファイルもあるので、ignore(無視)設定しておくと良い。
プロジェクトのルートディレクトリに`.gitignore`を作る。

MacOSXだったら、下記は無視しておくと良い。
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

使用する言語やプラットフォームごとにオススメのgitignoreを検索できる[gitignore.io](https://www.gitignore.io)が便利。

ホームディレクトリ(に`~/.gitignore`ってファイルを作れば、すべてのレポジトリで当該ファイルを無視してくれる。

#### .gitconfig
.gitignoreの話をしたので、ついでに.gitconfigも。

CUIから追記するには…
```shell
$ git config --global user.name <username>
$ git config --global user.email <email>
```

`~/.gitconfig`に直接書いてもOK。

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

名前とメールアドレスを設定しておかないと`commit`できないので注意。

### Commit!
変更追跡するファイルを追加(= staging)したら、実際に変更点をまとめて*index*に追加する。

```shell
$ git commit -m "<comment>"
```

`<comment>`のところで変更内容を具体的に書いておく。
どんなタイミングでcommitするかは後述。

cf. http://qiita.com/ken_c_lo/items/4cb49f0fb74e8778804d

### Push your modification
ローカルの変更をリモートに反映させる。

```shell
$ git push origin master
```

`origin`と`master`が何を意味するかは[後述](#add-remote-repository)。

#### Add remote repository
cloneしてないレポジトリの場合、そもそもリモートレポジトリがどこにあるか教えてあげないといけない。

```shell
$ git remote add <name> <url>
```

`<name>`が前述の`origin`に相当します。
1つのローカルレポジトリが複数のリモートレポジトリを見ることもできるので、ニックネームをつけていると考えればOK。
GitHubなら`github`にするとか、自分にしか見えないところなのでわかりやすく自由に。

## Pull our modification
他の人が加えた変更点を自分のローカルに反映するとき。

```shell
$ git pull origin master
```

`master`が何を意味するかは[後述](#make-change-branches)。
この時、conflict(衝突)することがあるけど、その原因や解決方法については[後述](#marge-modifications)。

`git pull` git fetchとgit mergeを同時に行うコマンドです。
`git-pull` : 他のリポジトリやローカルブランチから取得して統合します。
`git-fetch` : 他のリポジトリからオブジェクトと参照をダウンロードします。
`git-merge` : 2つ以上の開発履歴を結合します。

## Make(& change) branches
gitの機能として、本流とは分けて試したいときなどはbranchを切って、独自の開発路線を作っていくことができます。
レポジトリを作ると`master`というbranchが必ずできるので、本流=`master`という理解でOK。

```shell
$ git checkout -b <branchename>
```

`-b`オプションを付けることで、`branchname`というbranchを作成しながら、`branchname`での作業を開始できます。
なので、既に作成してあるbranchに移る場合は`-b`は不要。

### Change branches
branchを分けるとややこしくなると言えばややこしくなるので、ここでちょっと整理。

```shell
$ git checkout
```
とすると、今、自分がいるbranchが表示されるので適宜確認。

```shell
$ git branch
```
とすると、レポジトリにどんなbranchがあるか一覧できる。

基本的に、branchが違えば何をしてもOKなので、うまくいくかわかんない時や試してみたい時には積極的にbranchを切る。
その後、うまく行った場合には後述するmarge作業をして、本流に反映する。

## Marge modifications
branchを切った後や、または他の人の変更点と範囲が重なる変更をした場合、marge(統合)が発生する。たいていは自動で統合してくれるけど、conflict(衝突)すると、結構めんどう。

特に後者「他の人の変更点と範囲が重なる変更」での衝突はpushする前にこまめにpullするだけでかなり省けるのでこまめにpullする習慣をつけよう。

conflictした例を紹介する。

```shell
$ git merge hoge
Auto-merging index.html
CONFLICT (content): Merge conflict in index.html
Automatic merge failed; fix conflicts and then commit the result.
```

何やらindex.htmlでうまくmergeができなかったらしい。

index.htmlを開いてみると、こんな風になっている場所があるはず。

```html
<<<<<<< HEAD
<div id="footer">contact : email.support@github.com</div>
=======
<div id="footer">
  please contact us at support@github.com
</div>
>>>>>>> hoge
```

HEADとhogeで違う記述をしている箇所があるので、どっちが正しいか判断して修正する。修正する際には記号の行も削除。

```html
<div id="footer">
  please contact us at support@github.com
</div>
```

修正後にadd→commitすればOK。

最初のうちはmerge手順がわからなかったり、どちらが正しいか判断がつかなかったりするのでレポジトリの管理者に相談しながら進めてOK。

## その他のよく使うGitコマンド

### mv / rm
Gitを使っていてちょっと面倒なのが、ファイル名の変更や削除。
OSのファイラからいじるとworking treeに残ったままになったりするので、Gitのコマンドから変更(移動)/削除するのがbetter。

```shell
$ git mv <src_filename> <dst_filename>
$ git mv <filename>
```

うっかりworking treeに残ったファイルをどうにかしたいときはcleanする。

```shell
$ git clean -f
```
"-f"で強制的にcleanしてしまうので、それが怖い場合には"-n"でcleanされるファイルを確認してから行うと良い。

### diff
差分を表示するときに使う。

たとえば、ファイルの差分を表示するときは…

```shell
$ git diff <filename>
```

よく使うのは、commitしてないworking treeとの差分。
```shell
$ git diff --cached
```

### status
working treeの状態を表示する。

```shell
$ git status
```

### log
commitのログを表示する。

```shell
$ git log
```

### shortlog
logより要約度の高いlog。

```shell
$ git shortlog
```

#### log --graph
logのオプションで、ちょっと綺麗な履歴表示が可能。

```shell
$ git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
```

もちろん、いちいちこんなに長く打ってられないので、gitconfigにaliasを書いておくと吉。

#### git now
簡単にcommitするための、"git add ."と"git commit -m <日付>"を同時に行うコマンド。
MacOSX + HomeBrew環境なら下記でインストールできる。

```shell
$ brew install --zsh-completion git-now
```

インストールが終わったら、git nowするだけ。コメントに日時と差分が纏まってcommitされる。

```shell
$ git now
$ git log
commit e3d45f97a5a1faf87a2fb3bf491dd5ea0f1644c9
Author: Shin'ichiro SUZUKI <shin@szk-engineering.com>
Date:   Wed Aug 13 11:36:26 2014 -0700

    [from now] 2014/08/13 11:36:26

    diff --git a/gitconfig b/gitconfig
    index cb6889a..24146ca 100644
    --- a/gitconfig
    +++ b/gitconfig
    @@ -3,11 +3,16 @@
       email = shin@szk-engineering.com
     [alias]
       graph = log --graph --date-order -C -M --pretty=format:\"<%h> %ad [%an] %Cgreen%d%Creset %s\" --all --date=short
    -  log = log --stat
    +  sl = shortlog
    +  sh = show
       st = status
        co = checkout
    +  rbm = rebase master
    +  gr = grep
    +  dw = diff --color-words
     [color]
        ui = true
     [core]
        editor = vim
    -
    +[push]
    +  default = tracking
```

簡単に`commit`できる一方で、ソースを読まないと変更内容がわかりにくくなるので乱用注意。

## Learn flow
ここまででGitの基本的なコマンドは習得したので、これらを実践的に組み合わせてみる。

### Git Flow as reference
git-flowという「こうやるとうまくいくよ」という手法がある。
そのまま適応させるかは別にして、知っておくと吉。

#### Git Flow: ポリシー

* *master*に直接変更を加えない
  - すべての変更は事前にbranchを切ってから、それをmargeする形で*master*に反映していく
* *master*は完動する状態以外許さない
  - *master*はいつでも本番環境にdeployして良いようにしておく
* 各branchへのcommitもテストを通ったものしか許さない
  - ただ変更しましたーって言うcommitはしない

#### Git Flow: branchの分け方

* master
  - 大元締め、常に配備可能なバグのないbranch、開発者は直接さわってはいけない
* develop
  - 開発するためのbranch、ここからfeatureを切り分ける
* feature
  - 直訳すれば"機能"、developからbranchして、ある一つの機能を実装するために使う
* release
  - featureが何個かまとまって、release(公開)するためにドキュメントの整備などを行うbranch
* hotfix
  - 発見された不具合を修正するために切るbranch、たいていはmasterから切り出す

#### Git Flow: 利点

* commitログがすっきりして変更履歴を追いやすい
* branchごとに担当者が分けやすくて管理しやすい
* branchごとに何をしなければいけないか明確化されてて作業しやすい
* masterはいつでも動くという安心感

#### Git Flow: 注意点

* 変更履歴は追いやすいけど、進行中の作業は追いにくい
* branch切ったりmargeしたりする回数が増えて、正直めんどい
* テストを自動化しておかないと回せない
* 小規模な開発や実験的な開発で適応するといちいちcommitしにくくて困る

### GitHub Flow and szk-engineering's Flow
Git Flowは大げさすぎるので、GitHubを使ってGit Flowっぽいことをもうちょっと楽にやろう、っていうか、更にそれを改良して、szk-engineering流はこんな感じだよ。

### szk-engineering's Flow: ポリシー

* *master*には直接変更を加えない(= *Git Flow*と一緒)
  - 変更前にbranchを切って、完成(= テストが通る)したら*Pull Request*(後述する)を送る
  - *Pull Request*を受けたら、mergeする前にコードレビューする
* *master*は完動する状態を保つ(= *Git Flow*と一緒)
  - *master*はいつでも本番環境にdeployして良いようにしておく
* branch切ったらcommitは適当でOK。

### szk-engineering's Flow: branchの分け方

* master
  - 大元締め、常に配備可能なバグのないbranch、開発者は直接さわってはいけない(= *Git Flow*と一緒)
* feature
  - 開発するためのbranch、1機能ずつ切り出す
  - *Git Flow*とちがって、masterから切り出す(= developは作らない)
* hotfix
  - 修正するためのbranch、1バグずつ切り出す
  - masterから切り出す

developやreleaseを作らずに簡素化。

### szk-engineering's Flow: 実際の流れ

1. レポジトリをcloneする
1. 開発する機能を決める(ex. submitボタンを付ける)
1. わかりやすい名前でbranchを切る(ex. feat_make_submit_button)
  - 機能なら"feat"、修正なら"hotfix"を付けて、アンダースコアでつないだ簡単な英文
1. 開発する
1. 開発が終わって、テストも通ることを確認する
1. commitする
1. pushする
1. Pull Requestを送る
  - Pull Requestを受け取った管理者はコードレビューしてmerge、問題なかったらbranchを削除
1. 次の開発(or 修正)へ…

※ 2017/11/16追記: 最近の社内ではGitHubのIssues機能なども連携することが推奨されるようになりました。

## Make Pull Request
GitHubの肝。とは言え、forkしないPull Requestは簡単。

GitHubのレポジトリの画面でbranchを切り替えて表示すると右上に"Pull Request"というボタンが出てくる。

Requestの相手(通常はレポジトリの管理者)と変更した内容を書いて送信。

## Try surrounding services
GitHubが使えるようになったら、GitHubの周辺にも手を出してみよう。

### Travis CI
https://travis-ci.org

CI(Continuous Integration; 継続的インテグレーション)を支援して、要するに、なるべく自動化して品質改善や納期短縮を効率よくやりましょうってサービス。
Publicなレポジトリなら、*.travis.yml*というファイルを置くだけで使える。

自前で同じようなサービスを用意するなら*Jenkins*が有名。

CIについては別途Lectureしましょう:)

### Heroku
https://www.heroku.com

読み方は「へろく」。RubyやらPythonやらをpushするだけで動かしてくれるPaaS。
小規模なら無料だし、たくさんあるAdd-Inが便利なので、まず動かしてみたいときに使う。

### Hubot
GitHub謹製の人工無能(?)。いや、かなり有能かも。

* 発言に含まれるURLのタイトルを表示
* TwitterのURLから発言内容を表示
* ミーティング時間の通知
* サーバの負荷が上がった場合に通知
* GitHubのリポジトリにpull requestが送られた場合に通知
* Jenkinsでのビルドの失敗時にエラーを通知
* デプロイの実行

# Remarks
間違いとかあったら教えてください。
