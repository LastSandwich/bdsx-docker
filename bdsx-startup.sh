cwd=$(pwd)
SCRIPT=$(readlink -f "$0")
cd $(dirname "$SCRIPT")

if [ ! -d "./node_modules" ]; then ./update.sh; fi
if [ $? != 0 ]; then exit $?; fi

if [ ! -d "./bedrock_server" ]; then ./update.sh; fi
if [ $? != 0 ]; then exit $?; fi

if [ -f "/root/bdsx/scripts/pre-start.sh" ]; then /root/bdsx/scripts/pre-start.sh; fi
if [ $? != 0 ]; then exit $?; fi

npm run -s build
if [ $? != 0 ]; then exit $?; fi

#ls -RL /root

if command -v wine &> /dev/null
then
  WINE=wine
elif command -v wine64 &> /dev/null
then
  WINE=wine64
else
  echo 'Error: bdsx requires wine. Please install wine first' >&2
  exit $?
fi

#wine_ver=`wine --version| cut -d'-' -f 2`
#wine_ver_1=`echo wine_ver| cut -d'.' -f 1`
#wine_ver_2=`echo wine_ver| cut -d'.' -f 2`
#wine_ver_3=`echo wine_ver| cut -d'.' -f 3`

cd bedrock_server
WINEDEBUG=fixme-all $WINE ./bedrock_server.exe ..

cd $cwd
exit $?
