import socket

def get_ip_address():
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    return ip_address

ipv4_address = get_ip_address()
print("IPv4 Address:", ipv4_address)


