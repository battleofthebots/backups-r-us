FROM ghcr.io/battleofthebots/botb-base-image:latest
EXPOSE 8080 22
USER root
RUN pip install Flask-AutoIndex pyminizip && \ 
    mkdir -p /var/www/backups && chmod 777 /var/www/backups && \
    mkdir -p /home/user && chown user:user /home/user
WORKDIR /opt
COPY entrypoint.sh .
COPY app.py .
CMD /bin/bash entrypoint.sh