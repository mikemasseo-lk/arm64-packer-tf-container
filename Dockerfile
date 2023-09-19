# Get an arm64 node image for base
FROM arm64v8/node
RUN mkdir /root/packer
WORKDIR /root/packer
#get the latest binaries, as of 9/19/23 for packer and terraform
RUN wget https://releases.hashicorp.com/packer/1.9.4/packer_1.9.4_linux_arm64.zip
RUN wget https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_arm64.zip
RUN apt-get update
RUN apt-get install unzip -y
RUN unzip packer_1.9.4_linux_arm64.zip
RUN unzip terraform_1.5.7_linux_arm64.zip
RUN mv packer /usr/local/bin/packer
RUN mv terraform /usr/local/bin/terraform
RUN rm packer_1.9.4_linux_arm64.zip
RUN rm terraform_1.5.7_linux_arm64.zip
RUN mkdir /root/git
WORKDIR /root/git
RUN apt-get install build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip -y
#Download the git source code and compile it
RUN wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.42.0.tar.gz -O git.tar.gz
RUN tar -zxf git.tar.gz
WORKDIR /root/git/git-2.42.0
RUN make configure
RUN ./configure --prefix=/usr
RUN make all
RUN make install
