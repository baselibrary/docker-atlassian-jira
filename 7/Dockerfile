FROM baselibrary/java:8
MAINTAINER ShawnMa <qsma@thoughtworks.com>

## Version
ENV JIRA_MAJOR   7
ENV JIRA_VERSION 7.1.6

## Packages
RUN \
  mkdir -p /opt/atlassian &&\
  curl -fsSL "http://confluence.goldpitcher.co.kr/download/attachments/166564246/atlassian-jira-software-${JIRA_VERSION}-jira-${JIRA_VERSION}.tar.gz"| tar -zxvf - --strip-components=1 -C /opt/atlassian

## Configurations
RUN \
  mkdir -p /var/lib/atlassian &&\
  echo "jira.home=/var/lib/jira" > "/opt/atlassian/atlassian-jira/WEB-INF/classes/jira-application.properties"

EXPOSE 8080

WORKDIR /var/lib/jira

VOLUME ["/var/lib/jira"]

CMD ["/opt/atlassian/bin/catalina.sh", "run"]
