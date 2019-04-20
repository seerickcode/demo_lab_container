FROM codercom/code-server

USER root
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
	python3 python3-pip python3.6-venv

RUN python3 -m venv /home/coder/project/.venv

USER coder


