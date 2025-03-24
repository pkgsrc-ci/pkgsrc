# pkgsrc-ci

This repository provides pkgsrc developers with an automated way to test
proposed changes prior to commit.

## Supported Platforms

In order to provide feedback as quickly as possible, and to avoid delays when
testing large changes, currently only platforms with native GitHub runners are
supported.  These runners may be launched in parallel, and do not rely on
virtualisation, so can support larger queues.  The supported platforms are:

* `macOS-13-x86_64`
* `macOS-15-arm64`
* `ubuntu-24.04-x86_64`

While Cygwin is a native platform and could support runners, a lot of packages
still fail there, and we do not (yet) want those failures to detract from
failures on the better supported platforms.

## Additional Configurations

To help improve the quality of alternate configuration options, the Ubuntu
builds are further split into two.  One is configured as closely as possible to
pkgsrc defaults, while the other is configured with a number of changes to help
expose areas where package updates do not correctly handle alternate
configurations.

## Workflow

Here is the recommended workflow that developers can use to test changes.

Start by fetching and configuring this repository.  This only needs to be done
once.  Setting `push.default` ensures that `git push` will do the right thing
for this repository.

```shell
$ git clone git@github.com:pkgsrc-ci/pkgsrc
$ cd pkgsrc
$ git config push.default current
```

Create a branch in which your changes will go.  The GitHub actions are
configured to look for branches under the `ci/` namespace, and will
automatically trigger builds for any pushes to them.  As this is a shared
namespace, it's recommended to use a descriptive branch name, for example:

```shell
$ git checkout -b ci/jperkin-pkgin-25.x origin/trunk
```

Work on your changes, using your preferred workflow, for example:

```shell
$ cd pkgtools/pkgin
$ vi Makefile
$ bmake mdi
$ bmake
...hack hack hack...
$ mkpatches; bmake mps; mkpatches -c
```

Once you have something ready to go, commit and push the branch.  Remember to
`git add` any new files (e.g. `patches/patch-*`).

```shell
$ git add patches/patch-new_file.c
$ git commit -m "test pkgin update" .
$ git push
```

Browse to <https://github.com/pkgsrc-ci/pkgsrc/actions> and you should see your
workflow run has been triggered, where you can watch the current progress.  If
any of the builds fail, you will receive an email to your GitHub configured
email address, with URLs to the results.  At this point you can make further
changes and `git push` them to update the branch.

Once everything is complete and successful, it would be helpful if you can
delete the remote branch to help keep things tidy:

```shell
$ git branch -d origin :ci/jperkin-pkgin-25.x
```
