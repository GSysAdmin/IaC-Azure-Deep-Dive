# May need to just run this script multiple times until all the resources you want to delete have been deleted
resources="$(az resource list --resource-group "rg-westeurope-test" --query "[].id" --output tsv)"
print $resources
#Replaced the for loop with a while loop to handle multiline resource IDs.
#The IFS= read -r id line reads each line of the resource IDs into the id variable.
while IFS= read -r resource_id; do
    print "Deletign resource: " $resource_id
    az resource delete --ids "$resource_id" --verbose
done <<< "$resources"