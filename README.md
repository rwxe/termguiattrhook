# [~~***TermGuiAttrHook***~~](./README.md)

## Introduction
## 简介

This plugin is used to override cterm attributes with gui attributes for all highlight groups. A workaround before 'termguiattr'.

这个插件用于对所有高亮组使用gui属性重写所有cterm属性。'termguiattr'之前的临时解决方案。

## Installation
## 安装

If you use a plugin manager, such as vim-plug, add the following line to your `~/.vimrc` and execute `:PlugInstall`. 

如果你使用插件管理，例如vim-plug，将下面这行文字添加到你的`~/.vimrc`中并执行`:PlugInstall`。
```vim
call plug#begin('~/.vim/plugged')
Plug 'rwxe/termguiattrhook'
call plug#end()
```
Or you can directly clone this repository and put the plugin file into the vim plugin directory, like this `~/.vim/pluggin/termguiattrhook`. Or because the plugin code is very simple, you can directly paste the code of `termguiattrhook.vim` into your `~/.vimrc`.

或是你可以直接克隆本仓库，将插件文件放入到vim插件目录，像这样`~/.vim/pluggin/termguiattrhook`。或是因为这个插件代码很简单，你可以直接将`termguiattrhook.vim`的代码粘贴到你的`~/.vimrc`中。

## Usage and Configuration 
## 用法和配置

**CHECK [English Help Documentation](./doc/termguiattrhook.txt), or run `:help termguiattr` after installing the plguin.**

**看 [中文帮助文档](./doc/termguiattrhook.cnx)，或是安装插件完后运行`:help termguiattr`。**

## Effect
## 效果

This plugin will achieve the following effects. For a highlighted group, if the `gui` attribute is set, it will be overridden to `cterm`, otherwise it will not be processed.

此插件将做到如下效果。对一个高亮组，如果设置了`gui`属性，则重写到`cterm`，否则不处理。

```vim
hi Test0 term=standout cterm=bold,underline  gui=undercurl,strikethrough,italic "cterm set,gui set              
hi Test1 term=standout cterm=bold,underline  gui=none                           "cterm set,gui didn't set       
hi Test2 term=standout cterm=none gui=undercurl,strikethrough,italic,bold       "cterm didn't set,gui set       
hi Test3 term=standout cterm=none gui=none                                      "cterm didn't set,gui didn't set                                                          
```
After calling

调用后
```vim
Test0          xxx term=standout cterm=undercurl,italic,strikethrough gui=undercurl,italic,strikethrough
Test1          xxx term=standout cterm=bold,underline
Test2          xxx term=standout cterm=bold,undercurl,italic,strikethrough gui=bold,undercurl,italic,strikethrough
Test3          xxx term=standout
```
