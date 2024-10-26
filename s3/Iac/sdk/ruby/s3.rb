# Import the AWS SDK for S3 and the SecureRandom library.
# The AWS SDK is used to interact with AWS services, in this case, S3 (Simple Storage Service).
# SecureRandom is used to generate random UUIDs for file content.

require 'aws-sdk-s3'
require 'securerandom'

# Fetch the S3 bucket name from environment variables and set the AWS region.
# The bucket name is stored in an environment variable 'BUCKET_NAME'.
# The region is hardcoded to 'us-east-1', but this can be changed if necessary.
bucket_name = ENV['BUCKET_NAME']
region = "us-east-1"

# Initialize a new S3 client to interact with the S3 service.
client = Aws::S3::Client.new

# Create the bucket in S3 with the name specified in the 'bucket_name' variable.
# The 'create_bucket' method is used to create a new bucket in the specified region.
resp = client.create_bucket({
  bucket: bucket_name
})

# Generate a random number between 1 and 6 to determine how many files will be created and uploaded to the bucket.
# This simulates creating and uploading a random number of files for testing or demonstration purposes.
num_of_files = 1 + rand(6)
puts "Number of files: #{num_of_files}"

# Iterate 'num_of_files' times to create and upload the corresponding number of files.
num_of_files.times.each do |i|
  puts "i: #{i}"  # Output the current index for tracking the file creation process.

  # Define the file name and local output path for each file.
  filename = "file_#{i}.txt"
  output_path = "/tmp/#{filename}"

  # Create and open a file in the '/tmp' directory.
  # The file's content is generated using a random UUID from SecureRandom.
  File.open(output_path, "w") do |file|
    file.write(SecureRandom.uuid)  # Write a random UUID as the content of the file.
  end

  # Open the file in read-binary mode and upload it to the specified S3 bucket.
  # The 'put_object' method is used to upload the file, with the 'key' being the file name and 'body' being the file content.
  File.open(output_path, 'rb') do |file|
    client.put_object(
        bucket: bucket_name,  # The S3 bucket to upload the file to.
        key: filename,        # The name of the file to store in S3.
        body: file            # The file itself as the content to upload.
    )
  end
end
