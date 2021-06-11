
## 参考

Presto設定
https://prestodb.io/docs/current/installation/deployment.html


```bash
docker-compose up -d
source ./.env
DATABASE_URL="mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@0.0.0.0:3306/${MYSQL_NAME}" dbmate -d "schema/mysql/migrations" up

trino --server localhost:8080 --catalog mysql --schema mysql
trino --execute 'SELECT * FROM employees;'
```