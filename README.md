# .dotfiles

## Creating symlinks in windows
Open command prompt in elevated state

1. Bash
```
mklink C:\Users\<Username>\.bash_profile C:\Users\<Username>\.dotfiles\bash\.bash_profile
```
```
mklink C:\Users\<Username>\.bashrc C:\Users\<Username>\.dotfiles\bash\.bashrc
```

2. Git
```
mklink C:\Users\<Username>\.gitconfig C:\Users\<Username>\.dotfiles\git\.gitconfig
```

3. Vim
```
mklink C:\Users\<Username>\.vimrc C:\Users\<Username>\.dotfiles\vim\.vimrc
```

4. VsCode
```
mklink C:\Users\<Username>\AppData\Roaming\Code\User\settings.json C:\Users\<Username>\.dotfiles\code\settings.json
```
```
mklink C:\Users\<Username>\AppData\Roaming\Code\User\keybindings.json C:\Users\<Username>\.dotfiles\code\keybindings.json
```
5. Windows Terminal
```
mklink "C:\Users\<Username>\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" "C:\Users\<Username>\.dotfiles\wt\settings.json"
```

6. NVim
```
mklink C:\Users\<Username>\AppData\Local\nvim C:\Users\<Username>\.dotfiles\nvim
```
