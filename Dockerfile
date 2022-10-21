FROM python:3.8-slim

ENV NVIDIA_VISIBLE_DEVICES all

ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

ENV CUDA_VERSION 11.0.0

ENV LD_LIBRARY_PATH="/usr/local/cuda-11.0/lib64:$LD_LIBRARY_PATH"

# --fix-missing lets lammps sucessfully install
RUN apt-get -y update --fix-missing

RUN apt -y install build-essential

RUN apt-get -y install git

RUN apt-get -y install lammps

LABEL taost=taost

COPY . /nequip/

RUN cd /nequip/ && pip3 install -e .

# These install PyTorch versions that work with this system
RUN cd /nequip/ && pip3 install -r added_requirements.txt

ENV WANDB_ANONYMOUS=must

ENV CUDA_VISIBLE_DEVICES=all

ENV PORT=8800

EXPOSE 8800
