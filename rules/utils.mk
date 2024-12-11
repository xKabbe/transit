help: ## Show available make commands
	@echo "ℹ️ Available make commands: ℹ️"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk ' \
	BEGIN { \
		FS=": "; \
		bold="\033[1m"; \
		colorgreen="\033[32m"; \
		colormagenta="\033[35m"; \
		colorwhite="\033[37m"; \
		categoryemoji="📦"; \
	}{ \
		cmd=$$1; \
		desc=$$2; \
		path=$$1; \
		split(desc, arr, "## "); \
		desc=arr[2]; \
		split(path, patharr, "/"); \
		filename=patharr[length(patharr)]; \
		split(filename, filenamearr, "."); \
		category=filenamearr[1]; \
		sub(/[^:]*:/, "", cmd); \
		sub(/:[^:]*$:/, "", path); \
		if (category != last_category) { \
			print "\n" categoryemoji bold toupper(category) colorwhite; \
			last_category = category; \
		} \
		printf colormagenta" %-25s "colorwhite" %-45s "colorgreen"[%s] "colorwhite"\n", cmd, desc, path \
	}'
