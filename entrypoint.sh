
cd /root/bdsx
if [ ! -d ./bdsx ]
then
    git pull upstream master
    mv -f /root/bdsx/index-new.ts /root/bdsx/index.ts;
fi

BDSX_YES=true ./bdsx-startup.sh
