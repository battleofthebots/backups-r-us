# Backups R Us

You know what they say when it comes to backups, you can never have too many. That's why we host our encrypted backups on our webserver!

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