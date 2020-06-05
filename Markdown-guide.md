## Welcome to GitHub Pages

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Installing Jekyll on Debian

Install Jekyll version packaged in Debian:
```
# apt-get install jekyll
```

The file `Gemfile` is required and needs some configuration. Then install the Ruby dependencies:
```
$ mkdir github-webpages-repo
$ cd github-webpages-repo
$ nano Gemfile
$ bundle install --path vendor/bundle
```

Start the server process:
```
$ jekyll serve --host localhost
```

```
bundle exec jekyll serve
```

If source Markdown files are changed the website is regenerated automatically.

[Getting started with Jekyll on Debian 9 Stretch Linux](https://linuxconfig.org/getting-started-with-jekyll-on-debian-9-stretch-linux)

[Setting up your GitHub Pages site locally with Jekyll](https://help.github.com/en/articles/setting-up-your-github-pages-site-locally-with-jekyll)

[Working with GitHub Pages](https://help.github.com/en/github/working-with-github-pages)

[Testing your GitHub Pages site locally with Jekyll](https://help.github.com/en/github/working-with-github-pages/testing-your-github-pages-site-locally-with-jekyll)

### Installing Jekyll in Cygwin

Jekyll is installed as a Ruby gem. Installation is as simple as:

 1. Run Cygwin’s `setup.exe`

 2. Install the package `ruby`, `ruby-devel`,
    `make`, `automake`, `gcc-core`, `gcc-c++`, `patch`, `zlib`, `zlib-devel`,
    `libiconv`, `libiconv-dev`, `libxslt`, `libxslt-devel`, `libxml2-devel`

 3. Once Ruby is installed, run the following command to install Jekyll:

```
gem install jekyll
```

nokogiri fails to build on Cygwin. I don't know the cause...

[Jekyll on Windows With Cygwin](http://nathanielstory.com/2013/12/28/jekyll-on-windows-with-cygwin.html)

### Proxy in Cygwin

Put this code in your .bashrc:

```
proxy=http://host.com:port/
export http_proxy=$proxy
export HTTP_PROXY=$proxy
```

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/Wintermute0110/Wintermute0110.github.io/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.

### Table of Contents

In Markdown use

```
- TOC
{:toc}
```
