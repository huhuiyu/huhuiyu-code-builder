# 初始化一个空的gradle项目目录结构
# 目录名称
$pathSrc='src'
$pathMain='main'
$pathTest='test'
$pathJava='java'
$pathRes='resources'
# 获取当前目录
$currentyDir = Split-Path -Parent $MyInvocation.MyCommand.Definition;
echo 'current dir========>$currentyDir';
# 创建src目录
if((test-path $currentyDir\$pathSrc) -ne 'True'){
  new-item -path $currentyDir -name $pathSrc -itemtype 'directory'
}
Set-Location $currentyDir\$pathSrc
# 创建main目录
if((test-path $currentyDir\$pathSrc\$pathMain) -ne 'True'){
  new-item -path $currentyDir\$pathSrc -name $pathMain -itemtype 'directory'
}
# 创建test目录
if((test-path $currentyDir\$pathSrc\$pathTest) -ne 'True'){
  new-item -path $currentyDir\$pathSrc -name $pathTest -itemtype 'directory'
}
# 创建main相关目录
Set-Location $currentyDir\$pathSrc\$pathMain
if((test-path $currentyDir\$pathSrc\$pathMain\$pathJava) -ne 'True'){
  new-item -path $currentyDir\$pathSrc\$pathMain -name $pathJava -itemtype 'directory'
}
if((test-path $currentyDir\$pathSrc\$pathMain\$pathRes) -ne 'True'){
  new-item -path $currentyDir\$pathSrc\$pathMain -name $pathRes -itemtype 'directory'
}
# 创建test相关目录
Set-Location $currentyDir\$pathSrc\$pathTest
if((test-path $currentyDir\$pathSrc\$pathTest\$pathJava) -ne 'True'){
  new-item -path $currentyDir\$pathSrc\$pathTest -name $pathJava -itemtype 'directory'
}
if((test-path $currentyDir\$pathSrc\$pathTest\$pathRes) -ne 'True'){
  new-item -path $currentyDir\$pathSrc\$pathTest -name $pathRes -itemtype 'directory'
}
# 回到根目录
Set-Location $currentyDir
# gradle初始文件
$settingsGradle='settings.gradle'
if((test-path $currentyDir\$settingsGradle) -eq 'True'){
  remove-item $currentyDir\$settingsGradle
}
new-item $currentyDir\$settingsGradle
$projectName=(get-item $currentyDir).name
set-content $currentyDir\$settingsGradle -value "rootProject.name = '$projectName'"
