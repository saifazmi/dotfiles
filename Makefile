# Dotfiles Management Makefile
# Manages GNU Stow operations for dotfiles
#
# Usage:
#   make help     - Show this help message
#   make stow     - Stow all packages
#   make restow   - Restow all packages (useful after changes)
#   make unstow   - Unstow all packages
#   make test     - Dry run (show what would be stowed)

# List of all stow packages
PACKAGES := bat btop git htop lazygit nvim tmux vim yazi zsh

# Default target
.DEFAULT_GOAL := help

# Phony targets (not actual files)
.PHONY: help stow restow unstow test clean status $(PACKAGES) \
        stow-% restow-% unstow-% test-%

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

##@ Help

help: ## Show this help message
	@echo "$(BLUE)Dotfiles Management$(NC)"
	@echo ""
	@echo "$(GREEN)Available targets:$(NC)"
	@awk 'BEGIN {FS = ":.*##"; printf ""} \
		/^[a-zA-Z_-]+:.*?##/ { printf "  $(YELLOW)%-15s$(NC) %s\n", $$1, $$2 } \
		/^##@/ { printf "\n$(BLUE)%s$(NC)\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""
	@echo "$(GREEN)Individual package targets:$(NC)"
	@echo "  $(YELLOW)stow-PACKAGE$(NC)    Stow a specific package (e.g., make stow-nvim)"
	@echo "  $(YELLOW)restow-PACKAGE$(NC)  Restow a specific package"
	@echo "  $(YELLOW)unstow-PACKAGE$(NC)  Unstow a specific package"
	@echo "  $(YELLOW)test-PACKAGE$(NC)    Test a specific package (dry run)"
	@echo ""
	@echo "$(GREEN)Packages:$(NC)"
	@echo "  $(PACKAGES)"

##@ Main Operations

stow: ## Stow all packages
	@echo "$(GREEN)Stowing all packages...$(NC)"
	@stow -v $(PACKAGES)
	@echo "$(GREEN)✓ All packages stowed$(NC)"

restow: ## Restow all packages (re-link)
	@echo "$(YELLOW)Restowing all packages...$(NC)"
	@stow -Rv $(PACKAGES)
	@echo "$(GREEN)✓ All packages restowed$(NC)"

unstow: ## Unstow all packages (remove symlinks)
	@echo "$(RED)Unstowing all packages...$(NC)"
	@stow -Dv $(PACKAGES)
	@echo "$(GREEN)✓ All packages unstowed$(NC)"

test: ## Dry run - show what would be stowed
	@echo "$(BLUE)Testing stow operations (dry run)...$(NC)"
	@stow -nv $(PACKAGES)
	@echo "$(BLUE)✓ Test complete (no changes made)$(NC)"

##@ Individual Package Operations

stow-%: ## Stow a specific package
	@echo "$(GREEN)Stowing $*...$(NC)"
	@stow -v $*
	@echo "$(GREEN)✓ $* stowed$(NC)"

restow-%: ## Restow a specific package
	@echo "$(YELLOW)Restowing $*...$(NC)"
	@stow -Rv $*
	@echo "$(GREEN)✓ $* restowed$(NC)"

unstow-%: ## Unstow a specific package
	@echo "$(RED)Unstowing $*...$(NC)"
	@stow -Dv $*
	@echo "$(GREEN)✓ $* unstowed$(NC)"

test-%: ## Test a specific package (dry run)
	@echo "$(BLUE)Testing $* (dry run)...$(NC)"
	@stow -nv $*
	@echo "$(BLUE)✓ Test complete (no changes made)$(NC)"

##@ Utilities

status: ## Show status of stowed packages
	@echo "$(BLUE)Checking stow status...$(NC)"
	@for pkg in $(PACKAGES); do \
		echo -n "$(YELLOW)$$pkg:$(NC) "; \
		if stow -n $$pkg 2>&1 | grep -q "already stowed"; then \
			echo "$(GREEN)✓ stowed$(NC)"; \
		else \
			echo "$(RED)✗ not stowed$(NC)"; \
		fi \
	done

clean: ## Remove broken symlinks in home directory
	@echo "$(YELLOW)Removing broken symlinks from $(HOME)...$(NC)"
	@find $(HOME) -maxdepth 1 -type l ! -exec test -e {} \; -print -delete
	@find $(HOME)/.config -maxdepth 2 -type l ! -exec test -e {} \; -print -delete 2>/dev/null || true
	@echo "$(GREEN)✓ Cleanup complete$(NC)"

##@ Git Operations

git-status: ## Show git status
	@git status

git-add: ## Add stow config files to git
	@echo "$(GREEN)Adding stow configuration files...$(NC)"
	@git add .stowrc .stow-local-ignore Makefile
	@echo "$(GREEN)✓ Files staged$(NC)"

git-commit: ## Commit stow config changes
	@echo "$(YELLOW)Committing stow configuration...$(NC)"
	@git add .stowrc .stow-local-ignore Makefile
	@git commit -m "[dotfiles] update stow configuration"
