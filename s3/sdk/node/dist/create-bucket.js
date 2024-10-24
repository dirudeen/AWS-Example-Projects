"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var index_1 = require("../index");
var client_s3_1 = require("@aws-sdk/client-s3");
var bucket_name = process.argv[2];
if (!bucket_name) {
    throw new Error("Bucket name must provided. e.g node create-bucket bucket-name");
}
var bucketConfig = new client_s3_1.CreateBucketCommand({
    Bucket: bucket_name,
});
index_1.client.send(bucketConfig)
    .then(function (res) { return console.log(res); })
    .catch(function (err) { return console.log(err); });
