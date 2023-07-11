FROM ghcr.io/battleofthebots/botb-base-image:latest
EXPOSE 80 22
#RUN useradd --create-home --shell /bin/bash user
RUN pip install Flask-AutoIndex
RUN apt install -y zip openssh-server
WORKDIR /opt
COPY app.py .
COPY entrypoint.sh .
USER root
CMD /bin/bash entrypoint.sh