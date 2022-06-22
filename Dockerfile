FROM ubuntu:latest

COPY Gemfile /

RUN \
    apt-get update && \
    apt-get install -y ruby-full ruby-bundler build-essential python3-pip curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    bundle install && \
    pip install pre-commit && \
    pip install -U checkov && \
    curl -L "$(curl -s https://api.github.com/repos/aquasecurity/tfsec/releases/latest | grep -o -E -m 1 "https://.+?tfsec-linux-amd64")" > tfsec && chmod +x tfsec && mv tfsec /usr/bin/ && \
    curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash


ENV CHEF_LICENSE="accept"

