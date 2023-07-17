FROM ghcr.io/battleofthebots/botb-base-image:latest
EXPOSE 8080 22

USER root
RUN pip install Flask-AutoIndex pyminizip && \ 
    mkdir -p /var/www/backups && chmod 777 /var/www/backups && \
    mkdir -p /home/user && chown user:user /home/user
WORKDIR /opt
USER user
RUN ssh-keygen -q -t rsa -b 1024 -N '' -f /home/user/.ssh/id_rsa && \
    cp -a /home/user/.ssh/id_rsa.pub /home/user/.ssh/authorized_keys

COPY app.py /opt
USER root
CMD service ssh start && su user -l -c "python3 /opt/app.py"