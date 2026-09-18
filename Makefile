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
PACKAGES := bat btop git htop iterm2 lazygit nvim tmux vim yazi zsh

# Where symlinks are created. Override to stow into a scratch dir (used by CI):
#   make stow STOW_TARGET=/tmp/scratch
STOW_TARGET ?= $(HOME)
STOW := stow --target=$(STOW_TARGET)

# Extra flags for scripts/verify.sh, e.g. VERIFY_FLAGS=--links-only (CI)
VERIFY_FLAGS ?=

# Default target
.DEFAULT_GOAL := help

# Phony targets (not actual files)
.PHONY: help install stow restow unstow test verify lint clean status adopt $(PACKAGES) \
        stow-% restow-% unstow-% test-% verify-% adopt-%

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
	@echo "  $(YELLOW)verify-PACKAGE$(NC)  Verify a specific package is correctly stowed"
	@echo "  $(YELLOW)adopt-PACKAGE$(NC)   Adopt existing \$$HOME files for a package"
	@echo ""
	@echo "$(GREEN)Packages:$(NC)"
	@echo "  $(PACKAGES)"

##@ Main Operations

install: ## Bootstrap a new machine (Xcode CLT + Homebrew + essential packages; hardware, nice-to-have and App Store apps optional)
	@echo "$(GREEN)Running install script...$(NC)"
	@bash $(CURDIR)/install.sh

stow: ## Stow all packages
	@echo "$(GREEN)Stowing all packages...$(NC)"
	@$(STOW) -v $(PACKAGES)
	@echo "$(GREEN)✓ All packages stowed$(NC)"

restow: ## Restow all packages (re-link)
	@echo "$(YELLOW)Restowing all packages...$(NC)"
	@$(STOW) -Rv $(PACKAGES)
	@echo "$(GREEN)✓ All packages restowed$(NC)"

unstow: ## Unstow all packages (remove symlinks)
	@echo "$(RED)Unstowing all packages...$(NC)"
	@$(STOW) -Dv $(PACKAGES)
	@echo "$(GREEN)✓ All packages unstowed$(NC)"

test: ## Dry run - show what would be stowed
	@echo "$(BLUE)Testing stow operations (dry run)...$(NC)"
	@$(STOW) -nv $(PACKAGES)
	@echo "$(BLUE)✓ Test complete (no changes made)$(NC)"

verify: ## Verify all packages are correctly stowed and Brewfile deps are installed
	@echo "$(BLUE)Verifying stowed packages...$(NC)"
	@$(CURDIR)/scripts/verify.sh --target $(STOW_TARGET) $(VERIFY_FLAGS) $(PACKAGES)

lint: ## Lint scripts and workflows, validate Brewfiles, check PACKAGES matches disk
	@echo "$(BLUE)Linting...$(NC)"
	@shellcheck install.sh scripts/*.sh
	@actionlint
	@$(CURDIR)/scripts/check-brewfiles.sh
	@$(CURDIR)/scripts/check-packages.sh
	@echo "$(GREEN)✓ Lint clean$(NC)"

##@ Individual Package Operations

stow-%: ## Stow a specific package
	@echo "$(GREEN)Stowing $*...$(NC)"
	@$(STOW) -v $*
	@echo "$(GREEN)✓ $* stowed$(NC)"

restow-%: ## Restow a specific package
	@echo "$(YELLOW)Restowing $*...$(NC)"
	@$(STOW) -Rv $*
	@echo "$(GREEN)✓ $* restowed$(NC)"

unstow-%: ## Unstow a specific package
	@echo "$(RED)Unstowing $*...$(NC)"
	@$(STOW) -Dv $*
	@echo "$(GREEN)✓ $* unstowed$(NC)"

test-%: ## Test a specific package (dry run)
	@echo "$(BLUE)Testing $* (dry run)...$(NC)"
	@$(STOW) -nv $*
	@echo "$(BLUE)✓ Test complete (no changes made)$(NC)"

verify-%: ## Verify a specific package is correctly stowed (links only)
	@$(CURDIR)/scripts/verify.sh --target $(STOW_TARGET) --links-only $*

##@ Adopt (import existing $HOME files into packages)

adopt: ## Adopt all packages (moves $HOME files into pkg dir, then symlinks - review git diff after)
	@echo "$(YELLOW)Adopting existing files into packages...$(NC)"
	@echo "$(YELLOW)Pre-adopt status:$(NC)"
	@git status --short
	@$(STOW) --adopt -v $(PACKAGES)
	@echo ""
	@echo "$(YELLOW)Post-adopt diff (review carefully before committing):$(NC)"
	@git diff --stat
	@echo "$(GREEN)✓ Adopt complete - run 'git diff' to review changes$(NC)"

adopt-%: ## Adopt a specific package
	@echo "$(YELLOW)Adopting $*...$(NC)"
	@git status --short
	@$(STOW) --adopt -v $*
	@echo ""
	@echo "$(YELLOW)Post-adopt diff:$(NC)"
	@git diff --stat
	@echo "$(GREEN)✓ $* adopted - run 'git diff' to review changes$(NC)"

##@ Utilities

status: ## Show status of stowed packages
	@echo "$(BLUE)Checking stow status...$(NC)"
	@for pkg in $(PACKAGES); do \
		printf "$(YELLOW)$$pkg:$(NC) "; \
		if ! $(STOW) -nv $$pkg 2>&1 | grep -q "^LINK:"; then \
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
