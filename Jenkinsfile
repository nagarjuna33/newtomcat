pipeline{
    agent{
        label 'tomcat'
    }
    stages {

        stage ('tomcat'){
       
       steps{
       sh 'wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.87/bin/apache-tomcat-8.5.87.tar.gz'
       sh 'sudo tar -xzvf apache-tomcat-8.5.87.tar.gz -C /opt'
       sh 'sudo mv /opt/apache-tomcat-8.5.87 /opt/tomcat'
       sh 'sudo chmod +x /opt/tomcat/bin/startup.sh'
       sh 'sudo systemctl daemon-reload'
       sh 'sudo groupadd tomcat'
       sh 'sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat'
       sh 'sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat'
       sh 'sudo chgrp -R tomcat /opt/tomcat'
       sh 'sudo chmod -R g+rwx /opt/tomcat/conf'
       sh 'sudo setfacl -m centos:wrx /opt/tomcat/*'
       sh 'sudo chmod -R g+r /opt/tomcat/conf/*'
       sh 'sudo chown -R tomcat /opt/tomcat/logs/ /opt/tomcat/temp/ /opt/tomcat/webapps/ /opt/tomcat/work/'
       sh 'sudo systemctl start tomcat'
       sh 'sudo systemctl enable tomcat'
       }
        }
        stage ('scm'){
            steps {
                    
                git url: "https://github.com/nagarjunaduggireddy/game-of-life.git",
                    branch: 'master'
            }
        }
        stage ('build package') {
            
            steps {
                sh 'mvn package'
                sh 'cp /home/ansible/remote/workspace/game-of-life/gameoflife-web/target/gameoflife.war  /opt/tomcat/webapps/'
}
   }
    }
}
        
