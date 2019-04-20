FROM codercom/code-server:latest

ENV BUILDSTAMP=2019041901

USER root
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Python SDK
RUN apt-get update && apt-get install --no-install-recommends -y \
    bsdtar \
    python3 \
    python-dev \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade setuptools \
    && python3 -m pip install wheel \
    && python3 -m pip install -U pylint

USER coder

# Setup User Visual Studio Code Extentions
ENV VSCODE_EXTENSIONS "/home/coder/.local/share/code-server/extensions"
# Setup Python Extension
RUN mkdir -p ${VSCODE_EXTENSIONS}/python \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/python/latest/vspackage | bsdtar --strip-components=1 -xvf - -C ${VSCODE_EXTENSIONS}/python extension

RUN mkdir -p /home/coder/.virtualenvs && \
    chown -R coder:coder /home/coder

RUN mkdir -p /home/coder/.virtualenvs && \
    python3 -m venv /home/coder/.virtualenvs/slackbot && \
    /home/coder/.virtualenvs/slackbot/bin/python3 -m pip install -U wheel && \
    /home/coder/.virtualenvs/slackbot/bin/python3 -m pip install -U slack-machine && \
    /home/coder/.virtualenvs/slackbot/bin/python3 -m pip install -U pylint



