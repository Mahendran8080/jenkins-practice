## `src/scanner.js`

### Purpose
`scanner.js` is a small utility module that scans the project’s `src` directory for all JavaScript source files and returns their file paths and contents.  
It is typically used by build scripts, linters, or documentation generators that need to process every `.js` file in the codebase.

### Main Function: `getCodeFiles()`

| Feature | Description |
|---------|-------------|
| **Async** | Returns a `Promise` that resolves to an array of file objects. |
| **File discovery** | Uses the `glob` package to match `src/**/*.js` while excluding any files inside `node_modules`. |
| **Content reading** | For each matched file, reads its contents synchronously with `fs.readFileSync` and attaches it to the result object. |
| **Return shape** | `[{ path: string, content: string }, …]` – each object contains the relative path and the file’s source code. |

```js
// scanner.js
import { glob } from 'glob';
import fs from 'fs';

export async function getCodeFiles() {
    // Scans all .js files in 'src', ignoring node_modules
    const files = await glob('src/**/*.js', { ignore: 'node_modules/**' });

    return files.map(file => ({
        path: file,
        content: fs.readFileSync(file, 'utf-8')
    }));
}
```

### How It Works
1. **Glob Pattern** – `src/**/*.js` matches every `.js` file under `src`, recursively.
2. **Ignore Rule** – `node_modules/**` prevents scanning third‑party code.
3. **File Mapping** – Each file path is turned into an object containing:
   * `path`: the file’s relative path.
   * `content`: the file’s text content (UTF‑8).

### Usage Example

```js
// example.js
import { getCodeFiles } from './src/scanner.js';

(async () => {
  try {
    const files = await getCodeFiles();

    // Log each file’s path and first 80 characters of its content
    files.forEach(({ path, content }) => {
      console.log(`--- ${path} ---`);
      console.log(content.slice(0, 80));
    });
  } catch (err) {
    console.error('Error scanning code files:', err);
  }
})();
```

> **Note**: The function reads files synchronously (`fs.readFileSync`) after the async glob operation. This is acceptable for small to medium projects; for very large codebases consider using `fs.promises.readFile` to avoid blocking the event loop.

### Dependencies
- `glob` – for pattern‑based file discovery.
- Node’s built‑in `fs` module – for reading file contents.

---