#!/usr/bin/env bash
set -euo pipefail

required=(AWS_CODE_ARTIFACT_DOMAIN AWS_ACCOUNT_ID AWS_CODE_ARTIFACT_REPOSITORY REGISTRY_NAMESPACE)
missing=()
for v in "${required[@]}"; do
  if [[ -z "${!v:-}" ]]; then
    missing+=("$v")
  fi
done

if (( ${#missing[@]} )); then
  echo "ERROR: missing required environment variables:" >&2
  for m in "${missing[@]}"; do
    echo "  - $m" >&2
  done
  exit 1
fi

if [[ -n "${CODEARTIFACT_AUTH_TOKEN:-}" ]]; then
  # Token already provided (e.g. CI/Renovate) — configure npmrc directly without AWS CLI
  region="${AWS_REGION:-${AWS_DEFAULT_REGION:?AWS_REGION or AWS_DEFAULT_REGION must be set}}"
  registry_host="${AWS_CODE_ARTIFACT_DOMAIN}-${AWS_ACCOUNT_ID}.d.codeartifact.${region}.amazonaws.com"
  registry_url="https://${registry_host}/npm/${AWS_CODE_ARTIFACT_REPOSITORY}/"
  npm config set "//${registry_host}/npm/${AWS_CODE_ARTIFACT_REPOSITORY}/:_authToken" "${CODEARTIFACT_AUTH_TOKEN}"
  npm config set "${REGISTRY_NAMESPACE}:registry" "${registry_url}"
else
  aws codeartifact login \
    --tool npm \
    --domain "$AWS_CODE_ARTIFACT_DOMAIN" \
    --domain-owner "$AWS_ACCOUNT_ID" \
    --repository "$AWS_CODE_ARTIFACT_REPOSITORY" \
    --namespace "$REGISTRY_NAMESPACE"
fi