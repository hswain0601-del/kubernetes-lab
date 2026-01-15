## EKS Production 
Based on the Terraform plan, we are building a production-ready Kubernetes environment on AWS.

<img width="2816" height="1536" alt="Gemini_Generated_Image_pwsu1spwsu1spwsu" src="https://github.com/user-attachments/assets/d4e3967a-6796-489c-b1fd-0360f8495c9f" />

### 🏗️ Infrastructure Resource Breakdown
This project provisions 41 resources on AWS using Terraform, organized into five functional layers.

#### Layer 1: The Network (VPC & Connectivity) - 19 Resources providing the foundation and traffic routing rules.**
- **aws_vpc:** The primary private network with CIDR 10.0.0.0/16.
- **aws_subnet(x4):** 2 Public (for Load Balancers) and 2 Private (for Worker Nodes) across 2 Availability Zones.
- **aws_internet_gateway:** Allowing the VPC to communicate with the public internet.
- **aws_eip:** A static Elastic IP address required by the NAT Gateway.
- **aws_nat_gateway:** Enables private worker nodes to pull updates from the internet while remaining invisible to external probes.
- **aws_route_table (x2):** Directs traffic from subnets to the correct gateway (Internet or NAT).
- **aws_route_table_association (x4):** Connects specific subnets to their designated routing rules.
- **aws_route (x2):** Individual routing entries that define the path to the IGW and NAT Gateway.
- **aws_default_network_acl:** A project-specific adoption of the default network firewall rules for the VPC.
- **aws_default_route_table:** Manages the default route table created by AWS for the VPC to ensure strict security.
- **aws_default_security_group:** Secures the default security group (maintained empty as a best practice).
<img width="2816" height="1536" alt="Gemini_Generated_Image_8o9cv58o9cv58o9c" src="https://github.com/user-attachments/assets/bd733a0f-df35-4572-b729-06ee2d3a341d" />

#### Layer 2: Identity & Permissions (IAM) - 13 Resources
- **aws_iam_role (x4):** Creation of four distinct identities with specific trust relationships:
- **Cluster Role:** Permissions for the EKS control plane to manage AWS resources (VPC, ELB, etc.).
- **Node Group Role:** Permissions for EC2 worker nodes to interact with EKS and ECR.
- **EBS CSI Role:** Permissions for the storage driver to manage EBS volumes.
- **LB Controller Role:** Permissions for the controller to manage Application Load Balancers.
- **aws_iam_policy:** A custom JSON policy containing the specific permissions required by the AWS Load Balancer Controller to create and manage ELBs.
- **aws_iam_role_policy_attachment (x8):** The "bridge" that connects the roles above to pre-defined AWS Managed Policies (e.g., AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy, and AmazonEC2ContainerRegistryReadOnly).
<img width="1053" height="532" alt="Screenshot 2026-01-15 at 5 12 39 PM" src="https://github.com/user-attachments/assets/c9908cb6-5ec6-4980-b571-38dfc269ec1f" />

#### Layer 3 & 4: Security Groups (Firewalls) "2 Resources" & The EKS Engine "3 Resources"
- **aws_security_group (Cluster):** Specifically configured to protect the EKS Control Plane, allowing secure communication only from the worker nodes on port 443.
- **aws_security_group (Worker):** Configured to allow all internal traffic between worker nodes and specific inbound traffic from the Load Balancer to your application pods.
- **aws_eks_cluster:** This manages the Kubernetes API server, scheduler, and control loop.
- **aws_eks_node_group:** This manages the lifecycle of our EC2 worker nodes (t2.large), ensuring the desired number of instances are always running.
- **aws_iam_openid_connect_provider (OIDC):** A critical security component that allows our Kubernetes Service Accounts to assume IAM roles directly (IRSA), following the principle of least privilege.
<img width="2816" height="1536" alt="Gemini_Generated_Image_tzcelktzcelktzce" src="https://github.com/user-attachments/assets/fc2aef85-68c7-4bf9-ae76-0389a0d23360" />

#### Layer 5: Add-ons & Kubernetes Config - 4 Resources
- **aws_eks_addon (ebs_csi):** Installs the Amazon EBS CSI driver, which allows our pods to use persistent storage (disks) that stay alive even if a pod restarts.
- **helm_release (lb_controller):** Deploys the actual Load Balancer Controller software into our cluster using the Helm package manager.
- **kubernetes_service_v1:** Defines how our application is accessed internally within the cluster targeting our application pods.
- **kubernetes_ingress_v1:** We are using ingress rules to the ALB Controller, It tells AWS to spin up a physical Application Load Balancer (ALB) to route external traffic to our service.
<img width="2784" height="1536" alt="Gemini_Generated_Image_lvvg15lvvg15lvvg" src="https://github.com/user-attachments/assets/eda1d572-5dc7-4ec8-9efd-ae22e4e92726" />

#### Terraform Lifecycle 
```bash
terraform init
```
1. terraform init is the preparation phase where Terraform sets up our local environment to handle the 41 resources defined in our code.
2. Terraform established the link to our state storage (defined in backend.tf) to track the "memory" of our infrastructure.
3. It downloaded the external source code for our VPC (found in .terraform/modules) so it can use those pre-built networking blueprints.
4. It fetched the specific binaries (AWS, Helm, Kubernetes, etc.) for our local eg: (darwin_arm64) into the .terraform/providers folder.
5. It created the .terraform.lock.hcl file to "freeze" these provider versions, ensuring our cluster builds exactly the same way every time.

```bash
terraform plan
```
1. It's a dry-run or preview phase of the Terraform lifecycle. It acts as a safety check, allowing us to see exactly what changes will be made to our AWS environment before any real resources are created or modified.
2. Terraform first scans our existing AWS infrastructure to see if anything has changed manually (drift detection).
3. it compares our current AWS state against the 41 resources defined in our .tf files.

```bash
terraform apply
```
1. Terraform sends hundreds of API calls to AWS to create the 41 resources.
2. It intelligently creates resources in order, for example, it builds the VPC first, then the Subnets, then the EKS Cluster, and finally the Helm releases.
3. It careates - **terraform.tfstate** this is the most important result, as terraform creates a JSON file that acts as a "source of truth," mapping our code to the actual IDs

```bash
terraform destroy
```
1. Terraform reads the State file and deletes resources in the reverse order of how they were built. It will delete the Load Balancer and EKS Nodes before it tries to delete the VPC.
2. Like apply, it will show us a plan of what it's about to delete and ask for a yes confirmation.




