mkdir ml_project && cd ml_project
git init
dvc init
git commit -m "Initialize dvc project"

dvc get https://github.com/iterative/dataset-registry tutorials/versioning/data.zip
unzip -o -q data.zip && rm -f data.zip
echo "filename" > dataset.csv
find data -type f \( -name "*.jpg" -o -name "*.png" \) ! -name ".*" -exec basename {} \; >> dataset.csv

python3 -c "import boto3; boto3.client('s3', endpoint_url='http://127.0.0.1:5016', aws_access_key_id='minioadmin', aws_secret_access_key='minioadmin').create_bucket(Bucket='my-dvc-bucket')"
dvc remote add -d local_s3 s3://my-dvc-bucket
dvc remote modify local_s3 endpointurl http://127.0.0.1:5016
dvc remote modify local_s3 access_key_id minioadmin
dvc remote modify local_s3 secret_access_key minioadmin

dvc add data dataset.csv
git add data.dvc dataset.csv.dvc .gitignore
git commit -m "Add first version of data/"
git tag -a "v1.0" -m "data v1.0"

dvc push
wc -l dataset.csv
cd ..