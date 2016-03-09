rpm -i --noscripts http://$hostip:8000/$orarpm
chmod 755 /etc/init.d/oracle-xe
mkdir -p /u01/app/oracle/admin/orcl/adump
mkdir -p /u01/app/oracle/admin/xe/adump
mkdir -p /u01/app/oracle/flash_recovery_area
mkdir -p /u01/app/oracle/oradata
mkdir -p /u01/app/oracle/diag
mkdir -p /u01/app/oracle/product/11.2.0/xe/dbs
chown -R oracle:dba /u01
