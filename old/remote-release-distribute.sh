#!/bin/bash

# -----------------------------------------------------------------------------
# リリース資材を配布し、リリースツールを実行するツール
# -----------------------------------------------------------------------------
# 2017.01.19 created by nagakuray
#
# Usage :
#   $ remote-release-distribute.sh param1 param2 param3
#       param1 - ホスト名
#       param2 - ユーザ名
#       param3 - リリース資材のtarファイル名
#

HOSTNAME=$1
USERNAME=$2
FILENAME=$3
DIRNAME="`date +"%Y%m%d"`_HOSTNAME"

# 引数チェック
CMDNAME=`basename $0`
if [ $# -ne 3 ]; then
  echo "Usage: $CMDNAME [hostname] [username] [filename(tar)]" 1>&2
  exit 1
fi

echo "${HOSTNAME}でリリースツール実行します。いいですか(Y/N)"
read ans

if [ $ans = "Y" ]; then
  # 作業用ディレクトリ作成
  ssh -p 2222 $USERNAME@$HOSTNAME "mkdir -p /tmp/$DIRNAME"

  # 配布コマンド
  echo "== start copy release-resoures =="
  scp -P 2222 $FILENAME vagrant@$HOSTNAME:/tmp
  if [ $? -ne 0 ]; then
    echo " 異常終了：リリース資材のコピーに失敗しました。"
    ssh -p 2222 vagrant@$HOSTNAME "rm -rf /tmp/$DIRNAME"
    exit 255
  fi

  # リモート実行コマンド
  echo "== start exec release-tool =="
  ssh -p 2222 vagrant@$HOSTNAME "ls -l / ; touch /tmp/hoge ; ls -l /tmp"
  if [ $? -ne 0 ]; then
    echo "異常終了；リリースツールの実行に失敗しました。"
    ssh -p 2222 vagrant@$HOSTNAME "mkdir -p /tmp/$DIRNAME"
    exit 255
  fi

else
  echo "リリースツールを実行せずに終了しました。"
  exit 0
fi

echo "リリースツールが正常に終了しました。"
exit 0
