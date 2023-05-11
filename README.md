# talk-gpt-talk
Split traffic tunneling to get access to both work resources and restricted sites

### Clone this repo

    git clone https://github.com/nickzherdev/talk-gpt-talk.git

### Add environment variables to ~/.zshrc (example)

    export MY_GATEWAY="192.168.2.1"
    export MY_INET_IFACE="wlp0s20f3"
    export MY_VPN_DOMAINS="mx.evocargo.com wiki.evocargo.org jira.evocargo.org git.evocargo.org id.evocargo.org sso.evocargo.site cloud.evocargo.org"
    export VATS_DOMAIN="172.25.192.0/24"

### Add symlink to /usr/local/bin for convinient calling

    sudo ln -s <full_path>/talk-gpt-talk/talk-gpt.sh /usr/local/bin/talk-gpt.sh

### Ad permission to execute

    sudo chmod +x /usr/local/bin/talk-gpt.sh

### (optional) Check that link was created successfully (should be green/blue)

    ls -la /usr/local/bin

### (optional) To prevent entering a password each time, add an exeption to sudoers to the end of the file

    sudo visudo
    YOUR_USER_NAME ALL=(ALL) NOPASSWD: <full_path>/talk-gpt-talk/talk-gpt.sh

### Launch

    source ~/.zshrc
    talk-gpt.sh
