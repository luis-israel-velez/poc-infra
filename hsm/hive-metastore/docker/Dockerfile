FROM debian:bookworm
LABEL hive-metastore-version="3.0.0"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ARG HADOOP_VERSION=3.2.0

RUN apt-get update && \
    apt-get install -y curl --no-install-recommends && \
    apt-get install -y ca-certificates && \
    apt-get install -y default-jre && \
    apt-get install -y default-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Setup JAVA Home
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64/
#RUN export JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))"

# Install Gomplate
RUN curl -sfSL https://github.com/hairyhenderson/gomplate/releases/download/v3.11.5/gomplate_linux-amd64 \
      -o /usr/local/bin/gomplate \
    && chmod 755 /usr/local/bin/gomplate


# Set Hadoop/HiveMetastore variables and Classpath
ENV HADOOP_HOME="/opt/hadoop"
ENV METASTORE_HOME="/opt/hive-metastore"
ENV HADOOP_CLASSPATH="${HADOOP_HOME}/share/hadoop/tools/lib/*:${METASTORE_HOME}/lib"
ENV PATH="${HADOOP_HOME}/bin:${METASTORE_HOME}/lib/:${HADOOP_HOME}/share/hadoop/tools/lib/:/opt/postgresql-jdbc.jar:${PATH}"

# Download and extract the Hadoop binary package.
RUN curl -s https://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
        | tar xz -C /opt/  \
        && ln -s ${HADOOP_HOME}-$HADOOP_VERSION ${HADOOP_HOME} \
        && rm -r ${HADOOP_HOME}/share/doc

# Add S3a jars to the Hadoop classpath
RUN cp ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws* ${HADOOP_HOME}/share/hadoop/common/lib/ && \
    cp ${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk* ${HADOOP_HOME}/share/hadoop/common/lib/

# Download and install the standalone metastore binary 
# (Standalone Metastore is available after 3.0.0 version)
RUN curl -s http://apache.uvigo.es/hive/hive-standalone-metastore-3.0.0/hive-standalone-metastore-3.0.0-bin.tar.gz \
        | tar xz -C /opt/ \
        && ln -s /opt/apache-hive-metastore-3.0.0-bin ${METASTORE_HOME}
# Add jars to the Hive Metastore classpath
RUN cp ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws* ${METASTORE_HOME}/lib/ && \
    cp ${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk* ${METASTORE_HOME}/lib/

# Download and install the postgres connector used by HiveMetastore
RUN curl -s https://jdbc.postgresql.org/download/postgresql-42.2.16.jar -o postgresql-42.2.16.jar && mv postgresql-42.2.16.jar /opt/postgresql-jdbc.jar
RUN cp /opt/postgresql-jdbc.jar  ${HADOOP_HOME}/share/hadoop/common/lib/ && chmod -R 775 ${HADOOP_HOME}/share/hadoop/common/lib/*
RUN cp /opt/postgresql-jdbc.jar ${METASTORE_HOME}/lib/ && chmod -R 775 ${METASTORE_HOME}/lib/*

COPY entrypoint.sh ${METASTORE_HOME}/bin/
# RUN mkdir ${METASTORE_HOME}/conf/templates
# COPY ../configsets/metastore-site.xml.tpl ${METASTORE_HOME}/conf/templates/
RUN chmod 775 ${METASTORE_HOME}/bin/entrypoint.sh
# RUN chmod 775 ${METASTORE_HOME}/conf/templates/metastore-site.xml.tpl

# Metastore URI Port
EXPOSE 9083

WORKDIR ${METASTORE_HOME}

# Apply Hive custom configurations and start Metastore Service through entrypoint.sh file 
#
# We need to use the exec form to avoid running our command in a subshell and omitting signals,
# thus being unable to shut down gracefully:
# https://docs.docker.com/engine/reference/builder/#entrypoint
#
# Also we need to use relative path, because the exec form does not invoke a command shell,
# thus normal shell processing does not happen:
# https://docs.docker.com/engine/reference/builder/#exec-form-entrypoint-example


# Setup correct keys to connect to S3 Bucket Don't push to repo...
ENV AWS_ACCESS_KEY_ID="<ID HERE>"
ENV AWS_SECRET_KEY="<Pass HERE>"

CMD ["bin/entrypoint.sh"]
#CMD ["/bin/bash"]