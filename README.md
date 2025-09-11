# DotFiles

This repository contains my personal configuration files (dotfiles) for various applications and tools. 

## GNU stow

I use [GNU stow](https://www.gnu.org/software/stow/) to manage my dotfiles.  
Stow allows me to create symlinks from the files in this repository to their appropriate locations in my home directory.

I use modular structure to organize my dotfiles. Each application or tool has its own directory, making it easy to manage and update configurations.  
To apply the configurations, I navigate to the root of this repository and run:

```
stow <directory_name>
```

e.g. to apply the configuration for `nvim`, I would run:

```
stow nvim
```
