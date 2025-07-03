#!/bin/bash

echo "Elasticsearchの初期化を開始..."

echo "Elasticsearchサービスの起動を待機中..."
until curl -s http://localhost:9200/_cluster/health | grep -q '"status":"yellow\|green"'; do
    echo "Elasticsearchの起動を待機中..."
    sleep 5
done
echo "Elasticsearchが起動しました"

echo "ClaudeCodeのlogインデックステンプレートを作成中..."
curl -X PUT "localhost:9200/_index_template/claude-code-logs-template" -H 'Content-Type: application/json' -d '{
  "index_patterns": ["claude-code-logs*"],
  "priority": 100,
  "template": {
    "settings": {
      "number_of_shards": 1,
      "number_of_replicas": 0
    },
    "mappings": {
      "properties": {
        "@timestamp": { "type": "date" },
        "Body": { "type": "text" },
        "SeverityText": { "type": "keyword" },
        "SeverityNumber": { "type": "integer" },
        "TraceFlags": { "type": "long" },
        "Attributes": {
          "properties": {
            "session.id": { "type": "keyword" },
            "app.version": { "type": "keyword" },
            "organization.id": { "type": "keyword" },
            "user.account_uuid": { "type": "keyword" },
            "user.email": { "type": "keyword" },
            "user.id": { "type": "keyword" },
            "service.name": { "type": "keyword" },
            "environment": { "type": "keyword" },
            "terminal.type": { "type": "keyword" },
            "model": { "type": "keyword" },
            "type": { "type": "keyword" },
            "tool_name": { "type": "keyword" },
            "decision": { "type": "keyword" },
            "source": { "type": "keyword" },
            "success": { "type": "boolean" },
            "duration_ms": { "type": "long" },
            "cost_usd": { "type": "double" },
            "input_tokens": { "type": "long" },
            "output_tokens": { "type": "long" },
            "cache_read_tokens": { "type": "long" },
            "cache_creation_tokens": { "type": "long" },
            "event.name": { "type": "keyword" },
            "event.timestamp": { "type": "date" },
            "session": {
              "properties": {
                "id": { "type": "keyword" }
              }
            },
            "organization": {
              "properties": {
                "id": { "type": "keyword" }
              }
            },
            "user": {
              "properties": {
                "id": { "type": "keyword" },
                "email": { "type": "keyword" },
                "account_uuid": { "type": "keyword" }
              }
            },
            "service": {
              "properties": {
                "name": { "type": "keyword" }
              }
            },
            "terminal": {
              "properties": {
                "type": { "type": "keyword" }
              }
            }
          }
        },
        "Resource": {
          "properties": {
            "service.name": { "type": "keyword" },
            "service.version": { "type": "keyword" },
            "host.name": { "type": "keyword" },
            "environment": { "type": "keyword" },
            "user.id": { "type": "keyword" }
          }
        },
        "Scope": {
          "properties": {
            "name": { "type": "keyword" },
            "version": { "type": "keyword" }
          }
        }
      }
    }
  }
}' && echo "" && echo "ClaudeCodeのlogインデックステンプレート作成完了"

echo "Elasticsearch初期化完了"
