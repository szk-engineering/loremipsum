sinatra setup on MacOSX
========

> LastModified: 2017-11-16

<!-- TOC depthFrom:2 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Abstrat](#abstrat)
- [install HomeBrew](#install-homebrew)
	- [brew update & doctor](#brew-update-doctor)
- [install rbenv & ruby-build](#install-rbenv-ruby-build)
- [setup gem](#setup-gem)
	- [.gemrc](#gemrc)
	- [update gem](#update-gem)
- [install bundler](#install-bundler)
- [Make a Web application with Sinatra](#make-a-web-application-with-sinatra)
- [Run!](#run)
- [Deploy to Heroku](#deploy-to-heroku)
- [Test](#test)
- [Make a feature](#make-a-feature)
- [Cycle](#cycle)

<!-- /TOC -->

## Abstrat
GitHub LectureのためにちょっとしたWebアプリを対象にしながらWorkFlowの理解を進めていきたい．
ところでちょっとしたWebアプリってなんだろう？ってことでRuby製Webフレームワークの*Sinatra*を選択しました．
Railsを100倍ぐらいシンプルにしたようなフレームワークです．

## install HomeBrew
何はともあれ，HomeBrewをインストール．

```shell
$ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

### brew update & doctor
念のため，HomwBrewが正しくインストールされたか確認．

```shell
$ brew update
$ brew doctor
```

## install rbenv & ruby-build
MacOSXに標準インストールされているRuby(Mavericksは2.0.0p451かな)とは違うバージョンを使いたくなった時のために，rbenvとruby-buildをインストールする．
rbenvはディレクトリ(= 開発しているプロジェクト)ごとにRubyを簡単に切り替えられるツール．
ruby-buildはrbenvのためにRubyをインストールしてくれるツール．

```shell
$ brew install rbenv
$ brew install ruby-build
```

インストールが終わったら，.zprofile(zshの場合)に「rbenvのrootディレクトリは"/usr/local/var/rbenv"で，そのディレクトリが存在してたら起動毎にinitスクリプトを実行してー」って内容を追記する．(cf. https://github.com/shin-szk-engineering/dotfiles/blob/master/zprofile.mac)

```shell
# rbenv
export RBENV_ROOT="/usr/local/var/rbenv"
if [ -d $RBENV_ROOT ]; then
  export PATH="$RBENV_ROOT/bin:$PATH"
  if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
fi
```

2.0系以上のRubyが入っていればとりあえず問題ないので，せっかくrbenvをインストールしたけど，Mavericks標準のRubyのまま進めます．
rbenvでの新しいrubyのインストール方法などは各自で．

## setup gem
GemはRubyパッケージを簡単にインストールするためのパッケージマネージャ．

※ RubyのバージョンごとにGemが存在しているので，rbenvで複数バージョンのRubyを使い分ける場合はGemもそれぞれ別にパッケージをインストールするってことに注意． → 逆に言えば，他のバージョンのRubyで環境がぶっ壊れても他には影響を及ぼさないってこと．

RubyやGemを使う上で頻繁に求められるパッケージを先にHomeBrewで入れておく．

```shell
$ brew install readline
$ brew install apple-gcc42
$ brew install sqlite
$ brew install rbenv-gemset
$ brew install rbenv-gem-rehash
```

GemはRubyを入れたら勝手に使えるようになってる．
試しに，Gemのバージョンと何が入ってるか確認してみる．

```shell
$ gem -v
$ gem list
```

### .gemrc
いろいろインストールする前に~/.gemrcに1行書いておく．
これでパッケージをインストールするときにドキュメント類を一緒にインストールしなくなるため，容量の節約と時間の短縮ができる．

```shell
gem: --no-ri --no-rdoc
```

### update gem
いろいろインストールする前にGem自体をupdateする．

```shell
$ sudo gem update
$ sudo gem install rubygems-update
$ update_rubygems
$ gem pristine --all
```

## install bundler
gemの準備が整ったので，試しにbundlerをインストールしてみる．
bundlerはRails3で標準になったgemをさらに便利にするツール．
(cf. http://www.rubylife.jp/rails/ini/index2.html)

```shell
$ sudo gem install bundler
```

無事にインストールできたかな？

## Make a Web application with Sinatra

// TODO: write details about make

```shell
$ bundle install --path vendor/bundle --without production
```

## Run!

// TODO: write details about run

```shell
$ sudo gem install foreman
```

```shell
$ foreman start
```

## Deploy to Heroku

```shell
$ brew install heroku-toolbelt
```

// TODO: write details about deploy

> heroku create

## Test

// TODO: write details about test

## Make a feature

// TODO: write details about feature

## Cycle

// TODO: write details about cycle
