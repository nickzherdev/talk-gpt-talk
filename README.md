# talk-gpt-talk
Split traffic tunneling to get access to both work resources and restricted sites

## Disclaimer
1) For now you should be located OUTSIDE OF RUSSIA to use this script successfully!
2) Works with openfortivpn

## Setup

    git clone https://github.com/nickzherdev/talk-gpt-talk.git

Add configs to config.cfg or use as is (see file).

Add symlink to /usr/local/bin for convinient calling

    sudo ln -s <full_path>/talk-gpt-talk/talk-gpt.sh /usr/local/bin/talk-gpt.sh
    sudo ln -s <full_path>/talk-gpt-talk/config.cfg /usr/local/bin/config.cfg

Add permission to execute

    sudo chmod +x /usr/local/bin/talk-gpt.sh
    sudo chmod +x <full_path>/talk-gpt-talk/talk-gpt.sh

(optional) Check that link was created successfully (should be green/blue)

    ls -la /usr/local/bin

(optional) To prevent entering a password each time, add an exeption to sudoers to the end of the file

    sudo visudo
    YOUR_USER_NAME ALL=(ALL) NOPASSWD: /usr/sbin/ip

Connect to the VPN.
Execute script:

    talk-gpt.sh

To check the route table, execute:

    ip r

The result should look similar to this:
    default via 192.168.2.1 dev wlp0s20f3 
    default via 192.168.2.1 dev wlp0s20f3 metric 5428 
    10.0.238.10 dev ppp0 scope link 
    10.0.238.25 dev ppp0 scope link 
    10.0.239.4 dev ppp0 scope link 
    10.0.239.35 dev ppp0 scope link 
    ...
    195.34.193.186 via 192.168.2.1 dev wlp0s20f3 

## Known problems

1) After some time selected sites stop responding.  

[SOLVED]: add cron job to run this script perodically.

    sudo vim /etc/crontab

Add a line in the end. Don't forget to change ANY_AVAILABLE_NUMBER and YOUR_USERNAME.

    ANY_AVAILABLE_NUMBER */1 * * * *   YOUR_USERNAME     /usr/local/bin/talk-gpt.sh >>/home/YOUR_USERNAME/cron_logs.txt 2>&1

Reload servicce:
    sudo service cron reload
    sudo service cron start
    
2) Connecting to VATS using devel@evo_n_nnn.evocargo.site is not supported. 
Please connect using IP adresses.

## Troubleshooting

Some resources are not available? Just append them to config.cfg
Still not working? Restart VPN service, it will reset the changes made by this script.  You may want also to comment out a crob job.

## Future work

1) Connect from RUSSIA (remote): add tunneling to another VPN so traffic to openai goes through it
https://superuser.com/questions/709376/is-it-possible-to-have-2-different-vpn-connections-simultaneously-on-the-same-ma
2) Connect from RUSSIA (office): check network setup
