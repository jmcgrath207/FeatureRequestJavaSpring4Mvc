


## Local Build steps with maven


mvn install

mvn clean

mvn compile

mvn war:exploded

sudo vagrant up

##### If the build, use this to rerun the ansible provision
sudo vagrant provision

#
sudo vagrant ssh db
mysql -u root -p

##### Tomcat Context - DB info ###

Tomcat Context Path: provisioning/TomCatXml/context.xml

#####Create table

Sql command Path: provisioning/mysqlconfig/mysql_config.sql



##API

####POST

curl -H "Content-Type: application/json" \
-X POST -d '{"client_username": "test", "case_name": "This is a case", "description": "About the Case", "priority": 1, "product_area": "sales", "target_date": "10/21/2017", "status": "10/21/2017"}' \
http://172.28.128.3:8080/api/client_view

####GET

curl http://172.28.128.3:8080/api/client_view
