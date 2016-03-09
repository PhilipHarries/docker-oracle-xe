
python -m SimpleHTTPServer 8000 &
hostip=`ifconfig docker0|awk '$1 = /inet / {print $2}'`
sed s/%HOSTIP%/${hostip}/ Dockerfile.tmpl > Dockerfile
docker build -t philipharries/oracle-xe .
rm Dockerfile
kill %1

