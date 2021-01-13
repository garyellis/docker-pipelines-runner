FROM registry.access.redhat.com/ubi8/python-38
USER root

ENV JQ_VERSION 1.6
ENV JQ_DOWNLOAD_URL https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64

ENV TERRAFORM_VERSION "0.12.30"
ENV TERRAGRUNT_VERSION v0.24.4
ENV TERRAGRUNT_DOWNLOAD_URL https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64
ENV TFLINT_VERSION v0.15.5
ENV TFLINT_DOWNLOAD_URL https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_amd64.zip


RUN curl -L -o /usr/local/bin/jq $JQ_DOWNLOAD_URL && \
    chmod 755 /usr/local/bin/jq && \
    git clone https://github.com/tfutils/tfenv.git $HOME/.tfenv && \
    echo 'PATH="$HOME/.tfenv/bin:$PATH"' >> $HOME/.bashrc && \
    . $HOME/.bashrc && \
    tfenv install $TERRAFORM_VERSION && \
    tfenv use $TERRAFORM_VERSION && terraform version && \
    chown -R default:0 $HOME/.tfenv && \
    curl -L -o tflint.zip $TFLINT_DOWNLOAD_URL && \
    unzip tflint.zip -d /usr/local/bin && \
    chmod 755 /usr/local/bin/tflint && \   
    curl -L -o /usr/local/bin/terragrunt $TERRAGRUNT_DOWNLOAD_URL && \
    chmod 755 /usr/local/bin/terragrunt && \
    pip install ansible awscli molecule

USER default
ENV PATH $HOME/.tfenv/bin:$PATH
CMD ["/usr/bin/container-entrypoint"]
