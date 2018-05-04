FROM debian:stable

ENV NGROK_PROTOCOL http
ENV NGROK_REGION au
ENV NGROK_HOST localhost
ENV NGROK_PORT 80

# Create ngrok user.
RUN groupadd --gid 6767 ngrok \
	&& useradd --uid 6767 --gid ngrok --shell /bin/bash --create-home ngrok

# Install ngrok.
ADD https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip /tmp/ngrok.zip
COPY ngrok.yml /home/ngrok/.ngrok2/
RUN chown -R ngrok:ngrok /home/ngrok
RUN apt-get update \
  && apt-get install -y --no-install-recommends unzip \
  && unzip /tmp/ngrok.zip -d /bin \
  && rm /tmp/ngrok.zip \
  && apt-get purge -y --auto-remove unzip \
  && rm -rf /var/lib/apt/lists/*

USER ngrok
EXPOSE 4040

CMD ["sh", "-c", "ngrok $NGROK_PROTOCOL -host-header=rewrite -region=$NGROK_REGION $NGROK_HOST:$NGROK_PORT"]
