# ClaudeCodeの使用状況をみるやつ

[ClaudeCodeはOpenTelemetryでメトリクスとログデータを出力することができるらしい](https://docs.anthropic.com/ja/docs/claude-code/monitoring-usage)ので、ログを**Elasticsearch**に入れて**Grafana**で見れるようにしてみました

なお、上記のページによると現状のClaudeCodeのOpenTelemetryサポートはベータ版であり、変更される可能性があるとのことなので、本内容は動作しなくなる可能性があります

## 構成

- **ClaudeCode**: 監視対象
- **Elasticsearch**: ログの収集・永続化
- **OpenTelemetry Collector**: テレメトリーデータの収集・処理
- **Grafana**: データの可視化・ダッシュボード

## クイックスタート

### 1. 環境起動

```bash
docker-compose up -d
```

⚠️ Elasticsearchの起動・初期化に多少時間がかかります

### 2. ClaudeCode実行(環境変数でOpenTelemetryを有効化)

```bash
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_EXPORTER_OTLP_ENDPOINT="http://localhost:4318"
export OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf"
export OTEL_LOGS_EXPORTER="otlp"
claude
```

### 3. ダッシュボードにアクセス

[Grafana](http://localhost:3000/d/claude-code-main) (admin/admin)
