#cloud-config
package_update: true
package_upgrade: true
packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - software-properties-common
runcmd:
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  - echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
  - apt-get update
  - apt-get install -y docker-ce docker-ce-cli containerd.io
  - systemctl start docker
  - systemctl enable docker
  - mkdir /home/harperdb
  - mkdir /home/harperdb/hdb
  - sudo chmod -R a+rw /home/harperdb/hdb
  - sudo docker run -d -v /home/harperdb/hdb:/home/harperdb/hdb -e HDB_ADMIN_USERNAME=HDB_ADMIN -e HDB_ADMIN_PASSWORD=password -e THREADS=4 -e OPERATIONSAPI_NETWORK_PORT=null -e OPERATIONSAPI_NETWORK_SECUREPORT=9925 -e HTTP_SECUREPORT=9926 -e CLUSTERING_ENABLED=true -e CLUSTERING_USER=cluster_user -e CLUSTERING_PASSWORD=password -e CLUSTERING_NODENAME=${clustering_nodename} -p 9925:9925 -p 9926:9926 -p 9932:9932 harperdb/harperdb
