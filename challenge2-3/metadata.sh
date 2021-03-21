apt-get update -y

apt-get install jq

curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" | jq

# If we want to filter the response down to a nested property or specific array element we keep appending keys:, we would send the request to retrieve public ip address:
curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text"

# To list down the public ssh keys from metadata, run following query in AzureVM:
curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" | jq '.compute.publicKeys | [.[] | map(.) | .[]]'