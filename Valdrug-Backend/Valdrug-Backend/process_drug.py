from azure.cosmos import exceptions, CosmosClient, PartitionKey
import azure.cosmos.cosmos_client as cosmos_client
import azure.cosmos.exceptions as exceptions
from azure.cosmos.partition_key import PartitionKey
from check_contents import check_contents

def process_drug(hashset):
    HOST = "https://val-drug.documents.azure.com:443/"
    MASTER_KEY="EdGOxQSwfjPCswDU53fapSuN0WAL1y3Jrb2HXp5KGY1uFUR3iDqlrVVSWvWLbFUk7ZRSINzDx2t3UMzejbPqfw=="
    client = cosmos_client.CosmosClient(HOST, {'masterKey': MASTER_KEY} )
    db = client.get_database_client("val-drug")
    container = db.get_container_client("val-drug")
    query = "SELECT c.id FROM c"
    items = list(container.query_items(query=query,enable_cross_partition_query=True))
    print(items)
    result=""
    result2=""
    for x in items:
        print(x)
        if " " in x['id']:
            print("Entered space")
            words = x['id'].split(" ")
            count =0
            length=len(words)
            for y in words:
                if y in hashset:
                    count+=1
            if(count != length):
                result="Invalid "+"'"+x['id']+"'"
            else:
                return check_contents(x['id'],hashset)
                
        else:
            if(x['id'] in hashset):
                return check_contents(x['id'],hashset)
            else:
                result="Invalid "+"'"+x['id']+"'"

    return result
                
            
