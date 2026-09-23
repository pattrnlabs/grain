# Elasticsearch examples

<!-- TODO(open item, see plan doc): confirm which Elasticsearch query style
     Grain actually sends — ES|QL, the legacy SQL API, or raw Query DSL JSON.
     The two files below are written as ES|QL, which is Elastic's current
     SQL-like language; replace with the real dialect before publishing. -->

These are engineer-shaped on purpose — log triage and index health, not
business reporting. If you only ever use Elasticsearch for dashboards, these
may look unfamiliar; that's the point.

- `log-triage.esql` — find and count recent errors in a log index
- `index-health.esql` — which indices are large, unhealthy, or growing fast
