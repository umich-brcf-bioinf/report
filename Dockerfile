FROM continuumio/miniconda3:4.7.12

ARG env_name

# env_name is supplied as --build-arg to docker, and is identical between yaml file basename and environment name specified within it
COPY ${env_name}.yaml /tmp/

RUN conda env create -f /tmp/${env_name}.yaml && conda clean --all -y

RUN apt-get update && \
    apt-get install -y texlive-latex-base texlive-latex-recommended texlive-fonts-recommended

RUN tlmgr init-usertree && \
    tlmgr option repository ftp://tug.org/historic/systems/texlive/2018/tlnet-final \
    tlmgr install scheme-full

ENV PATH /opt/conda/envs/${env_name}/bin:$PATH
