require 'openssl'
require 'aws-sdk-s3'
key = OpenSSL::PKey::RSA.new(1024)

object_key = "hello.txt"
bucket_name = ENV["BUCKET_NAME"]
region_name = "us-east-1"
# encryption client
s3 = Aws::S3::EncryptionV2::Client.new(
  region: region_name,
  encryption_key: key,
  key_wrap_schema: :rsa_oaep_sha1, # the key_wrap_schema must be rsa_oaep_sha1 for asymmetric keys
  content_encryption_schema: :aes_gcm_no_padding,
  security_profile: :v2 # use :v2_and_legacy to allow reading/decrypting objects encrypted by the V1 encryption client
)


# round-trip an object, encrypted/decrypted locally
File.open('hello.txt', 'rb') do |file| 
  s3.put_object(bucket: bucket_name, key: object_key, body: file)
  puts 'object has been encrypted and uploaded successfully'
end
File.open('downloaded-hello.txt', 'w') do |file|
  file.write(s3.get_object(bucket: bucket_name, key: object_key).body.read)
  puts 'Object has been downloaded and decrypted successfully'
end
  
# reading encrypted object without the encryption client

# results in the getting the cipher text
cipherText = Aws::S3::Client.new(region: region_name).get_object(bucket: bucket_name, key: object_key).body.read

puts "Undecrypted object content: #{cipherText}"
#=> "... cipher text ..."