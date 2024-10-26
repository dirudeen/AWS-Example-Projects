import {client} from "./index"
import { CreateBucketCommand } from "@aws-sdk/client-s3"

const bucket_name = process.argv[2]

if (!bucket_name){
    throw new Error("Bucket name must provided. e.g node create-bucket bucket-name")
}

const bucketConfig = new CreateBucketCommand({
    Bucket: bucket_name,
})

client.send(bucketConfig)
    .then(res =>console.log(res))
    .catch(err => console.log(err))

