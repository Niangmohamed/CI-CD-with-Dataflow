gcloud config set project "qwiklabs-gcp-04-4ceca00ad661"
git clone https://github.com/GoogleCloudPlatform/ci-cd-for-data-processing-workflow.git
cd ~/ci-cd-for-data-processing-workflow/env-setup
source set_env.sh
sed -i '185 s/options.getOutput())/options.getOutput()).withNumShards(3)/' ~/ci-cd-for-data-processing-workflow/source-code/data-processing-code/src/main/java/org/apache/beam/examples/WordCount.java
sed -i '26 s/gcr.io\/cloud-solutions-images/corelab/' ~/ci-cd-for-data-processing-workflow/source-code/build-pipeline/build_deploy_test.yaml
gcloud composer environments create $COMPOSER_ENV_NAME     --location $COMPOSER_REGION     --zone $COMPOSER_ZONE_ID     --python-version 2
cd ~/ci-cd-for-data-processing-workflow/env-setup
chmod +x set_composer_variables.sh
./set_composer_variables.sh
export COMPOSER_DAG_BUCKET=$(gcloud composer environments describe $COMPOSER_ENV_NAME \
    --location $COMPOSER_REGION \
    --format="get(config.dagGcsPrefix)")
export COMPOSER_SERVICE_ACCOUNT=$(gcloud composer environments describe $COMPOSER_ENV_NAME \
    --location $COMPOSER_REGION \
    --format="get(config.nodeConfig.serviceAccount)")
cd ~/ci-cd-for-data-processing-workflow/env-setup
chmod +x create_buckets.sh
./create_buckets.sh
gcloud source repos create $SOURCE_CODE_REPO
cp -r ~/ci-cd-for-data-processing-workflow/source-code ~/$SOURCE_CODE_REPO
cd ~/$SOURCE_CODE_REPO
git config --global credential.'https://source.developers.google.com'.helper gcloud.sh
git config --global user.email $(gcloud config list --format 'value(core.account)')
git config --global user.name $(gcloud config list --format 'value(core.account)')
git init
git remote add google     https://source.developers.google.com/p/$GCP_PROJECT_ID/r/$SOURCE_CODE_REPO
git add .
git commit -m 'initial commit'
git push google master
cd ~/ci-cd-for-data-processing-workflow/source-code/build-pipeline
gcloud builds submit --config=build_deploy_test.yaml --substitutions=REPO_NAME=$SOURCE_CODE_REPO,_DATAFLOW_JAR_BUCKET=$DATAFLOW_JAR_BUCKET_TEST,_COMPOSER_INPUT_BUCKET=$INPUT_BUCKET_TEST,_COMPOSER_REF_BUCKET=$REF_BUCKET_TEST,_COMPOSER_DAG_BUCKET=$COMPOSER_DAG_BUCKET,_COMPOSER_ENV_NAME=$COMPOSER_ENV_NAME,_COMPOSER_REGION=$COMPOSER_REGION,_COMPOSER_DAG_NAME_TEST=$COMPOSER_DAG_NAME_TEST
gsutil ls gs://$DATAFLOW_JAR_BUCKET_TEST/dataflow_deployment*.jar
gs://…-composer-dataflow-source-test/dataflow_deployment_e88be61e-50a6-4aa0-beac-38d75871757e.jar
gcloud composer environments describe $COMPOSER_ENV_NAME     --location $COMPOSER_REGION     --format="get(config.airflowUri)"
export DATAFLOW_JAR_FILE_LATEST=$(gcloud composer environments run $COMPOSER_ENV_NAME \
    --location $COMPOSER_REGION variables -- \
    --get dataflow_jar_file_test 2>&1 | grep -i '.jar')
