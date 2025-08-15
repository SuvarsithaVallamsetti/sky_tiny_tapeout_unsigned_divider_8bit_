ARG VARIANT=ubuntu-22.04
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

ENV DEBIAN_FRONTEND=noninteractive
ENV PDK_ROOT=/home/vscode/ttsetup/pdk
ENV PDK=ihp-sg13g2

# Install system dependencies
RUN apt update && \
    apt install -y \
    iverilog gtkwave python3 python3-pip python3-venv python3-tk python-is-python3 \
    libcairo2 verilator libpng-dev libqhull-dev make git curl tar

# Clone tt-support-tools
RUN mkdir -p /ttsetup
RUN git clone -b ttsky25a https://github.com/TinyTapeout/tt-support-tools /ttsetup/tt-support-tools

# Copy requirements
COPY test/requirements.txt /ttsetup/test_requirements.txt
COPY .devcontainer/copy_tt_support_tools.sh /ttsetup

# Install Python requirements
RUN pip3 install -r /ttsetup/test_requirements.txt -r /ttsetup/tt-support-tools/requirements.txt

# Install verible (for formatting)
RUN umask 022 && \
    curl -L https://github.com/chipsalliance/verible/releases/download/v0.0-3795-gf4d72375/verible-v0.0-3795-gf4d72375-linux-static-x86_64.tar.gz | \
    tar zxf - -C /usr/local --strip-components=1 && \
    chmod 755 /usr/local/bin

# Install IHP SG13G2 PDK and ensure sg13g2_io.v is in the correct location
RUN mkdir -p ${PDK_ROOT} && \
    git clone https://github.com/IHP-GmbH/IHP-Open-PDK.git ${PDK_ROOT}/${PDK} && \
    cd ${PDK_ROOT}/${PDK} && \
    make all && \
    mkdir -p ${PDK_ROOT}/${PDK}/libs.ref/sg13g2_io/verilog && \
    find ${PDK_ROOT}/${PDK} -name sg13g2_io.v -exec cp {} ${PDK_ROOT}/${PDK}/libs.ref/sg13g2_io/verilog/ \;

# Install openlane
RUN pip3 install openlane==2.2.9
