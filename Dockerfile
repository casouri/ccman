FROM node:22-slim

RUN apt-get update && apt-get install -y curl ca-certificates git && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash claude

USER claude

RUN mkdir -p /home/claude/.npm-global && \
    npm config set prefix '/home/claude/.npm-global' && \
    npm install -g @anthropic-ai/claude-code

RUN mkdir -p /home/claude/.claude && \
    echo '{"apiKeyHelper": "printenv API_KEY", "enabledPlugins": {"rust-analyzer-lsp@claude-plugins-official": true, "typescript-lsp@claude-plugins-official": true}, "spinnerTipsEnabled": false, "prefersReducedMotion": true}' > /home/claude/.claude/settings.json

ENV PATH=/home/claude/.npm-global/bin:$PATH

ENTRYPOINT ["claude", "--dangerously-skip-permissions"]
