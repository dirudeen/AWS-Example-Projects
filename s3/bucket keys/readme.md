## Create a bucket
```sh
aws s3 mb s3://bucket-key-dd-1234 --region us-east-1
```

## Enable SSE-KMS encryption and bucket key
```sh
export KMS_KEY_ID="kms key or kms arn key"

aws s3api put-bucket-encryption \
--bucket bucket-key-dd-1234 \
--server-side-encryption-configuration "$(jq -n --arg key_id "$KMS_KEY_ID" \
'{
    Rules: [
    {
        ApplyServerSideEncryptionByDefault: {
            SSEAlgorithm: "aws:kms",
            KMSMasterKeyID: $key_id
        },
        BucketKeyEnabled: true
    } 
]
}')"
```

## Upload and download an object with SSE-KMS encryption
```sh
echo "Hello World!" > hello.txt

aws s3 cp hello.txt s3://bucket-key-dd-1234
```

## Get object metadata to confirm the server side encryption
```sh
aws s3api head-object --bucket bucket-key-dd-1234 --key hello.txt
```

## Cleanup
```sh
aws s3 rm s3://bucket-key-dd-1234 --recursive
aws s3 rb s3://bucket-key-dd-1234
```

