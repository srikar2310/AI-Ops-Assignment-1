cd ml_project
dvc get https://github.com/iterative/dataset-registry tutorials/versioning/new-labels.zip
unzip -o -q new-labels.zip && rm -f new-labels.zip
echo "filename" > dataset.csv
find data -type f \( -name "*.jpg" -o -name "*.png" \) ! -name ".*" -exec basename {} \; >> dataset.csv
dvc add data dataset.csv
git add data.dvc dataset.csv.dvc .gitignore
git commit -m "Second version of data/ with added rows"
dvc push
wc -l dataset.csv
cd ..