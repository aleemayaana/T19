FROM -----> source/base image 
RUN ---> to run commands
COPY /home/charan/vsagent.zip /app/vsagent.zip
ADD https://vstsagentpackage.azureedge.net/agent/3.243.1/vsts-agent-win-x64-3.243.1.zip destpath
WORKDIR ---> switch to working directory
LABEL createby="Charan"
MAINTAINER "NextOps"
EXPOSE ----> 8080
ENTRYPOINT [ "executable" ]
CMD ----> ["/bin/bash"]
VOLUME ---> 
ENV ---> PATH=/usr/bin;/usr/local/bin
USER nobody