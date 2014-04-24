@test "OpenJDK Java 6 installs" {
  java -version 2>&1 | grep "1.6"
  java -version 2>&1 | grep "OpenJDK"
}

@test "jboss user created" {
  grep jboss /etc/passwd
}

@test "jboss installed" {
  [[ -f /opt/jboss/jboss-as-7.1.1.Final/bin/standalone.sh ]]
}

@test "jboss setup" {
  [[ -f /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml ]]
  [[ -f /etc/init.d/jboss ]]
  [[ -f /etc/jboss/jboss-as.conf ]]
  [[ -f /opt/jboss/jboss-as-7.1.1.Final/bin/standalone.conf ]]
  [[ -f /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/mgmt-users.properties ]]
}

@test "jboss running" {
  ps -C java
}

@test "management_listen_address override" {
  grep "jboss.bind.address.management:127.0.0.1" /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml
}

@test "mgmt-users override" {
  grep "2a0923285184943425d1f53ddd58ec7a" /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/mgmt-users.properties
}

@test "JAVA_OPTS override" {
  grep "\-Xms128m" /opt/jboss/jboss-as-7.1.1.Final/bin/standalone.conf
  grep "\-Xmx768m" /opt/jboss/jboss-as-7.1.1.Final/bin/standalone.conf
}

@test "mysql_jdbc install override" {
  [[ -f /opt/jboss/jboss-as-7.1.1.Final/modules/com/mysql/main/mysql-connector-java-5.1.25-bin.jar.index ]]
}

@test "customer supplied config override" {
  run grep "Cookbook" /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/application-users.properties
  [ "$status" -eq 1 ]
}
