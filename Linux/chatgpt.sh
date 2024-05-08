cd $HOME
# api gpt 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
export OPENAI_API_KEY=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
env
source $HOME/.bashrc
env

curl -sSL https://raw.githubusercontent.com/aandrew-me/tgpt/main/install | \
  bash -s /usr/local/bin

tgpt -u # for update

sudo tee -a /usr/local/bin/proxy.txt <<< \
'https://slaweekq:88C1mgzd1Q[@164.90.207.152:3128
'
# --model "gpt-3.5-turbo"
# --provider openai
# -i, --interactive
# -m, --multiline
# -s, --shell Generate and Execute shell commands. (Experimental)
# -c, --code Generate Code. (Experimental)

tgpt \
  --provider opengpts \
  --key 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 \
  --max_length 100000000

# sudo rm $(which tgpt) # for remove
# cd ~/.config/tgpt # location config file

# tgpt "What is internet?" # 1 question
# tgpt -m # start multiline chat with gpt bot and use tab for quetions
# tgpt -i # start one line interactive mod chat with gpt
# tgpt -s "How to update my system?" # create shell command and start it
# tgpt -c or -code # use for generate code
# tgpt --provider opengpts "What is 1+1"
# tgpt --provider openai --key "sk-xxxx" --model "gpt-3.5-turbo" "What is 1+1"
# cat install.sh | tgpt "Explain the code"

# Usage: tgpt [Flags] [Prompt]

# Flags:
# -s, --shell                                        Generate and Execute shell commands. (Experimental)
# -c, --code                                         Generate Code. (Experimental)
# -q, --quiet                                        Gives response back without loading animation
# -w, --whole                                        Gives response back as a whole text
# -img, --image                                      Generate images from text
# --provider                                         Set Provider. Detailed information has been provided below

# Some additional options can be set. However not all options are supported by all providers. Not supported options will just be ignored.
# --model                                            Set Model
# --key                                              Set API Key
# --temperature                                      Set temperature
# --top_p                                            Set top_p
# --max_length                                       Set max response length

# Options:
# -v, --version                                      Print version
# -h, --help                                         Print help message
# -i, --interactive                                  Start normal interactive mode
# -m, --multiline                                    Start multi-line interactive mode
# -cl, --changelog                                   See changelog of versions
# -u, --update                                       Update program

# Providers:
# The default provider is opengpts which uses 'GPT-3.5-turbo' model.
# Available providers to use: openai, opengpts, koboldai, phind, llama2, blackboxai

# Provider: openai
# Needs API key to work and supports various models

# Provider: opengpts
# Uses gpt-3.5-turbo only. Do not use with sensitive data

# Provider: koboldai
# Uses koboldcpp/HF_SPACE_Tiefighter-13B only, answers from novels

# Provider: phind
# Uses Phind Model. Great for developers

# Provider: llama2
# Llama 2 is an open source large language model (LLM) developed by Meta AI. Uses llama2-70b by default. Supports other models.

# Provider: blackboxai
# Uses BlackBox model. Great for developers
