@test "Oracle Java 7 installs" {
  java -version 2>&1 | grep "1.7"
  java -version 2>&1 | grep "Java(TM)"
}

@test "jboss user created" {
  grep jboss /etc/passwd
}

@test "jboss installed" {
  [[ -f /opt/jboss/jboss-as-7.0.0.Final/bin/standalone.sh ]]
}

@test "jboss setup" {
  [[ -f /opt/jboss/jboss-as-7.0.0.Final/standalone/configuration/standalone.xml ]]
  [[ -f /etc/init.d/jboss ]]
  [[ -f /etc/jboss/jboss-as.conf ]]
  [[ -f /opt/jboss/jboss-as-7.0.0.Final/bin/standalone.conf ]]
  [[ -f /opt/jboss/jboss-as-7.0.0.Final/standalone/configuration/mgmt-users.properties ]]
  [[ -f /opt/jboss/jboss-as-7.0.0.Final/standalone/configuration/application-users.properties ]]
}

@test "jboss running" {
  ps -C java
}
