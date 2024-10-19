#!/bin/bash

echo "Installing git & Generate ssh"
echo "######################################################################"
sudo apt install -y git git-core git-gui nano openssh-client
sudo ufw allow ssh
cd ~
mkdir -p ~/.ssh
chmod 700 ~/.ssh
chmod 700 ~/.ssh/config
cd ~/.ssh
# ssh-keygen -t ed25519 -C "test@gmail.com"
chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519.pub
cd -

bash -c \
'cat << EOF > ~/.ssh/config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
Host gitlab.i-link.pro
    HostName gitlab.i-link.pro
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
Host digitalocean.com
    HostName 164.90.207.152
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
PasswordAuthentication no
EOF'

eval "$(ssh-agent -s)"
echo $SSH_AGENT_SOCK
ssh-add ~/.ssh/id_ed25519
ssh-add -l
ssh-copy-id -i ~/.ssh/id_ed25519.pub root@164.90.207.152
ssh -T git@github.com
ssh -T git@gitlab.i-link.pro

# sudo tee -a /etc/ssh/ssh_config <<< \
# "    ForwardAgent yes
#     PasswordAuthentication no
#     IdentityFile ~/.ssh/id_ed25519
#     IdentitiesOnly yes"

git config --global user.name "Slaweekq"
git config --global user.email "celesik@gmail.com"
git config --global --add safe.directory /mnt/D/CRYPTO/setup
git config --global --add safe.directory /mnt/D/CRYPTO/wedding
git config --global --add safe.directory /mnt/D/CRYPTO/work
git config --global --add safe.directory /mnt/D/CRYPTO/work/packages
git config --global --add safe.directory /mnt/D/CRYPTO/work/libs
git config --global --add safe.directory /mnt/D/CRYPTO/work/server
git config --global --add safe.directory /mnt/D/CRYPTO/work/shelfjs-packages
git config --global --add safe.directory /mnt/D/CRYPTO/work/nelly-bot
git config --global --add safe.directory /mnt/D/CRYPTO/work/smartDefi
git config --global core.editor code
git config --global core.safecrlf true
git config --global push.autoSetupRemote true
git config --global credential.credentialStore gpg
git config --global credential.helper cache
git config --global pull.rebase false
git config --list

# export CACHE_CODE_DIR="blob_storage Cache CachedData CachedProfilesData 'Code Cache' Crashpad DawnGraphiteCache DawnGraphiteCache GPUCache 'Local Storage' logs 'Service Worker' 'Session Storage' User/History User/workspaceStorage WebStorage Cookies Cookies-journal $HOME/.npm/_cacache $HOME/.npm/_logs $HOME/managed_context $HOME/'Telegram Desktop' $HOME/test_suite_analysis $HOME/.nvm/.cache"


tee -a ~/.bashrc <<< \
'
alias si="sudo apt install -y"
alias srf="sudo rm -rf"
alias srn="sudo reboot now"
alias srp="sudo apt remove --purge -y"
alias sdr="sudo systemctl daemon-reload"
alias supd="sudo apt update && sudo apt upgrade -y && sudo apt install --fix-broken -y && sudo apt autoremove -y && sudo apt autoclean -y && flatpak uninstall --unused"
alias cleanCode="cd $HOME/.config/Code/ && rm -rf $CACHE_CODE_DIR && cd -"
alias cleanNode="rm -rf ./node_modules && rm -rf ./**/**/node_modules && rm -rf ./apps/**/**/node_modules"
alias digcon="ssh root@164.90.207.152"
alias digcon2="ssh root@164.90.215.172"
alias sshcon="eval "$(ssh-agent -s)" && echo $SSH_AGENT_SOCK && ssh-add ~/.ssh/id_ed25519 && ssh -T git@github.com"
alias gpush="git add ./ && git commit -m «new» -a && git push origin"
alias dexec="docker exec -it"
alias doccon="docker login -u slaweekq --password-stdin"
alias docker-compose="docker compose"
alias dstart="docker-compose up -d"
alias dstop="docker-compose down -v && docker-compose rm -sfv"
alias dstopall="docker-compose down --rmi=all -v --remove-orphans && docker rmi $(docker images -q --no-trunc) || true"
alias dres="dstop && clear && docker-compose up"
alias dreb="dres -d"
alias kalistart="docker pull kalilinux/kali-rolling && docker run --tty --interactive kalilinux/kali-rolling"
alias gtext="gnome-text-editor"
alias ogpt="ollama run llama3 --verbose"
alias nd="npm i -D"
alias nu="npm uninstall"
alias nats="~/nats"
alias sp="dpkg -l | grep"
alias primerun="~/.local/bin/prime-run"
alias serverCd="cd /mnt/D/CRYPTO/work/server"
alias serverStart="npm run ln-reboot && npm run migration:up && npm start"
alias serverSdk="npm run mockwv:generate:sdk && npm run server:generate:sdk"
alias lint="npx eslint --fix \"./**/*{.ts,.js,.tsx,.jsx}\""
alias format="npx prettier -w \"./**/*{.ts,.js,.json}\""
alias nxlint="nx reset && nx repair && nx run-many --t lint --fix && nx format:write --all"
alias flint="cleanCode && format && lint && nxlint"
alias gmerge="git fetch && git pull --all && git merge main"
alias defpass="echo 'pass'"
'

sudo tee -a /etc/inputrc <<< \
'
# paste after all text
set show-all-if-ambiguous On
"\e[A": history-search-backward
"\e[B": history-search-forward
'

# restore bash_profile
# declare > .bash_profile.recovered
# alias >> .bash_profile.recovered


#### md
# echo "######################################################################"
# add . - add change
# commit -m "Initial Commit" -a - write change
# push - send change
# pull - get change
# git branch dev - create branch developer and don't send changes in master
# then git checkout dev - switch dev branch
# git merge master - transfer master -> dev
# git branch -m new-branch-name old-branch-name - rename branch
# git branch -d - delete branch
# git branch -a - view all branch
# remote add origin git@github.com:0xSlaweekq/git-test.git - add remote repo
# push --set-upstream origin main - change branch origin/main
# remote - view all remote repo
# remote -v view all remote repo with url
# remote rm <name> - delete remote repo
# remote rename <old-name> <new-name> - rename remote repo
