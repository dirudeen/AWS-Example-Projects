## Create a bucket
```sh
aws s3api create-bucket --bucket bucket-policy-example-dd-3536 --region us-east-1
```

## Allow public access through bucket policy
```sh
aws s3api put-public-access-block \
--bucket bucket-policy-example-dd-3536 \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Add Policy to bucket
```sh
aws s3api put-bucket-policy --bucket bucket-policy-example-dd-3536 --policy file://policy.json
```

## Cleanup
```sh
aws s3 rm s3://bucket-policy-example-dd-3536 --recursive
aws s3 rb s3://bucket-policy-example-dd-3536
```