FROM ubuntu:14.04
MAINTAINER Alex Lomov <lomov.as@gmail.com>

RUN sudo apt-get update
RUN sudo apt-get install python-pip python-dev -y
RUN sudo pip install ansible
