# Terraform Configuring Providers 

Remember to configure your local terraform instance to work with the provider we want. 

For google: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started


For AWS: https://registry.terraform.io/providers/hashicorp/aws/latest/docs

This just needs to be done once to ensure the executing environment has the proper access to deletate to terraform to perform the resource operations in the right place. 



# Future State 

TODO: More time needs to be spent creating proper variables, too much hardcoded value in main.tf


# Setup local kubectl 

aws eks update-kubeconfig --region us-east-2 --name <cluster-name>

# Installing eksctl, if needed 

## for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

## (Optional) Verify checksum
curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin



# If needed, setup ekscli + EBS CSI Driver (for dynamic PV provisioning)

https://repost.aws/knowledge-center/eks-persistent-storage

aws eks describe-cluster --name <yourclustername> --query "cluster.identity.oidc.issuer" --output text

--If Exist 
aws iam detach-role-policy \
 --role-name AmazonEKS_EBS_CSI_Driver \
 --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy

aws iam delete-role \
 --role-name AmazonEKS_EBS_CSI_Driver 

--

aws iam create-role \
 --role-name AmazonEKS_EBS_CSI_Driver \
 --assume-role-policy-document file://"trust-policy.json"

 aws iam attach-role-policy \
--policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
--role-name AmazonEKS_EBS_CSI_Driver


-- If it exist
aws eks delete-addon \
 --cluster-name my-cluster \
 --addon-name aws-ebs-csi-driver 

--

aws eks create-addon \
 --cluster-name my-cluster \
 --addon-name aws-ebs-csi-driver \
 --service-account-role-arn arb:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/AmazonEKS_EBS_CSI_Driver

