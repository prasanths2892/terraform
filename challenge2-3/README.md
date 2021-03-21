# Instance Metadata 
From the documentation, “Instance metadata is data about your instance that you can use to configure or manage the running instance.”
The Azure Instance Metadata Service provides information about currently running virtual machine instances. You can use it to manage and configure your virtual machines. This information includes the SKU, storage, network configurations, and upcoming maintenance events.
All this information can easily be gathered by invoking a REST API local and is unique to the instance itself.

# How can I access it?
The API can be accessed using tools that send GET requests (e.g., curl on linux-based systems, or Invoke-RestMethod in PowerShell on Windows) to an address. The latest API version can be invoked by sending a GET request to the following URI:

        http://169.254.169.254/metadata/instance
# Usage Scenario:
what do you do if you want to authenticate to Azure from VM/AWS from an EC2 Instance? For example, you have an app that needs to make API calls to Azure/AWS to download data from Blob/S3. Normally, you’d authenticate to Azure/AWS using Access Keys, but how do you get those Access Keys onto the VM/EC2 Instance? Putting them directly in your application code or a config file is a bad idea, as that means your credentials will be in plain text, on disk, accessible to any attacker that manages to get access to the VM/EC2 Instance or your code.
A better idea is to use Instance Metadata. Azure/AWS exposes an Instance Metadata endpoint on every VM/EC2 Instance at http://169.254.169.254. If you SSH to an VM/EC2 Instance, you can use any HTTP client, such as curl, to get information about that Instance from its Instance Metadata endpoint:

Azure:

        apt-get update -y

        apt-get install jq

        curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" | jq

    # If we want to filter the response down to a nested property or specific array element we keep appending keys:, we would send the request to retrieve public ip address:
            curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text"

    ## To list down the public ssh keys from metadata, run following query in AzureVM:
       curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" | jq '.compute.publicKeys | [.[] | map(.) | .[]]'


# check flatten_dict python script for nested dictionary object