#!/usr/bin/env bash

# Create the Prometheus driver config
printf "*********************************************************************************\n"
printf "Create the Prometheus driver config\n"
printf "*********************************************************************************\n"

install -m 644 /dev/null ./mynetwork/shared/drivers/prom_jmx_exporter.yaml
cat <<EOF >./mynetwork/shared/drivers/prom_jmx_exporter.yaml
{}
EOF

printf "Created in: ./mynetwork/shared/drivers/prom_jmx_exporter.yaml\n\n"

# Create the Prometheus configuration
printf "*********************************************************************************\n"
printf "Create the Prometheus configuration\n"
printf "*********************************************************************************\n"

install -m 644 /dev/null ./mynetwork/prometheus/prometheus.yaml
cat <<EOF >./mynetwork/prometheus/prometheus.yaml
global:
  scrape_interval: 10s
  external_labels:
    monitor: "corda-network"

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  - alert.yml

alerting:
  alertmanagers:
    - scheme: http
      static_configs:
        - targets: [ 'alertmanager:9093' ]

scrape_configs:
  - job_name: services
    metrics_path: /metrics
    static_configs:
      - targets:
          - 'prometheus:9090'

  - job_name: corda
    static_configs:
       - targets: ["notary:8080"]
   #      labels:
   #        role: "group"
   #        #role: "notary"
       - targets: ["partya:8080", "partyb:8080"]
   #      labels:
   #        role: "group"
           #role: "participant"
  #   relabel_configs:
  #     - source_labels: [__address__]
  #       regex: "([^:]+):\\d+"
  #       target_label: node

  - job_name: 'loki'
    static_configs:
    - targets: ['loki:3100']

  - job_name: 'tempo'
    static_configs:
    - targets: ['tempo:3200']

  - job_name: 'otelcollector'
    static_configs:
    - targets: ['otelcollector:9464']
    # relabel_configs:
    #   - source_labels: [__address__]
    #     regex: "([^:]+):\\d+"
    #     target_label: node
EOF

printf "Created in: ./mynetwork/prometheus/prometheus.yaml\n\n"

# Create the Alert Rule Files
printf "*********************************************************************************\n"
printf "Create the Alert Rule File configuration\n"
printf "*********************************************************************************\n"

install -m 644 /dev/null ./mynetwork/prometheus/alert.yml
cat <<EOF >./mynetwork/prometheus/alert.yml
groups:
  - name: AllInstances
    rules:
      - alert: service_down
        expr: up == 0
        for: 30s
        labels:
          severity: page
        annotations:
          summary: "Instance {{ $labels.instance }} down"
          description: "{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 30 seconds."

      - alert: high_load
        expr: node_load1 > 0.8
        for: 30s
        labels:
          severity: page
        annotations:
          summary: "Instance {{ $labels.instance }} under high load"
          description: "{{ $labels.instance }} of job {{ $labels.job }} is under high load."

      - alert: site_down
        expr: probe_success < 1
        for: 30s
        labels:
          severity: page
        annotations:
          summary: "Site Down: {{$labels.instance}}"
          description: "Site Down: {{$labels.instance}} for more than 30 seconds"
EOF

printf "Created in: ./mynetwork/prometheus/alert.yml\n\n"

# Create the Promtail configuration
printf "*********************************************************************************\n"
printf "Create the Alertmanager configuration\n"
printf "*********************************************************************************\n"

install -m 644 /dev/null ./mynetwork/alertmanager/alertmanager.yml
cat <<EOF >./mynetwork/alertmanager/alertmanager.yml
global:
  resolve_timeout: 1m
  slack_api_url: 'https://hooks.slack.com/services/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'

route:
  # Use this tool to format Slack Messages https://juliusv.com/promslack/
  receiver: 'slack-notifications'
