return {
  "gerazov/ollama-chat.nvim",
  enable = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  -- lazy load on command
  cmd = {
    "OllamaQuickChat",
    "OllamaCreateNewChat",
    "OllamaContinueChat",
    "OllamaChat",
    "OllamaChatCode",
    "OllamaModel",
    "OllamaServe",
    "OllamaServeStop"
  },

  keys = {},

  opts = {
    chats_folder = vim.fn.stdpath("data"), -- data folder is ~/.local/share/nvim
    -- you can also choose "current" and "tmp"
    quick_chat_file = "ollama-chat.md",
    animate_spinner = true,  -- set this to false to disable spinner animation
    model = "llama3.1",
    model_code = "codellama",
    url = (os.getenv("OLLAMA_HOST") or "127.0.0.1") .. ":" .. tonumber(os.getenv("OLLAMA_PORT") or 11434),
    serve = {
      on_start = false,
      command = "ollama",
      args = { "serve" },
      stop_command = "pkill",
      stop_args = { "-SIGTERM", "ollama" },
    },
  }
}
