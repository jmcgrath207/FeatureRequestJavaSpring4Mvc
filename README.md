


Build steps


vagrant up

maven clean

maven compile

maven war: explode

vagrant provision








API

POST

curl -H "Content-Type: application/json" \
-X POST -d '{"client_username": "test", "case_name": "This is a case", "description": "About the Case", "priority": 1, "product_area": "sales", "target_date": "10/21/2017", "status": "10/21/2017"}' \
http://172.28.128.3:8080/api/client_view
