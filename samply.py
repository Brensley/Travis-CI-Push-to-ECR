##### location containers/sample_container/code/sample.py
import boto3
import os

def main():
	bucket = os.environ['bucket']
	key = os.environ['key']

	if(bucket != None and bucket != "None"):
		s3 = boto3.resource('s3')
		bucketObj = s3.Bucket(bucket)
		bucketObj.download_file(key, key.split("/")[-1])

		client = boto3.client('s3')
		transfer = boto3.s3.transfer.S3Transfer(client)
		transfer.upload_file(key.split("/")[-1], bucket, key.replace(key.split("/")[0], 'model_data_output'))
		os.remove(key.split("/")[-1])
	return True


if __name__ == '__main__':
    main()