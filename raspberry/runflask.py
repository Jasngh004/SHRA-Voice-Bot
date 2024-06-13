import subprocess
from get_ip import get_ip_address
def run_command(command):
    ip = get_ip_address()
    print(ip)
    process = subprocess.Popen(command + " " + ip, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    output, error = process.communicate()
    return output.decode('utf-8'), error.decode('utf-8')

command = f"flask run -h"
output, error = run_command(command)
print(output)

# if error:
#     print("Error:", error)
# else:
#     print("Output:", output)
