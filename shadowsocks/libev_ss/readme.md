### shadowsocks server config
* run server_install.sh
* modify server_config.json
* run server_run.sh

### shadowsocks client config(old, not recommended)
* run old_client_install.sh
* modify client_config.json
* run old_client_run.sh

### shadowsocks client config(new)
* install
```
* in outside machine(e.g. hk/jp/us) clone shadowsocks-libev repo(git clone https://github.com/shadowsocks/shadowsocks-libev.git)
* copy ss_libev_build.sh and ss_libev_prepare.sh into repo
* run ss_libev_prepare.sh
* zip repo and send to inside machine
* unzip recived repo, and run ss_libev_build.sh
```
* modify client_config.json
* run client_run.sh
