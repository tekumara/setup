# fix for https://github.com/eysenfalk/pi-search/issues/4
alias pi='OPENAI_API_KEY=$(jq -r ".OPENAI_API_KEY" ~/.codex/auth.json) pi'
