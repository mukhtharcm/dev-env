FROM node:22-bookworm

# System tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    ca-certificates \
    build-essential \
    ripgrep \
    fd-find \
    fzf \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# pnpm
RUN npm install -g pnpm

# Go
RUN curl -fsSL https://go.dev/dl/go1.25.5.linux-amd64.tar.gz | tar -C /usr/local -xzf -
ENV PATH="$PATH:/usr/local/go/bin:/root/go/bin"
ENV GOPATH=/root/go

# Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="$PATH:/root/.bun/bin"

# Neovim
RUN curl -fsSL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz | tar -C /opt -xzf - \
    && ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

# Oh My Zsh (backup for fresh volumes)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
    && cp -r /root/.oh-my-zsh /opt/oh-my-zsh-default \
    && cp /root/.zshrc /opt/zshrc-default

# LazyVim starter (backup for fresh volumes)
RUN git clone https://github.com/LazyVim/starter /opt/lazyvim-starter \
    && rm -rf /opt/lazyvim-starter/.git

# Default shell
RUN chsh -s /bin/zsh root

CMD ["zsh"]
