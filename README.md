# Requirements

1. java 21 (jdk for build)
2. maven

# How to build

1. Make sure you have JDK installed and $JAVA_HOME environment is set;
2. Maven installed and mvn is available from $PATH;
3. Run ```mvn package``` from project directory.

# How to run

Run command ```java -jar hw-0.0.1-SNAPSHOT.jar``` from target directory

# How to check that app runs correctly

```curl http://localhost:8080 -v```

If you see json in response body with app version then it works.