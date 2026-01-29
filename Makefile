# Dotfiles Management with GNU Stow
# This Makefile manages dotfiles installation using GNU Stow
# Each subdirectory represents a package that can be selectively installed

# Configuration Variables
TARGET_DIR := $(HOME)
DOTFILES_DIR := $(shell pwd)
STOW := stow --target=$(TARGET_DIR) --dir=$(DOTFILES_DIR)
PACKAGES := $(shell find . -maxdepth 1 -type d ! -name '.*' ! -name '.' -printf '%f\n' | sort)

# Check for GNU Stow
STOW_BIN := $(shell command -v stow 2>/dev/null)

.DEFAULT_GOAL := help

# Dependency Check
.PHONY: check-deps
check-deps:
ifndef STOW_BIN
	$(error GNU Stow is not installed. Install with: apt install stow / brew install stow)
endif

# Help Target (Default)
.PHONY: help
help:
	@echo "Dotfiles Management with GNU Stow"
	@echo ""
	@echo "Usage:"
	@echo "  make help                    - Display this help message"
	@echo "  make list                    - List all available packages"
	@echo "  make install                 - Install all packages"
	@echo "  make install PKGS='pkg1 pkg2' - Install specific packages"
	@echo "  make uninstall               - Uninstall all packages"
	@echo "  make uninstall PKGS='pkg1'   - Uninstall specific packages"
	@echo "  make update                  - Re-stow all packages"
	@echo "  make update PKGS='pkg1'      - Re-stow specific packages"
	@echo "  make status                  - Show installation status"
	@echo ""
	@echo "Available packages:"
	@$(foreach pkg,$(PACKAGES),echo "  - $(pkg)";)

# List Target
.PHONY: list
list:
	@echo "Available packages:"
	@$(foreach pkg,$(PACKAGES),echo "  $(pkg)";)

# Install Target
.PHONY: install
install: check-deps
	@$(call install_packages,$(or $(PKGS),$(PACKAGES)))

# Uninstall Target
.PHONY: uninstall
uninstall: check-deps
	@$(call uninstall_packages,$(or $(PKGS),$(PACKAGES)))

# Update Target
.PHONY: update
update: check-deps
	@$(call update_packages,$(or $(PKGS),$(PACKAGES)))

# Status Target
.PHONY: status
status: check-deps
	@echo "Package Status:"
	@for pkg in $(PACKAGES); do \
		if [ -d "$$pkg" ]; then \
			installed=false; \
			find "$$pkg" \( -type f -o -type l -o -type d \) ! -path "$$pkg" | sed "s|^$$pkg/||" | while IFS= read -r file; do \
				if [ -n "$$file" ]; then \
					target_file="$(TARGET_DIR)/$$file"; \
					if [ -L "$$target_file" ] || [ -e "$$target_file" ]; then \
						if [ -L "$$target_file" ]; then \
							link_target=$$(readlink "$$target_file"); \
							abs_link_target=$$(readlink -f "$$target_file" 2>/dev/null || echo ""); \
							if echo "$$link_target" | grep -q "dotfiles/$$pkg" || echo "$$abs_link_target" | grep -q "$(DOTFILES_DIR)/$$pkg"; then \
								echo "installed"; \
								exit 0; \
							fi; \
						fi; \
						parent_dir=$$(dirname "$$target_file"); \
						while [ "$$parent_dir" != "$(TARGET_DIR)" ] && [ "$$parent_dir" != "/" ]; do \
							if [ -L "$$parent_dir" ]; then \
								link_target=$$(readlink "$$parent_dir"); \
								abs_link_target=$$(readlink -f "$$parent_dir" 2>/dev/null || echo ""); \
								if echo "$$link_target" | grep -q "dotfiles/$$pkg" || echo "$$abs_link_target" | grep -q "$(DOTFILES_DIR)/$$pkg"; then \
									echo "installed"; \
									exit 0; \
								fi; \
							fi; \
							parent_dir=$$(dirname "$$parent_dir"); \
						done; \
					fi; \
				fi; \
			done | grep -q "installed" && installed=true; \
			if [ "$$installed" = "true" ]; then \
				echo "  [x] $$pkg (installed)"; \
			else \
				echo "  [ ] $$pkg (not installed)"; \
			fi; \
		fi; \
	done

# Utility Functions

# Install packages function
define install_packages
	@for pkg in $(1); do \
		if [ ! -d "$$pkg" ]; then \
			echo "Error: Package '$$pkg' does not exist"; \
			echo "Available packages: $(PACKAGES)"; \
			exit 1; \
		fi; \
		echo "Installing $$pkg..."; \
		conflicts=$$($(STOW) --no --verbose $$pkg 2>&1 | grep "existing target" || true); \
		if [ -n "$$conflicts" ]; then \
			echo ""; \
			echo "Conflicts detected for package '$$pkg':"; \
			echo "$$conflicts" | sed 's/^/  /'; \
			echo ""; \
			printf "Replace all conflicting files? [y/N]: "; \
			read -r response; \
			case "$$response" in \
				[yY]) \
					echo "Removing conflicts..."; \
					echo "$$conflicts" | grep "existing target" | sed 's/.*existing target is.*: //' | while IFS= read -r file; do \
						if [ -n "$$file" ]; then \
							target="$(TARGET_DIR)/$$file"; \
							if [ -e "$$target" ] && [ ! -L "$$target" ]; then \
								rm -rf "$$target"; \
								echo "  Removed: $$file"; \
							elif [ -L "$$target" ]; then \
								link_target=$$(readlink "$$target"); \
								if ! echo "$$link_target" | grep -q "$(DOTFILES_DIR)"; then \
									rm -f "$$target"; \
									echo "  Removed: $$file (external symlink)"; \
								fi; \
							fi; \
						fi; \
					done; \
					;; \
				*) \
					echo "Installation aborted."; \
					exit 1; \
					;; \
			esac; \
		fi; \
		$(STOW) $$pkg; \
		echo "  Done."; \
	done
endef

# Uninstall packages function
define uninstall_packages
	@for pkg in $(1); do \
		if [ ! -d "$$pkg" ]; then \
			echo "Error: Package '$$pkg' does not exist"; \
			echo "Available packages: $(PACKAGES)"; \
			exit 1; \
		fi; \
		echo "Uninstalling $$pkg..."; \
		$(STOW) -D $$pkg 2>/dev/null || true; \
		echo "  Done."; \
	done
endef

# Update packages function
define update_packages
	@for pkg in $(1); do \
		if [ ! -d "$$pkg" ]; then \
			echo "Error: Package '$$pkg' does not exist"; \
			echo "Available packages: $(PACKAGES)"; \
			exit 1; \
		fi; \
		echo "Updating $$pkg..."; \
		$(STOW) -R $$pkg; \
		echo "  Done."; \
	done
endef
