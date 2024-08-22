ARG TERRAFORM_VERSION=1.9.5
# ARG preceeding the first FOR can be used in the FORs

# For caching purposes
FROM alpine as providers

ARG TERRAFORM_PROVIDER_VERSION=1.39.0

RUN ls -lrt / && \
    mkdir -p /usr/providers

# Add providers here
RUN wget -O terraform-${TERRAFORM_PROVIDER_VERSION}.zip https://releases.hashicorp.com/terraform-provider-azurerm/${TERRAFORM_PROVIDER_VERSION}/terraform-provider-azurerm_${TERRAFORM_PROVIDER_VERSION}_linux_amd64.zip && \
    unzip -d /usr/providers terraform-${TERRAFORM_PROVIDER_VERSION}.zip && \
    ls -lrt /usr/providers

# Add them to hashicorp/terraform image
FROM hashicorp/terraform:${TERRAFORM_VERSION}

ARG TERRAFORM_PROVIDER_VERSION=1.39.0

COPY --from=providers /usr/providers/terraform-provider-azurerm_v${TERRAFORM_PROVIDER_VERSION}_x4 /bin/
