# ask
A minimal Bash CLI tool that sends prompts to any OpenAI-compatible LLM API using `curl` and `jq`.
## Dependencies
- `curl`
- `jq`
## Setup
```bash
export ASK_API_URL="https://api.groq.com/openai/v1/chat/completions"
export ASK_MODEL="llama-3.3-70b-versatile"
export ASK_API_KEY="your_api_key_here"
chmod +x ask
```
## Usage
```bash
./ask "What is the capital of France?"
./ask "Establishment dates of" "Turkey" "Azerbaijan" "Japan"
cat script.sh | ./ask "Explain what this script does:"
./ask "explain this:" "$(uname -a)"
```
## Known Limitations
- Each call is independent meaning the tool has no memory of previous prompts
- ASK_API_URL, ASK_MODEL, and ASK_API_KEY must be set before use
- The full response is received before printing, there is no streaming
- Response speed and availability depend on the API provider
