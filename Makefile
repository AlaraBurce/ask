# Engineering Action Plan Pipeline
# Usage: make -j action.plan.md
# Requires: ask script in PATH, codebase.txt present

.PHONY: all clean

all: action.plan.md

# Phase 1 FAN-OUT (parallel)

quality.md: codebase.txt
	cat codebase.txt | ask "Analyze code for quality issues: readability, structure, and duplication. Output 5–7 bullets in the format: problem → fix." > $@

perf.md: codebase.txt
	cat codebase.txt | ask "Analyze code for performance issues: bottlenecks and inefficiencies. Output 5–7 bullets in the format: issue → optimization." > $@

security.md: codebase.txt
	cat codebase.txt | ask "Analyze code for security vulnerabilities and unsafe patterns. Output 5–7 bullets in the format: risk → mitigation." > $@

# Phase 2 LOCAL SUMMARIZATION

quality.sum.md: quality.md
	cat quality.md | ask "Compress to exactly 5 bullets. Keep only actionable items. No preamble." > $@

perf.sum.md: perf.md
	cat perf.md | ask "Compress to exactly 5 bullets. Keep only actionable items. No preamble." > $@

security.sum.md: security.md
	cat security.md | ask "Compress to exactly 5 bullets. Keep only actionable items. No preamble." > $@

# Phase 3 CONCAT REPORT (no LLM)

concatenated.md: quality.sum.md perf.sum.md security.sum.md
	{ \
	  echo "## Code Quality"; \
	  cat quality.sum.md; \
	  echo ""; \
	  echo "## Performance"; \
	  cat perf.sum.md; \
	  echo ""; \
	  echo "## Security"; \
	  cat security.sum.md; \
	} > $@

# Phase 4 FAN-IN #1 (LLM Refine)

refined.md: concatenated.md
	cat concatenated.md | ask "You are a senior engineer. Refine the following report sections: Code Quality, Performance, Security. Remove duplicates, keep high-signal issues only. Output the same three sections in clean markdown." > $@

# Phase 5 — FAN-IN #2 (Final Action Plan)

action.plan.md: refined.md concatenated.md
	cat concatenated.md | ask "You are a senior engineer. Generate a final 'Engineering Action Plan' in markdown. Include: prioritized actions labeled High/Medium/Low, effort estimate (Small/Medium/Large), and execution order. Format as a structured markdown document with a title and table or numbered list." > $@


clean:
	rm -f quality.md perf.md security.md \
	      quality.sum.md perf.sum.md security.sum.md \
	      concatenated.md refined.md action.plan.md
