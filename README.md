


## Local Build steps with maven


mvn install

mvn clean

mvn compile

mvn war:exploded

sudo vagrant up

##### If the build, use this to rerun the ansible provision
sudo vagrant provision








API

POST

curl -H "Content-Type: application/json" \
-X POST -d '{"client_username": "test", "case_name": "This is a case", "description": "About the Case", "priority": 1, "product_area": "sales", "target_date": "10/21/2017", "status": "10/21/2017"}' \
http://172.28.128.3:8080/api/client_view
