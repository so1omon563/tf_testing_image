FROM ubuntu:latest

COPY Gemfile /

RUN \
    apt-get update && \
    apt-get install -y ruby-full ruby-bundler build-essential python3-pip curl git && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && apt-get install terraform && \
    bundle install && \
    pip install pre-commit checkov && \
    curl -L "$(curl -s https://api.github.com/repos/aquasecurity/tfsec/releases/latest | grep -o -E -m 1 "https://.+?tfsec-linux-amd64")" > tfsec && chmod +x tfsec && mv tfsec /usr/bin/ && \
    curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash && \
    curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz && tar -xzf terraform-docs.tar.gz && chmod +x terraform-docs && mv terraform-docs /usr/bin/ && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install && rm -rf awscliv2.zip aws && \
    mkdir -p /workspace && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
ENV CHEF_LICENSE="accept"

