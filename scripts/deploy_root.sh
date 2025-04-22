#!/bin/bash
set -e

TOMCAT_ROOT="/usr/tomcat/webapps/ROOT"
WAR_FILE="/tmp/PolarisCloudService.war"
TMP_ROOT="/tmp/ROOT"

# war 파일 압축 해제
rm -rf "$TMP_ROOT"
mkdir "$TMP_ROOT"
unzip -q "$WAR_FILE" -d "$TMP_ROOT"

# Tomcat 서비스 중지
service tomcat stop

# 기존 ROOT 폴더 백업 및 교체
if [ -d "$TOMCAT_ROOT" ]; then
  mv "$TOMCAT_ROOT" "${TOMCAT_ROOT}_backup_$(date +%s)"
fi
mv "$TMP_ROOT" "$TOMCAT_ROOT"

# Tomcat 서비스 재시작
service tomcat start

# 임시 파일 정리
rm -f "$WAR_FILE"
