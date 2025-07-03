#!/bin/bash

echo "Elasticsearchを起動中..."
/usr/local/bin/docker-entrypoint.sh elasticsearch &
ES_PID=$!

(
    echo "初期化スクリプトを実行中..."
    /usr/share/elasticsearch/init-templates.sh
) &

wait $ES_PID
