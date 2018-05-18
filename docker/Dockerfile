FROM httpd:alpine

RUN apk update
RUN apk add python2 py2-pip gcc python2-dev linux-headers musl-dev git curl libffi libffi-dev make

RUN pip install -U setuptools
COPY /aria/ /tmp/

WORKDIR /tmp/aria-extension-cloudify/src/aria
RUN pip install .

WORKDIR /tmp/aria-extension-cloudify
RUN pip install .

WORKDIR /tmp
#RUN git clone -b 1.4.2 https://github.com/cloudify-incubator/cloudify-azure-plugin
#RUN wagon create ./cloudify-azure-plugin
ADD docker/cloudify_azure_plugin-1.4.2-py27-none-linux_x86_64.wgn /tmp/
RUN aria plugins install cloudify_azure_plugin-1.4.2-py27-none-linux_x86_64.wgn
RUN rm cloudify_azure_plugin-1.4.2-py27-none-linux_x86_64.wgn

WORKDIR /tmp/aria-rest-server/src/main/python/aria-rest
RUN pip install .

WORKDIR /tmp
RUN rm -rf *
RUN mkdir -p /tmp/aria

CMD aria-rest
