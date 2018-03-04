import websocket
import json
import time

sslopt_ca_certs = {'ca_certs': 'server.crt', "check_hostname": False}
ws = websocket.create_connection(
    "wss://localhost:10102/",
    enable_multithread=True,
    sslopt=sslopt_ca_certs)

ws.send(json.dumps({
    "op": "login",
    "req": {
        "user": "weishuzheng",
        "passwd": "$*HFD&"
    }
}))


while True:
    ws.send(json.dumps({
        "op": "ping",
    }))
    time.sleep(1)
