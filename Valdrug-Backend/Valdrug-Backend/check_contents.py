from azure.cosmos import exceptions, CosmosClient, PartitionKey
import azure.cosmos.cosmos_client as cosmos_client
import azure.cosmos.exceptions as exceptions
from azure.cosmos.partition_key import PartitionKey

def check_contents(name, hashset):
    HOST = "https://val-drug.documents.azure.com:443/"
    MASTER_KEY="EdGOxQSwfjPCswDU53fapSuN0WAL1y3Jrb2HXp5KGY1uFUR3iDqlrVVSWvWLbFUk7ZRSINzDx2t3UMzejbPqfw=="
    client = cosmos_client.CosmosClient(HOST, {'masterKey': MASTER_KEY} )
    db = client.get_database_client("val-drug")
    container = db.get_container_client("val-drug")
    query = "SELECT * FROM c WHERE c.Name='"+name+"'"
    items = list(container.query_items(query=query,enable_cross_partition_query=True))
    print(items)

    words = items[0]['Description'].split(" ")
    for x in words:
        if x not in hashset:
            print("Invalid as Description: "+x+" does not match")
            return "Invalid "+"'"+name+"'"
    
    words = items[0]['Ingredients'].split(",")
    for x in words:
        for y in x.split(" "):
            if y not in hashset:
                print("Invalid as Ingredient(s): "+y+" do not match")
                return "Invalid "+"'"+name+"'"

    print("Valid as all checks have passed")
    return "Valid "+"'"+name+"'"

