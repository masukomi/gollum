gollum -- A git-based Wiki
====================================

[![Gem Version](https://badge.fury.io/rb/gollum.svg)](http://badge.fury.io/rb/gollum)
[![Build Status](https://travis-ci.org/gollum/gollum.svg?branch=master)](https://travis-ci.org/gollum/gollum)
[![Open Source Helpers](https://www.codetriage.com/gollum/gollum/badges/users.svg)](https://www.codetriage.com/gollum/gollum)

## DESCRIPTION

Gollum is a simple wiki system built on top of Git. A Gollum Wiki is simply a git repository of a specific nature:
* A Gollum repository's contents are human-editable. Pages are unique text files which may be organized into directories any way you choose, as long as they have a recognized file extension. Other content can also be included, for example images, PDFs and headers/footers.
* Gollum pages:
	* May be written in a variety of [markup languages](#markups).
	* Can be edited with your favourite system editor or IDE or with the built-in web interface.
	* Can be displayed in all versions, and can easily be rolled back.
* Gollum supports advanced functionality like UML diagrams, macros, metadata, and [more](https://github.com/gollum/gollum/wiki).

Some helpful documentation:
1. [Known limitations](https://github.com/gollum/gollum/wiki/Known-limitations).
2. [Troubleshoot guide](https://github.com/gollum/gollum/wiki/Troubleshoot-guide).
3. [Security overview](https://github.com/gollum/gollum/wiki/Security).

### Videos

* [Quick impression of gollum](https://www.youtube.com/watch?v=gj1qqK3Oku8)
* [Gollum overview and simple markdown tutorial (german with english subtitles)](https://www.youtube.com/watch?v=wfWgDRmcbU4)
* [Advanced features in action](https://www.youtube.com/watch?v=EauxgxsLDC4)

## SYSTEM REQUIREMENTS

| Operating System | Ruby           | Adapters           | Supported |
| ---------------- | -------------- | ------------------ | --------- |
| Unix/Linux-like  | Ruby (MRI) 2.1.0+   | all except [RJGit](https://github.com/repotag/rjgit) | yes |
| Unix/Linux-like  | [JRuby](https://github.com/jruby/jruby) (1.9.3+ compatible) | [RJGit](https://github.com/repotag/rjgit) | yes |
| Windows          | Ruby (MRI) 2.1.0+  | all except [RJGit](https://github.com/repotag/rjgit) | no  |
| Windows          | [JRuby](https://github.com/jruby/jruby) (1.9.3+ compatible) | [RJGit](https://github.com/repotag/rjgit) | almost<sup>1</sup> |

**Notes:**

1. There are still some bugs and this setup is not ready for production yet. You can track the progress at [Support Windows via JRuby - Meta Issue](https://github.com/gollum/gollum/issues/1044).

## INSTALLATION

Varies depending on operating system, package manager and Ruby installation. Generally, you should first install Ruby and then Gollum.

1. Ruby is best installed either via [RVM](https://rvm.io/) or a package manager of choice.
2. Gollum is best installed via RubyGems:  
```
gem install gollum -v 4.1.4
```

The official Gollum repo has moved on to v5.x but that introduced breaking changes that I haven't dealt with yet. 

Installation examples for individual systems can be seen [here](https://github.com/gollum/gollum/wiki/Installation).

**Notes:**  
* Whichever Ruby implementation you're using, Gollum ships with the appropriate default git adapter. So the above installation procedure is common for both MRI and JRuby.

### Markups

Gollum presently ships with support for the following markups:
* [Markdown](http://daringfireball.net/projects/markdown/syntax)
* [RDoc](http://rdoc.sourceforge.net/)

Since all markups are rendered by the [github-markup](https://github.com/github/markup) gem, you can easily add support for other markups by additional installation:
* [AsciiDoc](http://asciidoctor.org/docs/asciidoc-syntax-quick-reference/) -- `[sudo] gem install asciidoctor`
* [Creole](http://www.wikicreole.org/wiki/CheatSheet) -- `[sudo] gem install creole`
* [MediaWiki](http://www.mediawiki.org/wiki/Help:Formatting) -- `[sudo] gem install wikicloth`
* [Org](http://orgmode.org/worg/dev/org-syntax.html) -- `[sudo] gem install org-ruby`
* [Pod](http://perldoc.perl.org/perlpod.html) -- requires Perl >= 5.10 (the `perl` command must be available on your command line)
	* Lower versions should install `Pod::Simple` from CPAN.
* [ReStructuredText](http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html) -- requires python >= 2 (the `python2` command must be available on your command line)
	* Note that Gollum will also need you to install `docutils` for your Python 2. Installation procedure can, again, vary depending on operating system and package manager.
* [Textile](http://redcloth.org/hobix.com/textile/quick.html) -- `[sudo] gem install RedCloth`

By default, Gollum ships with the `kramdown` gem to render Markdown. However, you can use any [Markdown renderer supported by github-markup](https://github.com/github/markup/blob/master/lib/github/markup/markdown.rb). The thing to remember is that the first installed renderer from the list will be used. So, for example, `redcarpet` will NOT be used if `github/markdown` is installed.

## RUNNING

Simply:

1. Navigate to your git repository (wiki) via the command line.
2. Run: `gm`
3. Open `http://localhost:4567` in your browser.

This will start up a web server (WEBrick) running Gollum with a web interface, where you can view and edit your wiki. It will also "disown" the process so you don't have to worry about accidentally killing the server when you close your terminal window.

If you need to kill the gollum process `pkill gollumn` is usually sufficent.

#### Requiring Authentication:
To enable Basic Auth rename `authentication_example.rb` to `authentication.rb` the `gm` script will notice 
this file and instruct Gollum to use it for authentication.

On macOS it will look for a "generic" password in your keychain named `gollum-wiki`.  On other systems it will ask you to enter the password that users will have to enter. 

TODO: make it support an environment variable for setting the password.

### Running from source

1. `git clone https://github.com/gollum/gollum`
2. `cd gollum`
3. `git checkout v4.1.4`
4. `bundle install` (may not always be necessary).
5. `bundle exec bin/gollum`
	* Like that, gollum assumes the target wiki (git repository) is the project repository itself. If it's not, execute `bundle exec bin/gollum <path-to-wiki>` instead.
5. Open `http://localhost:4567` in your browser.

### Rack

Gollum can also be ran with any [rack-compatible web server](https://github.com/rack/rack#supported-web-servers). More on that [over here](https://github.com/gollum/gollum/wiki/Gollum-via-Rack).

### Rack, with an authentication server

Gollum can also be ran alongside a CAS (Central Authentication Service) SSO (single sign-on) server. With a bit of tweaking, this adds basic user-support to Gollum. To see an example and an explanation, navigate [over here](https://github.com/gollum/gollum/wiki/Gollum-via-Rack-and-CAS-SSO).

### Docker

Gollum can also be ran via [Docker](https://www.docker.com/). More on that [over here](https://github.com/gollum/gollum/wiki/Gollum-via-Docker).

### Service

Gollum can also be ran as a service. More on that [over here](https://github.com/gollum/gollum/wiki/Gollum-as-a-service).

## CONFIGURATION

Gollum comes with the following command line options:

| Option            | Arguments | Description |
| ----------------- | --------- | ----------- |
| --host            | [HOST]    | Specify the hostname or IP address to listen on. Default: `0.0.0.0`.<sup>1</sup> |
| --port            | [PORT]    | Specify the port to bind Gollum with. Default: `4567`. |
| --config          | [FILE]  | Specify path to Gollum's configuration file. |
| --ref             | [REF]     | Specify the git branch to serve. Default: `master`. |
| --adapter         | [ADAPTER] | Launch Gollum using a specific git adapter. Default: `grit`.<sup>2</sup> |
| --bare            | none      | Tell Gollum that the git repository should be treated as bare. This is only necessary when using the default grit adapter. |
| --base-path       | [PATH]    | Specify the leading portion of all Gollum URLs (path info). Setting this to `/wiki` will make the wiki accessible under `http://localhost:4567/wiki/`. Default: `/`. |
| --page-file-dir   | [PATH]    | Specify the subdirectory for all pages. If set, Gollum will only serve pages from this directory and its subdirectories. Default: repository root. |
| --css             | none      | Tell Gollum to inject custom CSS into each page. Uses `custom.css` from repository root.<sup>3,5</sup> |
| --js              | none      | Tell Gollum to inject custom JS into each page. Uses `custom.js` from repository root.<sup>3,5</sup> |
| --emoji           | none      | Parse and interpret emoji tags (e.g. :heart:). |
| --no-edit         | none      | Disable the feature of editing pages. |
| --live-preview    | none      | Enable the live preview feature in page editor. |
| --no-live-preview | none      | Disable the live preview feature in page editor. |
| --allow-uploads   | [MODE]    | Enable file uploads. If set to `dir`, Gollum will store all uploads in the `/uploads/` directory in repository root. If set to `page`, Gollum will store each upload at the currently edited page.<sup>4</sup> |
| --mathjax         | none      | Enables MathJax (renders mathematical equations). By default, uses the `TeX-AMS-MML_HTMLorMML` config with the `autoload-all` extension.<sup>5</sup> |
| --irb             | none      | Launch Gollum in "console mode", with a [predefined API](https://github.com/gollum/gollum-lib/). |
| --h1-title        | none      | Tell Gollum to use the first `<h1>` as page title. |
| --show-all        | none      | Tell Gollum to also show files in the file view. By default, only valid pages are shown. |
| --collapse-tree   | none      | Tell Gollum to collapse the file tree, when the file view is opened. By default, the tree is expanded. |
| --user-icons      | [MODE]    | Tell Gollum to use specific user icons for history view. Can be set to `gravatar`, `identicon` or `none`. Default: `none`. |
| --mathjax-config  | [FILE]    | Specify path to a custom MathJax configuration. If not specified, uses the `mathjax.config.js` file from repository root. |
| --template-dir    | [PATH]    | Specify custom mustache template directory. |
| --help            | none      | Display the list of options on the command line. |
| --version         | none      | Display the current version of Gollum. |

**Notes:**

1. The `0.0.0.0` IP address allows remote access. Should you wish for Gollum to turn into a personal Wiki, use `127.0.0.1`.
2. Before using `--adapter`, you should probably read [this](https://github.com/gollum/gollum/wiki/Git-adapters) first.
3. When `--css` or `--js` is used, respective files must be committed to your git repository or you will get a 302 redirect to the create a page.
4. Files can be uploaded simply by dragging and dropping them onto the editor's text area (this is, however exclusive to the default editor, not the live preview editor).
5. Read the relevant [Security note](https://github.com/gollum/gollum/wiki/Security#custom-cssjs--mathjax-config) before using these.

### Config file

When `--config` option is used, certain inner parts of Gollum can be customized. This is used throughout our wiki for certain user-level alterations, among which [customizing supported markups](https://github.com/gollum/gollum/wiki/Formats-and-extensions) will probably stand out.

**All of the mentioned alterations work both for Gollum's config file (`config.rb`) and Rack's config file (`config.ru`).**

## CONTRIBUTING

Please consider helping out! See [here](CONTRIBUTING.md) for pointers on how to get started with development.
