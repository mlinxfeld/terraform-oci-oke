# Terraform OCI OKE

## Project description

In this repository, I have documented my hands on experience with Terrafrom for the purpose of OCI OKE deployment. This set of HCL based Terraform files which can customized according to any requirements.  

## How to use code 

### STEP 1.

Clone the repo from github by executing the command as follows and then go to terraform-oci-oke directory:

```
[opc@terraform-server ~]$ git clone https://github.com/mlinxfeld/terraform-oci-oke.git
Cloning into 'terraform-oci-oke'...
remote: Enumerating objects: 10, done.
remote: Counting objects: 100% (10/10), done.
remote: Compressing objects: 100% (10/10), done.
remote: Total 10 (delta 0), reused 10 (delta 0), pack-reused 0
Unpacking objects: 100% (10/10), done.

[opc@terraform-server ~]$ cd terraform-oci-oke/

[opc@terraform-server terraform-oci-oke]$ ls
oke_cluster.tf      oke_datasources.tf  oke_network.tf  provider.tf
oke_compartment.tf  oke_kube_config.tf  oke_policy.tf   variables.tf
README.md
```

### STEP 2.

Within web browser go to URL: https://www.terraform.io/downloads.html. Find your platform and download the latest version of your terraform runtime. Add directory of terraform binary into PATH and check terraform version:

```
[opc@terraform-server terraform-oci-oke]$ export PATH=$PATH:/home/opc/terraform

[opc@terraform-server terraform-oci-oke]$ terraform --version

Terraform v0.12.16

Your version of Terraform is out of date! The latest version
is 0.12.17. You can update by downloading from https://www.terraform.io/downloads.html
```

### STEP 3. 
Next create environment file with TF_VARs:

```
[opc@terraform-server terraform-oci-oke]$ vi setup_oci_tf_vars.sh
export TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaaob4qbf2(...)uunizjie4his4vgh3jx5jxa"
export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaas(...)krj2s3gdbz7d2heqzzxn7pe64ksbia"
export TF_VAR_compartment_ocid="ocid1.tenancy.oc1..aaaaaaaasbktyckn(...)ldkrj2s3gdbz7d2heqzzxn7pe64ksbia"
export TF_VAR_fingerprint="00:f9:d1:41:bb:57(...)82:47:e6:00"
export TF_VAR_private_key_path="/tmp/oci_api_key.pem"
export TF_VAR_region="eu-frankfurt-1"
export TF_VAR_private_key_oci="/tmp/id_rsa"
export TF_VAR_public_key_oci="/tmp/id_rsa.pub"

[opc@terraform-server terraform-oci-oke]$ source setup_oci_tf_vars.sh
```

### STEP 4.
Run *terraform init* with upgrade option just to download the lastest neccesary providers:

```
[opc@terraform-server terraform-oci-oke]$ terraform init -upgrade

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "null" (hashicorp/null) 2.1.2...
- Downloading plugin for provider "oci" (hashicorp/oci) 3.54.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.null: version = "~> 2.1"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### STEP 5.
Run *terraform apply* to provision the content of this repo (type **yes** to confirm the the apply phase):

```
[opc@terraform-server terraform-oci-oke]$ terraform apply

data.oci_containerengine_cluster_option.FoggyKitchenOKEClusterOption: Refreshing state...
data.oci_containerengine_node_pool_option.FoggyKitchenOKEClusterNodePoolOption: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # data.oci_containerengine_cluster_kube_config.FoggyKitchenKubeConfig will be read during apply
  # (config refers to values not yet known)
 <= data "oci_containerengine_cluster_kube_config" "FoggyKitchenKubeConfig"  {
      + cluster_id    = (known after apply)
      + content       = (known after apply)
      + id            = (known after apply)
      + token_version = "2.0.0"
    }

(...)

Plan: 12 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

oci_identity_compartment.FoggyKitchenCompartment: Creating...
oci_identity_compartment.FoggyKitchenCompartment: Creation complete after 1s [id=ocid1.compartment.oc1..aaaaaaaagillnk7ttj6wpdhmewpibpxc5gbmrfxdtmaa3gfgjzbudesm3tsq]
oci_core_vcn.FoggyKitchenVCN: Creating...

(...)

Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

Outputs:

FoggyKitchenOKECluster = {
  "id" = "ocid1.cluster.oc1.eu-frankfurt-1.aaaaaaaaae3tcyjqgezdkntdmmztonbsmnrtsyrwgu4taobvmc2tsobtg43d"
  "kubernetes_version" = "v1.14.8"
  "name" = "FoggyKitchenOKECluster"
}
FoggyKitchenOKENodePool = {
  "id" = "ocid1.nodepool.oc1.eu-frankfurt-1.aaaaaaaaae3tkmrtg42wcndbge2temldgi4tizrugu4danrugnzdkzjsgrrd"
  "kubernetes_version" = "v1.14.8"
  "name" = "FoggyKitchenOKENodePool"
  "subnet_ids" = [
    "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaahfpyomcpa65wbwnmbnxii7dsuchuzbi52xvhh5v7ijsn2vay6pdq",
    "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaaqc6vvr3hhxg3mcdej4asrmhusvq5bv6uxwqzkitkhog3prbtxrtq",
  ]
}
FoggyKitchen_Cluster_Kubernetes_Versions = [
  [
    "v1.13.5",
    "v1.14.8",
  ],
]
FoggyKitchen_Cluster_NodePool_Kubernetes_Version = [
  [
    "v1.13.5",
    "v1.14.8",
  ],
]
```

### STEP 6.
After testing the environment you can remove the OCI OKE infra. You should just run *terraform destroy* (type **yes** for confirmation of the destroy phase):

```
[opc@terraform-server terraform-oci-oke]$ terraform destroy

data.oci_containerengine_node_pool_option.FoggyKitchenOKEClusterNodePoolOption: Refreshing state...
(…)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # local_file.FoggyKitchenKubeConfigFile will be destroyed
  - resource "local_file" "FoggyKitchenKubeConfigFile" {
      - content              = <<~EOT
            apiVersion: v1
            clusters:
            - cluster:
(…)
  # oci_identity_compartment.FoggyKitchenCompartment will be destroyed
  - resource "oci_identity_compartment" "FoggyKitchenCompartment" {
      - compartment_id = "ocid1.tenancy.oc1..aaaaaaaasbktycknc4n4ja673cmnldkrj2s3gdbz7d2heqzzxn7pe64ksbia" -> null
      - defined_tags   = {} -> null
      - description    = "FoggyKitchen Compartment" -> null
      - freeform_tags  = {} -> null
      - id             = "ocid1.compartment.oc1..aaaaaaaagillnk7ttj6wpdhmewpibpxc5gbmrfxdtmaa3gfgjzbudesm3tsq" -> null
      - is_accessible  = true -> null
      - name           = "FoggyKitchenCompartment" -> null
      - state          = "ACTIVE" -> null
      - time_created   = "2019-12-02 19:22:17.767 +0000 UTC" -> null
    }

Plan: 0 to add, 0 to change, 12 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes


(...)

oci_core_vcn.FoggyKitchenVCN: Destruction complete after 1s
oci_identity_compartment.FoggyKitchenCompartment: Destroying... [id=ocid1.compartment.oc1..aaaaaaaagillnk7ttj6wpdhmewpibpxc5gbmrfxdtmaa3gfgjzbudesm3tsq]
oci_identity_compartment.FoggyKitchenCompartment: Destruction complete after 0s

Destroy complete! Resources: 12 destroyed.
```
