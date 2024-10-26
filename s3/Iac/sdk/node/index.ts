import { S3Client } from "@aws-sdk/client-s3"


const region = "us-east-1"

export const client = new S3Client({
    region: region
})

