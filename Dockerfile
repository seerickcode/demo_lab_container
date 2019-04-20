FROM codercom/code-server

ENV BUILDSTAMP=2019041901

USER root
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
	python3 python3-pip python3.6-venv

COPY extensions/ /home/coder/.local/share/code-server/extensions
RUN mkdir -p /home/coder/.virtualenvs && \
    chown -R coder:coder /home/coder

USER coder
RUN mkdir -p /home/coder/.virtualenvs && \
    python3 -m venv /home/coder/.virtualenvs/slackbot && \
    /home/coder/.virtualenvs/slackbot/bin/python3 -m pip install -U wheel && \
    /home/coder/.virtualenvs/slackbot/bin/python3 -m pip install -U slack-machine && \
    /home/coder/.virtualenvs/slackbot/bin/python3 -m pip install -U pylint



