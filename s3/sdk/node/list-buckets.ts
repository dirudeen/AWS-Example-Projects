import { client } from "./index"
import {ListBucketsCommand} from "@aws-sdk/client-s3"

const region = "us-east-1"
const listBucketConfig = new ListBucketsCommand({
    BucketRegion: region
})

client.send(listBucketConfig).then(res => {
    console.log(res)
}).catch(err => console.log(err))