FROM maven:3.8.1-jdk-8  as builder

# 解决容器时期与真实时间相差 8 小时的问题
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone

# Copy local code to the container image.
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN wget "http://arms-apm-cn-hangzhou.oss-cn-hangzhou.aliyuncs.com/ArmsAgent.zip" -O ArmsAgent.zip
RUN unzip ArmsAgent.zip -d /app/
ENV arms_licenseKey=ckv8e2vzfj@cd6f55fa239375d
ENV arms_appName=testserver
ENV JAVA_TOOL_OPTIONS ${JAVA_TOOL_OPTIONS} '-javaagent:/app/ArmsAgent/aliyun-java-agent.jar -Darms.licenseKey='${arms_licenseKey}' -Darms.appName='${arms_appName}
### 检查JAVA_TOOL_OPTIONS环境变量。
RUN env | grep JAVA_TOOL_OPTIONS

# Build a release artifact.
RUN mvn package -DskipTests

# Run the web service on container startup.
CMD ["java","-jar","/app/target/code-father-backend-0.0.1-SNAPSHOT.jar","--spring.profiles.active=prod"]