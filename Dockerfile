FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies needed to fetch and install AWS CLI v2, then clean apt lists
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    unzip \
    groff \
    less \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Download and install AWS CLI v2, then remove installer artifacts
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install --install-dir /usr/local/aws-cli --bin-dir /usr/local/bin \
    && rm -rf /tmp/aws /tmp/awscliv2.zip