receivers:
  - name: 'slack-notifications'
    slack_configs:
      - channel: '#general'
        send_resolved: true
        icon_url: https://avatars3.githubusercontent.com/u/3380462
        title: |-
          [{{ .Status | toUpper }}{{ if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{ end }}] {{ .CommonLabels.alertname }} for {{ .CommonLabels.job }}
          {{- if gt (len .CommonLabels) (len .GroupLabels) -}}
            {{" "}}(
            {{- with .CommonLabels.Remove .GroupLabels.Names }}
              {{- range $index, $label := .SortedPairs -}}
                {{ if $index }}, {{ end }}
                {{- $label.Name }}="{{ $label.Value -}}"
              {{- end }}
            {{- end -}}
            )
          {{- end }}
        text: >-
          {{ range .Alerts -}}
          *Alert:* {{ .Annotations.title }}{{ if .Labels.severity }} - `{{ .Labels.severity }}`{{ end }}

          *Description:* {{ .Annotations.description }}

          *Details:*
            {{ range .Labels.SortedPairs }} • *{{ .Name }}:* `{{ .Value }}`
            {{ end }}
          {{ end }}
EOF
printf "Created in: ./mynetwork/alertmanager/alertmanager.yml\n\n"

# Create the Promtail configuration
printf "*********************************************************************************\n"
printf "Create the Promtail configuration\n"
printf "*********************************************************************************\n"

install -m 644 /dev/null ./mynetwork/promtail/promtail-config.yaml
cat <<EOF >./mynetwork/promtail/promtail-config.yaml
# Reference @ https://grafana.com/docs/loki/latest/clients/promtail/

server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://loki:3100/loki/api/v1/push

scrape_configs:
  - job_name: notary
    static_configs:
      - targets:
          - notary
        labels:
          __path__: /var/log/notary/*log
    relabel_configs:
      - source_labels: [__address__]
        target_label: node
  - job_name: partya
    static_configs:
      - targets:
          - partya
        labels:
          __path__: /var/log/partya/*log
    relabel_configs:
      - source_labels: [__address__]
        target_label: node
  - job_name: partyb
    static_configs:
      - targets:
          - partyb
        labels:
          __path__: /var/log/partyb/*log
    relabel_configs:
      - source_labels: [__address__]
        target_label: node
EOF

printf "Created in: ./mynetwork/promtail/promtail-config.yaml\n\n"

# Create the Loki configuration
printf "*********************************************************************************\n"
printf "Create the Loki configuration\n"
printf "*********************************************************************************\n"

install -m 644 /dev/null ./mynetwork/loki/loki-config.yaml
cat <<EOF >./mynetwork/loki/loki-config.yaml
auth_enabled: false

server:
  http_listen_port: 3100

ingester:
  wal:
    enabled: true
    dir: /loki/wal
  lifecycler:
    address: 127.0.0.1
    ring:
      kvstore:
        store: inmemory
      replication_factor: 1
    final_sleep: 0s
  chunk_idle_period: 1h       # Any chunk not receiving new logs in this time will be flushed
  max_chunk_age: 1h           # All chunks will be flushed when they hit this age, default is 1h
  chunk_target_size: 1048576  # Loki will attempt to build chunks up to 1.5MB, flushing first if chunk_idle_period or max_chunk_age is reached first
  chunk_retain_period: 30s    # Must be greater than index read cache TTL if using an index cache (Default index read cache TTL is 5m)
  max_transfer_retries: 0     # Chunk transfers disabled

schema_config:
  configs:
    - from: 2020-10-24
      store: boltdb-shipper
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 24h

storage_config:
  boltdb_shipper:
    active_index_directory: /loki/boltdb-shipper-active
    cache_location: /loki/boltdb-shipper-cache
    cache_ttl: 24h         # Can be increased for faster performance over longer query periods, uses more disk space
    shared_store: filesystem
  filesystem:
    directory: /loki/chunks

compactor:
  working_directory: /loki/boltdb-shipper-compactor
  shared_store: filesystem

limits_config:
  reject_old_samples: true
  reject_old_samples_max_age: 168h

chunk_store_config:
  max_look_back_period: 0s

table_manager:
  retention_deletes_enabled: false
  retention_period: 0s

ruler:
  storage:
    type: local
    local:
      directory: /loki/rules
  rule_path: /loki/rules-temp
  alertmanager_url: http://localhost:9093
  ring:
    kvstore:
      store: inmemory
  enable_api: true
EOF

printf "Created in: ./mynetwork/loki/loki-config.yaml\n\n"

printf "*********************************************************************************\n"
printf "COMPLETE\n"
printf "*********************************************************************************\n"