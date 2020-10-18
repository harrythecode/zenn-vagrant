# zenn-vagrant

This Vagrant helps you build a cozy environment for writing articles in Zenn (https://zenn.dev/). Vagrant is an awesome tool that you can have the same environment & version on different clients. You can also test whatever you want then delete the env and then create from a scratch easily.

## Prerequisites

* [Vagrant](https://www.vagrantup.com/)
* [Virtualbox](https://www.virtualbox.org/)
* (Optional) [vagrant-fsnotify](https://github.com/adrienkohlbecker/vagrant-fsnotify)

By default, you need to open 8000/tcp since it requires to run preview locally.

## Test Environment

On 2020-10-14, I've tested & verified this vagrant env with the items below:

|Item           |Version|
|---------------|-------|
|macOS Catalina |v10.15.7|
|Vagrant        |2.2.10|
|Virtualbox     |6.1.14|

# How to use

I recommend you to use `yarn` instead `npm` on vagrant since npm has a critical [bug](https://github.com/npm/npm/issues/7308#issuecomment-209463993). You can work around the issue by creating a symlink of a node_modules folder though, `yarn` works much better and you don't need to perform the workaround. 

## Initialization

```
$ git clone <this repo>
$ cd <your-path-to>/zenn-vagrant
$ vagrant up
$ vagrant provision
$ vagrant ssh
```

See more hacks on [wpscholar/vagrant-cheat-sheet.md](https://gist.github.com/wpscholar/a49594e2e2b918f4d0c4)

## How to play around Zenn-CLI on vagrant?

You need to set up zenn cli by following the [official tutorial](https://zenn.dev/zenn/articles/install-zenn-cli)

```
$ cd shared_folder
$ yarn add zenn-cli
$ npx zenn init
```

I leave it to you whether you will set up zenn-cli manually or automatically. That's because zenn has a GitHub deploy-feature and you'd probably have your repository under the shared_folder. So it's better to initialize zenn-cli under the repo.

However, you can define the command below in [bootstrap.sh](./bootstrap.sh) if you don't need to have a separate folder under the shared_folder.

```
# Initial Set up for zenn-cli
mkdir -p /home/vagrant/shared_folder && cd /home/vagrant/shared_folder && yarn add zenn-cli && npx zenn init
```

### After vagrant ssh

```
~$ cd shared_folder
~/shared_folder$ npx zenn help

Command:
  zenn init         コンテンツ管理用のディレクトリを作成。初回のみ実行
  zenn preview      コンテンツをブラウザでプレビュー
  zenn new:article  新しい記事を追加
  zenn new:book     新しい本を追加
  zenn -v           zenn-cliのバージョンを表示
  zenn help         ヘルプ

  👇詳細
  https://zenn.dev/zenn/articles/zenn-cli-guide

~/shared_folder$ npx zenn new:article
📄8261d9e2502e87b48812.md created.

~/shared_folder$ npx zenn preview
👀Preview on http://localhost:8000
```

You can access http://localhost:8000 and see the preview. See more details at the official document 👉 https://zenn.dev/zenn/articles/zenn-cli-guide

# FAQ
## What is the `shared_folder` for?

It's used to share content between your Host and Guest machine. You can open the folder and edit files.

## When I run `zenn preview` on the Guest machine, it does not render changes on the Host machine.

I recommend you to use [vagrant-fsnotify](https://github.com/adrienkohlbecker/vagrant-fsnotify). Install it with `$ vagrant plugin install vagrant-fsnotify`, and when the guest machine is up, run the following:
```
$ vagrant fsnotify
```

I've configured like this in my bash_profile:
```
alias vs-zenn-watch="cd ~/<your-path-to>/zenn-vagrant/ && vagrant up && vagrant fsnotify"
alias vs-zenn="cd ~/<your-path-to>/zenn-vagrant/ && vagrant up && vagrant ssh"
```

So basically you'll open two terminals: one for watching changes on the Host machine, and another for accessing Guest machine :)