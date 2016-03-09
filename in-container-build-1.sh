yum -y install bc libaio compat-libstdc++ elfutils-libelf elfutils-libelf-devel glibc glibc-common libgcc libstdc++
rm -rf /var/cache/yum
groupadd dba
useradd -g dba oracle
