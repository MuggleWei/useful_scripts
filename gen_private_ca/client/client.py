# import websocket
import requests

# def run_ws():
#     sslopt_ca_certs = {'ca_certs': '../build/domain.crt', "check_hostname": False}
#     ws = websocket.create_connection(
#         "wss://localhost:10102/",
#         enable_multithread=True,
#         sslopt=sslopt_ca_certs)
#
#     ws.send(json.dumps({
#         "op": "login",
#         "req": {
#             "user": "weishuzheng",
#             "passwd": "$*HFD&"
#         }
#     }))
#
#     while True:
#         ws.send(json.dumps({
#             "op": "ping",
#         }))
#         time.sleep(1)


def run_rest():
    url = "https://127.0.0.1:10102/world"
    r = requests.get(url, verify=False)
    print(r.text)


if __name__ == "__main__":
    run_rest()
