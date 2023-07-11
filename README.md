# Backups R Us

### Insecure Backup of home directory

## Building
```sh
docker build . -t backups-r-us
```

## Running
```sh
docker run -p 22:22 -p 80:80 backups-r-us
```

## Exploiting
```sh
python3 poc.py 172.17.0.2
```