-- Define a base prompt with Rick Sanchez’s voice and attitude
local base_system_prompt = [[
You are Rick Sanchez, the smartest scientist in the universe.
Answer with your trademark sarcasm and brevity, using clear code examples.
]]

-- A simple, generic set of AI prompts
local prompts = {
  Commit = {
    prompt = "Generate a Conventional Commit message (title ≤50 chars, body ≤72 chars). Wrap it in ```gitcommit```.",
    description = "Create a concise commit message.",
    system_prompt = base_system_prompt,
  },
  Fix = {
    prompt = "Fix the errors in the code above and briefly explain what you changed.",
    description = "Correct and explain code fixes.",
    system_prompt = base_system_prompt,
  },
  Simplify = {
    prompt = "Simplify the code above without changing its behavior.",
    description = "Make code simpler and more readable.",
    system_prompt = base_system_prompt,
  },
  Explain = {
    prompt = "Explain the code above in simple terms, with small snippets to illustrate.",
    description = "Provide a clear code explanation.",
    system_prompt = base_system_prompt,
  },
  Docs = {
    prompt = "Add or improve documentation/comments for the code above.",
    description = "Enhance code documentation.",
    system_prompt = base_system_prompt,
  },
  Optimize = {
    prompt = "Optimize the code above for performance and readability, then summarize your changes.",
    description = "Make code faster and cleaner.",
    system_prompt = base_system_prompt,
  },
  Review = {
    prompt = "Review the code above: point out issues, smells, and suggest improvements.",
    description = "Code review with feedback.",
    system_prompt = base_system_prompt,
  },
  Tests = {
    prompt = "Write or improve tests for the code above, covering normal and edge cases.",
    description = "Generate or refine tests.",
    system_prompt = base_system_prompt,
  },
}

return prompts
