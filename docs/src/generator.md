# `src/generator.js`

## Purpose

`generator.js` is a lightweight helper that automates the creation of Markdown‑style documentation for any JavaScript file.  
It leverages the **OpenAI GPT** API (via the Hugging Face router) to ask the model to produce a clear, concise README section that includes:

1. The file’s purpose  
2. A high‑level overview of its main functions and logic  
3. A short usage example (if applicable)

This file is intended to be used as part of a larger documentation pipeline or as a quick helper when you need to generate documentation on the fly.

---

## Main Functions & Logic

| Function | Description |
|----------|-------------|
| `generateDoc(fileName, codeContent)` | **Async** – Sends a prompt to the OpenAI model and returns the generated Markdown. |
| `client` | An `OpenAI` client configured to use the Hugging Face endpoint (`https://router.huggingface.co/v1`) and your personal Hugging Face token (`config.hfToken`). |

### How it works

1. **Prompt Construction**  
   The function builds a prompt that tells the model to act as a technical writer and produce a README section for the supplied file.  
   ```js
   const prompt = `You are a Technical Writer. Write a clear Markdown README section for the file: ${fileName}.\n...`;
   ```

2. **API Call**  
   The prompt is sent to the `openai/gpt-oss-safeguard-20b:groq` model with a low temperature (`0.3`) to keep the output deterministic.  
   ```js
   const response = await client.chat.completions.create({
     model: "openai/gpt-oss-safeguard-20b:groq",
     messages: [
       { role: "system", content: "You generate high-quality technical documentation in Markdown format." },
       { role: "user", content: prompt }
     ],
     temperature: 0.3,
   });
   ```

3. **Error Handling**  
   If the request fails, the function logs the error and returns a placeholder Markdown indicating that auto‑generation failed.

---

## Usage Example

```js
import { generateDoc } from "./generator.js";
import fs from "fs/promises";

async function main() {
  const fileName = "src/utils/math.js";
  const codeContent = await fs.readFile(fileName, "utf8");

  const doc = await generateDoc(fileName, codeContent);

  console.log(doc);
}

main().catch(console.error);
```

**Result (sample output)**

```markdown
## Documentation for src/utils/math.js

### Purpose
This module provides a collection of mathematical helper functions used throughout the project.

### Main Functions
- `add(a, b)` – Returns the sum of two numbers.
- `multiply(a, b)` – Returns the product of two numbers.
- `factorial(n)` – Computes the factorial of a non‑negative integer.

### Usage Example
```js
import { add, multiply } from "./utils/math.js";

console.log(add(2, 3));      // 5
console.log(multiply(4, 5)); // 20
```
```

> **Note**: Replace `config.hfToken` with your own Hugging Face API token in `src/config.js` before running.

---