## Create bucket
``` sh
aws s3api create-bucket --bucket metadata-test-bucket-dd --region us-east-1
```

## Create an object
``` sh
echo Hello Mars! > hello.txt
```

## Upload object with metadata
``` sh
aws s3api put-object \
--bucket metadata-test-bucket-dd \
--key hello.txt \
--body hello.txt \
--metadata planet=mars \
--content-type text/plain
```

## Get object metadata through head object
``` sh
aws s3api head-object --bucket metadata-test-bucket-dd --key hello.txt

## CLEANUP

```sh
aws s3 rm s3://metadata-test-bucket-dd/*

aws s3 rb s3://metadata-test-bucket-dd
```