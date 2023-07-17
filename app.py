import random
import os
from flask import Flask
from flask_autoindex import AutoIndex

app = Flask(__name__)
AutoIndex(app, browse_root='/var/www')

if __name__ == '__main__':
    with open("/usr/share/wordlists/rockyou.txt") as fil:
        lines = fil.readlines()
        password = random.choice(lines)
    os.system(f"zip -r /var/www/backups/home.zip {os.environ.get('HOME')} -P={password}")
    app.run(host='0.0.0.0', port=80)