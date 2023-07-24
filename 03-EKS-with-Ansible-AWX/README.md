 ## Create Cluster
 ```
eksctl create cluster --name=ekslab1 \
                      --version=1.24 \
                      --region=us-east-1 \
                      --zones=us-east-1a,us-east-1b \
                      --without-nodegroup 

# Get List of clusters
eksctl get cluster 
```
## Step-02: Create & Associate IAM OIDC Provider for our EKS Cluster

```
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster ekslab1 \
    --approve
```
## Create EKS Node Group in Private Subnets

```
create nodegroup --cluster=ekslab1 \
                        --region=us-east-1 \
                        --name=ekslab1-ng-private1 \
                        --node-type=t3.medium \
                        --nodes-min=2 \
                        --nodes-max=4 \
                        --node-volume-size=20 \
                        --ssh-access \
                        --ssh-public-key=MacKey \
                        --managed \
                        --asg-access \
                        --external-dns-access \
                        --full-ecr-access \
                        --appmesh-access \
                        --alb-ingress-access \
                        --node-private-networking 

# Get List of nodes
kubectl get nodes                         
```

## Install EBS CSI Drive

```
aws iam create-policy --policy-name Amazon_EBS_CSI_Driver --policy-document file://Amazon_EBS_CSI_Driver.json
```

- From output check arn:
```
"Arn": "arn:aws:iam::0000000000000:policy/Amazon_EBS_CSI_Driver"
```
- Get Worker node IAM Role ARN
```
kubectl -n kube-system describe configmap aws-auth
```
- From output check rolearn
```
rolearn: arn:aws:iam::00000000000000:role/eksctl-eksepinio1-nodegroup-eksep-NodeInstanceRole-0000000000000

# In this case the name of role is:
eksctl-eksepinio1-nodegroup-eksep-NodeInstanceRole-000000000000
```
- Associate the policy to that role
```
aws iam attach-role-policy --policy-arn arn:aws:iam::00000000000:policy/Amazon_EBS_CSI_Driver --role-name eksctl-eksepinio1-nodegroup-eksep-NodeInstanceRole-00000000000
```

- Deploy Amazon EBS Drive
```
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"

# Verify ebs-csi pods running
kubectl get pods -n kube-system
```

## Install Load Balancer Controller

- Download IAM Policy

```
curl -o iam_policy_latest.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
```

- Create IAM policy using policy downloaded
```
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy_latest.json
```

- Make a note of Policy ARN
```
Policy ARN:  arn:aws:iam::000000000000:policy/AWSLoadBalancerControllerIAMPolicy
```

## Create an IAM role for the AWS LoadBalancer Controller and attach the role to the Kubernetes service account

- Create IAM Role using eksctl
```
kubectl get sa -n kube-system
kubectl get sa aws-load-balancer-controller -n kube-system
```
**Note: Nothing with name "aws-load-balancer-controller" should exist**

``` 
eksctl create iamserviceaccount \
  --cluster=eksdemo1 \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::180789647333:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve
```
**Note: Replaced name, cluster and policy arn**

