# az-terraform-build

##Instructions

### Create a storage container for terraform state

- Login to Azure 

```
az login
```

- Find your available subscriptions

```
az account list -o table
```

- Set Subscription

```
az account set -s <Subscription ID>
```

- Create a Storage account and Container

```

az storage account create -n <Storage account name> -g <RG Name> -l <Location> --sku Standard_LRS
az storage container create -n <Container Name>
```

###Update the remote state file

- Update your Subscription and state file details in the provider.tf file in environment/dev/provder.tf and environment/prod/provder.tf

- Update your inputs for resource build in files under the "variables" directory

### Run terraform from

environment/dev or environment/prod as below

```
cd environments/dev
terraform init
terraform plan --var-file=dev.tfvars
terraform apply --var-file=dev.tfvars
```
