FROM ghcr.io/battleofthebots/botb-base-image:latest
EXPOSE 8080 22

USER root
RUN pip install Flask-AutoIndex pyminizip && \ 
    mkdir -p /var/www/backups && chmod 777 /var/www/backups && \
    mkdir -p /home/user && chown user:user /home/user
WORKDIR /opt
USER user
RUN ssh-keygen -q -t rsa -b 1024 -N '' -f /home/user/.ssh/id_rsa && \
    ln -s /home/user/.ssh/id_rsa.pub /home/user/.ssh/authorized_keys

COPY app.py /opt
USER root
CMD service ssh start && su user -s /bin/bash -l -c "ssh-keygen -q -t rsa -b 1024 -N '' -f /home/user/.ssh/id_rsa<<<y  && python3 /opt/app.py"
HEALTHCHECK --interval=10s --timeout=5s --start-period=10s --retries=3 \
    CMD [ $(curl -I -s http://0.0.0.0:80 | head -n 1 | cut -d' ' -f2 | head -n 1) -eq 200 ] || exit 1
