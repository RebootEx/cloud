date "+%Y-%m-%d_%H:%M:%S" >> /root/date.txt ; touch $output/0_burp.txt 
cat $var >$output/0_burp.txt 
git clone https://github.com/RebootEx/git 
bash git/git.sh ; rm -r git 
cd /root/script/1_aws/AWSBucketDump
python3 AWSBucketDump.py -l $var ; cat interesting_file.txt|grep -o -P "(?<=//).*?(?=/)" >> cliaws.txt 
sort -u cliaws.txt -o awscli.txt 
sed -e "s/^/aws\ s3\ mv\ D\:\\\1\.txt\ s3\:\/\/&/g" awscli.txt|sed -e "s/$/&\ \-\-no\-sign\-request/g" >>  uploadaws.txt
sed -e "s/^/aws\ s3\ mv\ s3\:\/\/&/g" awscli.txt|sed -e "s/$/&\ D\:\\\aws_bucket\ \-\-recursive\ \-\-no\-sign\-request/g" >>  uploadaws.txt 
cp uploadaws.txt $output/1_AWS.txt ; > interesting_file.txt ; > cliaws.txt ; > awscli.txt ; > uploadaws.txt 
cd /root/script/1_aws/cloud_enum ; echo "python3 cloud_enum.py -t 200 -kf $var -l $output/2_AWS.txt" > aws.sh 
timeout 7200 bash aws.sh ; rm aws.sh ; aws=`cat $output/2_AWS.txt | wc -l` ; if [ "$aws" = "3" ]; then rm $output/2_AWS.txt; fi
date "+%Y-%m-%d_%H:%M:%S" >> /root/date.txt ; echo 'cloud' >> /root/date.txt