cd ~/ci-cd-for-data-processing-workflow/source-code/build-pipeline
gcloud builds submit --config=deploy_prod.yaml --substitutions=REPO_NAME=$SOURCE_CODE_REPO,_DATAFLOW_JAR_BUCKET_TEST=$DATAFLOW_JAR_BUCKET_TEST,_DATAFLOW_JAR_FILE_LATEST=$DATAFLOW_JAR_FILE_LATEST,_DATAFLOW_JAR_BUCKET_PROD=$DATAFLOW_JAR_BUCKET_PROD,_COMPOSER_INPUT_BUCKET=$INPUT_BUCKET_PROD,_COMPOSER_ENV_NAME=$COMPOSER_ENV_NAME,_COMPOSER_REGION=$COMPOSER_REGION,_COMPOSER_DAG_BUCKET=$COMPOSER_DAG_BUCKET,_COMPOSER_DAG_NAME_PROD=$COMPOSER_DAG_NAME_PROD
gcloud composer environments describe $COMPOSER_ENV_NAME     --location $COMPOSER_REGION     --format="get(config.airflowUri)"
gsutil ls gs://$RESULT_BUCKET_PROD
echo "_DATAFLOW_JAR_BUCKET : ${DATAFLOW_JAR_BUCKET_TEST}
_COMPOSER_INPUT_BUCKET : ${INPUT_BUCKET_TEST}
_COMPOSER_REF_BUCKET : ${REF_BUCKET_TEST}
_COMPOSER_DAG_BUCKET : ${COMPOSER_DAG_BUCKET}
_COMPOSER_ENV_NAME : ${COMPOSER_ENV_NAME}
_COMPOSER_REGION : ${COMPOSER_REGION}
_COMPOSER_DAG_NAME_TEST : ${COMPOSER_DAG_NAME_TEST}"
echo "testword" >>  ~/$SOURCE_CODE_REPO/workflow-dag/support-files/input.txt
echo "testword: 1" >>  ~/$SOURCE_CODE_REPO/workflow-dag/support-files/ref.txt
cd ~/$SOURCE_CODE_REPO
git add .
git commit -m 'change in test files'
git push google master
cd ~/$SOURCE_CODE_REPO
git add .
git commit -m 'change in test files'
git push google master
gcloud auth login
gcloud config set account ACCOUNT
git add .
git commit -m 'change in test files'
git push google master
git config --global http.cookiefile "%USERPROFILE%\.gitcookies"
powershell -noprofile -nologo -command Write-Output "source.developers.google.com`tFALSE`t/`tTRUE`t2147483647`

eval 'set +o history' 2>/dev/null || setopt HIST_IGNORE_SPACE 2>/dev/null
 touch ~/.gitcookies
 chmod 0600 ~/.gitcookies

 git config --global http.cookiefile ~/.gitcookies

 tr , \\t <<\__END__ >>~/.gitcookies
source.developers.google.com,FALSE,/,TRUE,2147483647,o,git-student-00-a869fce70f2e.qwiklabs.net=1//03npkwUkTK63uCgYIARAAGAMSNwF-L9IrKnAHjhsoiX19Qr9wDv-GbxWdSrbzyGPszrEIIMGafYYKLHBcnvGOiQyn2S7KZd4ZVEM
__END__
eval 'set -o history' 2>/dev/null || unsetopt HIST_IGNORE_SPACE 2>/dev/null




git add .
git commit -m 'change in test files'
git push google master
quit
gcloud config set project "qwiklabs-gcp-04-4ceca00ad661"
cd ~/$SOURCE_CODE_REPO
git add .
git commit -m 'change in test files'
git push google master
cloudshell_open --repo_url "https://source.developers.google.com/p/qwiklabs-gcp-04-4ceca00ad661/r/data-pipeline-source" --page "editor" --open_in_editor "./" --git_branch "master" --force_new_clone
git add .
git commit -m 'change in test files'
git push google master
cd ~/$SOURCE_CODE_REPO
git add .
git commit -m 'change in test files'
git push google master
gcloud composer environments describe $COMPOSER_ENV_NAME     --location $COMPOSER_REGION --format="get(config.airflowUri)"
git add .
git commit -m 'change in test files'
git push google master
echo "testword" >>  ~/$SOURCE_CODE_REPO/workflow-dag/support-files/input.txt
echo "testword" >>  ~/data-pipeline-source/workflow-dag/support-files/input.txt
echo "testword: 1" >>  ~/data-pipeline-source/workflow-dag/support-files/ref.txt
cd ~/data-pipeline-source
git add .
git commit -m 'change in test files'
git push google master
git init
git commit -m "Very complicated commit"
