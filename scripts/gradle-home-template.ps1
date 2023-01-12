# 修改环境变量添加gradle执行文件路径
$env:GRADLE_HOME="D:\develop\gradle-7.5.1"
$env:GRADLE_USER_HOME="D:\develop\gradle-user-home"
$env:Path=$env:GRADLE_HOME+"\bin;"+$env:Path