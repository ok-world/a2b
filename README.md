# a2b
This script makes initial configuration of your A2Billing system.</br>
Steps are:
- **_Install packets:_**
  - apache2
  - libapache2-mod-php
  - mysql-server
  - asterisk
  - php-cli
  - php-mysql
  - php-gd
  - php-mbstring
  - phpunit
  - php-zip
  - unzip
  - curl
  - git
- **_Download a2billing:_**
  - git clone https://github.com/Star2Billing/a2billing.git /usr/local/src/a2billing
- **_Download this script:_**
  - git clone https://github.com/ok-world/a2b.git /usr/local/src/a2billing/ok-a2b
- **_Run this script:_**
  - cd /usr/local/src/a2billing/ok-a2b
  - ./config.sh

You need root priveleges to run commands above.

After those steps you have basic installation of A2Billing system on your **_Ubuntu 18_** server.

Remember that it has default account after installation process:

**Default access:**
```
Login : root
Password : changepassword
```
**Do not forget to change default password after installation.**

# What does this script do:
- fixes a lot of errors in official SQL files.
- generates password for DB (I think it's not good idea to use same password on all servers in the world)
- fixes errors from official installation guide
- makes easy installation procedure

# Copyright
Go to official repo of a2billing here https://github.com/Star2Billing/a2billing

