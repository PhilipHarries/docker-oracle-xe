echo "export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe" >> /home/oracle/.bashrc
echo "export ORACLE_SID=XE" >> /home/oracle/.bashrc
echo "export ORACLE_BASE=/u01/app/oracle" >> /home/oracle/.bashrc
echo "export PATH=${PATH}:\${ORACLE_HOME}/bin" >> /home/oracle/.bashrc

cp /u01/app/oracle/product/11.2.0/xe/dbs/init.ora /u01/app/oracle/product/11.2.0/xe/dbs/initXE.ora
for orafile in /u01/app/oracle/product/11.2.0/xe/config/scripts/initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts/init.ora /u01/app/oracle/product/11.2.0/xe/dbs/init.ora /u01/app/oracle/product/11.2.0/xe/dbs/initXE.ora;do
	sed 's%<ORACLE_BASE>%/u01/app/oracle%g' ${orafile} | sed s/memory_target/#memory_target/ | sed s/control_files/#control_files/ > /tmp/t.$$ && mv /tmp/t.$$ ${orafile}
	echo "pga_aggregate_target=200540160" >> ${orafile}
	echo "sga_target=601620480" >> ${orafile}
        echo 'control_files=("/u01/app/oracle/product/11.2.0/xe/dbs/control.dbf")' >> ${orafile}
done

sed s/%hostname%/0.0.0.0/ /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora | sed s/%port%/1521/ > /tmp/t && mv /tmp/t /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
chown -R oracle:dba /u01


# section stolen from %pre of oracle xe rpm:
mkdir -p /u01/app/oracle/product/11.2.0/xe/config/log
mkdir -p /u01/app/oracle/product/11.2.0/xe/rdbms/audit
mkdir -p /u01/app/oracle/product/11.2.0/xe/rdbms/log
mkdir -p /u01/app/oracle/product/11.2.0/xe/network/trace
mkdir -p /u01/app/oracle/product/11.2.0/xe/network/log
cd /u01/app/oracle/product/11.2.0/xe/lib
if [ ! -h /u01/app/oracle/product/11.2.0/xe/lib/libclntsh.so ];then
	ln -s libclntsh.so.11.1 libclntsh.so
fi
if [ ! -h /u01/app/oracle/product/11.2.0/xe/lib/libocci.so ];then
	ln -s libocci.so.11.1 libocci.so
fi
if [ ! -h /u01/app/oracle/product/11.2.0/xe/lib/libagtsh.so ];then
	ln -s libagtsh.so.1.0 libagtsh.so
fi
sed -i "s/%ORACLE_HOME%/\/u01\/app\/oracle\/product\/11.2.0\/xe/" /u01/app/oracle/product/11.2.0/xe/rdbms/admin/dbmssml.sql
sed -i "s/%SO_EXT%/so/" /u01/app/oracle/product/11.2.0/xe/rdbms/admin/dbmssml.sql
sed -i "s/%ORACLE_HOME%/\/u01\/app\/oracle\/product\/11.2.0\/xe/g" /u01/app/oracle/product/11.2.0/xe/config/scripts/postScripts.sql
sed -i "s/-lipgo //" /u01/app/oracle/product/11.2.0/xe/lib/sysliblist
sed -i "s/ -lsvml//" /u01/app/oracle/product/11.2.0/xe/lib/sysliblist
/bin/chown oracle:dba /u01/app/oracle
/bin/chown -R oracle:dba /u01/app/oracle/product/11.2.0/xe
/bin/chmod 755 /u01/app/oracle
/bin/chmod 755 /u01/app/oracle/product
/bin/chmod 755 /u01/app/oracle/product/11.2.0
/bin/chmod -R 755 /u01/app/oracle/product/11.2.0/xe
/sbin/ldconfig >/dev/null
/bin/chown oracle:dba /u01/app/oracle
/bin/chown -R oracle:dba /u01/app/oracle/product/11.2.0/xe
/bin/chmod 755 /u01/app/oracle
/bin/chmod 755 /u01/app/oracle/product
/bin/chmod 755 /u01/app/oracle/product/11.2.0
/bin/chmod -R 755 /u01/app/oracle/product/11.2.0/xe
/bin/chmod 755 /etc/init.d/oracle-xe
/sbin/chkconfig --add oracle-xe
/bin/chmod 6751 /u01/app/oracle/product/11.2.0/xe/bin/oracle
/bin/chmod 751 /u01/app/oracle/product/11.2.0/xe/bin/sqlplus
rm -fr /u01/app/oracle/screenrc
rm -fr /u01/app/oracle/gtkrc
rm -fr /u01/app/oracle/emacs
rm -fr /u01/app/oracle/cshrc-DEFAULT_old
rm -fr /u01/app/oracle/cshrc-DEFAULT.06292004
rm -fr /u01/app/oracle/cshrc-DEFAULT
rm -fr /u01/app/oracle/cshrc
rm -fr /u01/app/oracle/bashrc-DEFAULT
rm -fr /u01/app/oracle/bashrc_logout
if [ ! -d /var/tmp/.oracle ];then
	mkdir -p /var/tmp/.oracle
	chmod 01777 /var/tmp/.oracle
	chown root  /var/tmp/.oracle
fi
if [ ! -d /tmp/.oracle ];then
	mkdir -p /tmp/.oracle
	chmod 01777 /tmp/.oracle
	chown root  /tmp/.oracle
fi

/etc/init.d/oracle-xe configure responseFile=/etc/xe.rsp || ( ls /u01/app/oracle/product/11.2.0/xe/config/log && cat /u01/app/oracle/product/11.2.0/xe/config/log )
