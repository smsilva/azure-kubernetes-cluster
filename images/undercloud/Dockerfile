# docker build -t silviosilva/azure-undercloud-cluster:0.3.0 .
# docker push silviosilva/azure-undercloud-cluster:0.3.0
FROM silviosilva/azure-kubernetes-cluster:0.3.0
ENV  STACK_INSTANCE_NAME_FINAL="undercloud"
ADD  terraform.tfvars /opt/src/terraform.tfvars
