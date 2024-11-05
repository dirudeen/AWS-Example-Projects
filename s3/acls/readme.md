## Create a bucket
```sh
aws s3api create-bucket --bucket acls-examples-bucket-dd-4321 --region us-east-1
```

## Allow public access for acls
```sh
aws s3api put-public-access-block \
--bucket acls-examples-bucket-dd-4321 \
--public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=true,RestrictPublicBuckets=true"
```

## Allow acls on the bucket
```sh
aws s3api put-bucket-ownership-controls \
--bucket acls-examples-bucket-dd-4321 \
--ownership-controls="Rules=[{ObjectOwnership=BucketOwnerPreferred}]"
```

## Apply acls policy to bucket
```sh
aws s3api put-bucket-acl \
--bucket acls-examples-bucket-dd-4321 \
--access-control-policy file:///workspace/AWS-Example-Projects/s3/acls/policy.json
```

## Cleanup
```sh
aws s3 rm s3://acls-examples-bucket-dd-4321 --recursive
aws s3 rb s3://acls-examples-bucket-dd-4321
```