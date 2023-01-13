# 代码生成工具

## Gradle脚本部分

- gradle命令脚本
  - [脚本根目录位置](./scripts/)
  - 修改[java-home-template.ps1](./scripts/java-home-template.ps1)文件为`java-home.ps1`
  - 修改[gradle-home-template.ps1](./scripts/gradle-home-template.ps1)文件为`gradle-home.ps1`
  - 修改上面两个文件中的目录信息指向到真实的jdk和gradle目录即可
  - 执行[java-cmd.ps1](./scripts/java-cmd.ps1)可以得到一个java的命令执行环境
  - 执行[gradle-cmd.ps1](./scripts/gradle-cmd.ps1)可以得到一个gradle的命令执行环境

- gradle空项目创建脚本
  - [脚本根目录位置](./scripts/gradle-project/)
  - 复制[gradle-init.ps1](./scripts/gradle-project/gradle-init.ps1)到新项目目录
  - 复制[build.gradle](./scripts/gradle-project/build.gradle)到新项目目录
  - 复制[.gitignore](./scripts/gradle-project/.gitignore)到新项目目录
  - 执行`gradle-init.ps1`初始化项目
  - 默认项目名称就是目录名称
