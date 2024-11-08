## Create a bucket
```sh
aws s3 mb s3://client-encryption-bucket-dd-98765 --region us-east-1
```
## Add buket name to env and continue to with the ruby code
```sh
export BUCKET_NAME=client-encryption-bucket-dd-98765
```

## Cleanup
```sh
aws s3 rm s3://client-encryption-bucket-dd-98765 --recursive
aws s3 rb s3://client-encryption-bucket-dd-98765
```